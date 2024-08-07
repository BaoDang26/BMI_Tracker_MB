import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/models/member_model.dart';
import 'package:flutter_health_menu/models/update_profile_model.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:image_picker/image_picker.dart';

import '../config/constants.dart';

class UpdateProfileController extends GetxController {
  var isLoading = true.obs;
  Rx<MemberModel> currentMember = MemberModel().obs;
  RxString birthday = "".obs;
  RxString gender = "".obs;

  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;

  @override
  Future<void> onInit() async {
    await fetchUpdateProfileScreenData();
    super.onInit();
  }

  fetchUpdateProfileScreenData() async {
    // lấy thông tin member từ PrefUtils
    currentMember.value =
        MemberModel.fromJson(jsonDecode(PrefUtils.getString("logged_member")!));

    // tạo controller cho các TextEditing
    fullNameController =
        TextEditingController(text: currentMember.value.fullName);
    phoneNumberController =
        TextEditingController(text: currentMember.value.phoneNumber);

    // gán giá trị cho birthday
    birthday.value = currentMember.value.getBirthday();

    // gán giá trị cho gender
    gender.value = currentMember.value.gender!;
    isLoading.value = false;
  }

  Future<void> getMemberInformation() async {
    var response = await MemberRepository.fetchMemberLogged();
    if (response.statusCode == 200) {
      // reset currentMember
      currentMember.value = MemberModel();

      // convert mdel từ json
      currentMember.value = MemberModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      String message = jsonDecode(response.body)['message'];
      if (message.contains("JWT token is expired")) {
        Get.snackbar('Session Expired', 'Please login again');
      }
    } else {
      Get.snackbar("Error server", json.decode(response.body)['message']);
    }
    isLoading.value = false;
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    // var userUpdate = {
    //   "fullName": fullNameController.text,
    //   "phoneNumber": phoneNumberController.text,
    //   "accountPhoto": currentMember.value.accountPhoto!,
    //   "gender": currentMember.value.gender!,
    //   "birthday": currentMember.value.getBirthday()
    // };
    UpdateProfileModel updateProfile = UpdateProfileModel(
      fullName: fullNameController.text,
      phoneNumber: phoneNumberController.text,
      accountPhoto: currentMember.value.accountPhoto!,
      gender: currentMember.value.gender!,
      birthday: DateTime.parse(birthday.value),
    );

    // gọi repository update profile
    var response = await AccountRepository.updateProfile((updateProfile));

    // kiểm tra kết quả
    log(jsonEncode(response.body));
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      PrefUtils.setString("logged_member", jsonEncode(currentMember.value));
      // convert list exercises from json
      // await updateComet(updateProfile, MemberModel.fromJson());
      Get.snackbar("Edit profile", jsonDecode(response.body)["message"]);
    } else if (response.statusCode == 400) {
      log(jsonDecode(response.body)['message']);
      // thông báo lỗi
      Get.snackbar("Edit failed!", jsonDecode(response.body)["message"]);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }

    // cập nhật lại thông tin member
    currentMember.value = MemberModel();
    await getMemberInformation();
    await updateComet();
    // isLoading.value = false;

    // cập nhật thông tin member ở Homepage
    var homePageController = Get.find<HomePageController>();
    homePageController.currentMember.value = MemberModel();
    homePageController.currentMember.value = currentMember.value;
    homePageController.currentMember.refresh();
    PrefUtils.setString("logged_member", jsonEncode(currentMember.value));

    // Cập nhật thông tin trong Utils
    isLoading.value = false;
  }

  // Hàm chính để chọn và upload ảnh, sau đó cập nhật link ảnh lên server
  Future<void> selectAndUploadImage() async {
    isLoading.value = true;

    final XFile? image = await pickImage(); // Chọn ảnh từ thư viện
    if (image != null) {
      final String? downloadUrl = await uploadImage(
          image); // Upload ảnh lên Firebase Storage và nhận link tải xuống
      if (downloadUrl != null) {
        // Gọi API để cập nhật link ảnh lên server
        await updatePhotoLink(downloadUrl);
        var homePageController = Get.find<HomePageController>();
        homePageController.currentMember.value.accountPhoto =
            currentMember.value.accountPhoto;
        homePageController.currentMember.refresh();
        PrefUtils.setString("logged_member", jsonEncode(currentMember.value));
      } else {
        log('Failed to get download URL'); // Xử lý lỗi nếu không nhận được link tải xuống
      }
    } else {
      log('No image selected'); // Xử lý lỗi nếu không chọn ảnh
    }
    isLoading.value = false;
  }

  // Hàm để chọn ảnh từ thư viện
  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker(); // Khởi tạo ImagePicker
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery); // Chọn ảnh từ thư viện

    return image; // Trả về ảnh đã chọn
  }

// Hàm để upload ảnh lên Firebase Storage và nhận link tải xuống
  Future<String?> uploadImage(XFile image) async {
    try {
      final objectHashCode = currentMember.value.hashCode;
      final fileName = objectHashCode.toRadixString(16);
      // Tham chiếu đến Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      // Tạo đường dẫn để lưu ảnh trong Firebase Storage
      final imageRef = storageRef.child('$fileName.jpg');

      // Upload ảnh lên Firebase Storage
      final uploadTask = imageRef.putFile(File(image.path));
      // Đợi upload hoàn tất
      final snapshot = await uploadTask.whenComplete(() => null);
      // Lấy link tải xuống của ảnh
      final downloadUrl = await snapshot.ref.getDownloadURL();
      // Trả về link tải xuống
      return downloadUrl;
    } catch (e) {
      log('Error uploading image: $e'); // Xử lý lỗi khi upload ảnh
      return null; // Trả về null nếu có lỗi
    }
  }

  Future<void> updatePhotoLink(String photoUrl) async {
    // gọi repository cập nhật link image
    var response = await AccountRepository.updateAccountPhoto(photoUrl);

    if (response.statusCode == 200) {
      // thành công gán giá trị cho member
      currentMember.value.accountPhoto = photoUrl;
      currentMember.refresh();
      await updateComet();
    } else {
      // thât bại show snack bar kết quả
      var jsonResult = jsonDecode(response.body);
      Get.snackbar("Failed upload image", "${jsonResult["message"]}");
    }
  }

  Future<void> updateComet() async {
    CometChat.updateUser(
      User(
          name: currentMember.value.fullName!,
          avatar: currentMember.value.accountPhoto!,
          uid: currentMember.value.accountID.toString()),
      cometRestKey,
      onSuccess: (message) {
        debugPrint('Update successfully: $message');
      },
      onError: (CometChatException ce) {
        debugPrint('Create user failed: ${ce.message}');
      },
    );
  }
}
