// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_health_menu/util/app_export.dart';
// import 'package:flutter_health_menu/widgets/custom_elevated_button.dart';
// import 'package:intl/intl.dart';

// class PaymentSuccessScreen extends StatefulWidget {
//   const PaymentSuccessScreen({super.key});

//   @override
//   State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
// }

// class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
//   late int randomNumber;
//   String orderNumber = '';
//   DateTime transactionDate = DateTime.now();
//   String formattedDate = '';

//   @override
//   void initState() {
//     randomNumber = Random().nextInt(10000);
//     formattedDate = DateFormat('ddMMyyyy').format(transactionDate);
//     orderNumber = '$randomNumber$formattedDate';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     DateTime orderDate = Get.arguments[0];
//     double payAmount = Get.arguments[1];

//     String formattedDate = DateFormat('dd/MM/yyy kk:mm').format(orderDate);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Payment Successfully!',
//           style: TextStyle(color: Colors.green),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             Container(
//               height: 200,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Date',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 15),
//                       ),
//                       Text(
//                         formattedDate,
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Customer',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 15),
//                       ),
//                       // Text(
//                       //   '${loginedUser.fullname}',
//                       //   style: TextStyle(fontSize: 15),
//                       // ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Transaction ID',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 15),
//                       ),
//                       Text(
//                         '#$orderNumber',
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Payment Method',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 15),
//                       ),
//                       Text(
//                         'ZaloPay',
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     thickness: 3,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Total',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                       Text(
//                         '\$$payAmount',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             CustomElevatedButton(
//                 onPressed: () {
//                   Get.offAllNamed(AppRoutes.bottomNavScreen);
//                 },
//                 text: 'Back to Home')
//           ],
//         ),
//       ),
//     );
//   }
// }
