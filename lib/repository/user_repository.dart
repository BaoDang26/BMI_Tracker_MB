// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import '../models/user_model.dart';
// import 'build_server.dart';

// class UserRepository {
//   static final client = http.Client();

//   static Future<String> postLogin(var body, String endpoint) async {
//     try {
//       var response = await client.post(
//         BuildServer.buildUrl(endpoint),
//         body: body,
//         headers: {"Content-type": "application/json"},
//       ).timeout(const Duration(seconds: 30));
//       return response.body;
//     } on TimeoutException catch (e) {
//       return e.toString();
//     }
//   }

//   static loginByGmail(String endpoint) async {
//     var respone = await client.post(
//       BuildServer.buildUrl(endpoint),
//       headers: {"Content-type": "application/json"},
//     );
//     return respone.body;
//   }

//   // static getAllUser(String endpoint) async {
//   //   var response = await client.get(
//   //     BuildServer.buildUrl(endpoint),
//   //   );
//   //   if (response.statusCode == 200) {
//   //     var resultString = response.body;
//   //     return userFromJson(resultString);
//   //   } else {
//   //     return null;
//   //   }
//   // }

//   static registerUser(String endpoint, var body) async {
//     var respone = await client.post(
//       BuildServer.buildUrl(endpoint),
//       body: body,
//       headers: {"Content-type": "application/json"},
//     );
//     return respone.body;
//   }

//   static updateProfile(String endpoint, var body) async {
//     var respone = await client.post(
//       BuildServer.buildUrl(endpoint),
//       body: body,
//       headers: {"Content-type": "application/json"},
//     );
//     return respone.body;
//   }

//   static updatePassword(String endpoint, String newPassword) async {
//     var respone = await client.post(
//       BuildServer.buildUrl(endpoint),
//       body: jsonEncode(<String, String>{
//         "password": newPassword,
//       }),
//       headers: {"Content-type": "application/json"},
//     );
//     return respone.body;
//   }

//   static getUserById(String endpoint) async {
//     var respone = await client.post(
//       BuildServer.buildUrl(endpoint),
//       headers: {"Content-type": "application/json"},
//     );
//     return respone.body;
//   }

//   static sendEmailResetPassword(String endpoint) async {
//     var respone = await client.post(
//       BuildServer.buildUrl(endpoint),
//       headers: {"Content-type": "application/json"},
//     );
//     return respone.body;
//   }
// }
