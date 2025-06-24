import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:get/get.dart';

class ChatController extends GetxController with MessageListener {
  var isLoading = false.obs;
  late User user;
  CometChatMessageListController? messageListState;

  @override
  void onInit() {
    fetchChatScreenData();
    super.onInit();
  }

  @override
  void onTextMessageReceived(TextMessage textMessage) {
    messageListState!.addMessage(textMessage);
  }

  @override
  void onClose() {
    print('on close');
    super.onClose();
  }

  void fetchChatScreenData() {
    isLoading.value = true;
    int accountID = Get.arguments[0];
    String fullName = Get.arguments[1];
    String accountPhoto = Get.arguments[2];
    String status = checkUserOnlineStatus(accountID.toString());
    user = User(
      uid: accountID.toString(),
      avatar: accountPhoto,
      name: fullName,
      status: status,
    );
    CometChat.addMessageListener("listenerId", this);
    isLoading.value = false;
  }

  String checkUserOnlineStatus(String uid) {
    CometChat.getUser(uid, onSuccess: (User user) {
      // Kiểm tra xem user có online hay không
      if (user.status == CometChatUserStatus.online) {
        print('online');
        return "online";
      } else {
        print('offline');
        return "offline";
      }
    }, onError: (CometChatException e) {
      print("Error fetching user status: ${e.message}");
    });
    return "offline";
  }
}
