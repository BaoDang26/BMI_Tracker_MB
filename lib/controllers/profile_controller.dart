import 'dart:convert';
import 'dart:io';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_health_menu/controllers/home_page_controller.dart';
import 'package:flutter_health_menu/repositories/member_repository.dart';
import 'package:flutter_health_menu/screens/profile/update_profile_screen.dart';
import 'package:flutter_health_menu/util/app_export.dart';
import 'package:flutter_health_menu/repositories/account_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../models/member_model.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  Rx<MemberModel> currentMember = MemberModel().obs;

  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController genderController;

  @override
  Future<void> onInit() async {
    await fetchProfileScreenData();
    // await getMemberInformation();
    isLoading.value = false;
    super.onInit();
  }

  fetchProfileScreenData() async {
    currentMember.value =
        MemberModel.fromJson(jsonDecode(PrefUtils.getString("logged_member")!));
  }

  getMemberInformation() async {
    var response = await MemberRepository.fetchMemberLogged();
    if (response.statusCode == 200) {
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
    update();
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    var userUpdate = {
      "fullName": fullNameController.text,
      "phoneNumber": phoneNumberController.text,
      "accountPhoto": currentMember.value.accountPhoto!,
      "gender": currentMember.value.gender!,
      "birthday": currentMember.value.getBirthday()
    };
    // gọi repository update profile
    var response = await AccountRepository.updateProfile(userUpdate);

    // kiểm tra kết quả
    if (response.statusCode == 200) {
      // convert list exercises from json
      Get.snackbar("Update profile", jsonDecode(response.body)["message"]);
    } else if (response.statusCode == 400) {
      // thông báo lỗi
      Get.snackbar("Update failed!", jsonDecode(response.body)["message"]);
    } else {
      Get.snackbar("Error server ${response.statusCode}",
          jsonDecode(response.body)['message']);
    }

    // cập nhật lại thông tin member
    await getMemberInformation();

    // cập nhật thông tin member ở Homepage
    var homePageController = Get.find<HomePageController>();
    homePageController.currentMember.value = currentMember.value;

    // Cập nhật thông tin trong Utils
    PrefUtils.setString(
        "logged_member", jsonEncode(currentMember.value.toJson().toString()));

    isLoading.value = false;
  }

  Future<void> logout() async {
    // Alert.showLoadingIndicatorDialog(context);
    PrefUtils.clearPreferencesData();
    await AccountRepository.logout();

    Get.offAllNamed(AppRoutes.loginScreen);
  }

  void goToMyAdvisor() {
    // kiểm tra trạng thái booking
    bool isBooking = PrefUtils.getBool("is_booking")!;
    if (isBooking) {
      Get.toNamed(AppRoutes.advisorBookingDetailsScreen);
    } else {
      Get.snackbar("Not booking", "You haven't booked the advisor's plan yet.");
    }
  }

  void goToBookingHistory() {
    Get.toNamed(AppRoutes.bookingHistoryScreen);
  }

  void goToAnalysis() {}

  void goToFeedback() {
    Get.toNamed(AppRoutes.feedbackScreen);
  }

  goToUpdateProfileScreen() {
    fullNameController =
        TextEditingController(text: currentMember.value.fullName);
    phoneNumberController =
        TextEditingController(text: currentMember.value.phoneNumber);
    genderController = TextEditingController(text: currentMember.value.gender);

    Get.to(() => const UpdateProfileScreen());
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
        currentMember.value.accountPhoto = downloadUrl;
      } else {
        print(
            'Failed to get download URL'); // Xử lý lỗi nếu không nhận được link tải xuống
      }
    } else {
      print('No image selected'); // Xử lý lỗi nếu không chọn ảnh
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
      print('Error uploading image: $e'); // Xử lý lỗi khi upload ảnh
      return null; // Trả về null nếu có lỗi
    }
  }

  Future<void> updatePhotoLink(String photoUrl) async {
    // final response = AccountRepository.updateAccountPhoto(photoUrl);
    // currentMember.value.accountPhoto = photoUrl;
    // if (response.sta == 200) {
    //   print('Photo link updated successfully');
    // } else {
    //   print('Failed to update photo link: ${response.reasonPhrase}');
    // }
  }
}
