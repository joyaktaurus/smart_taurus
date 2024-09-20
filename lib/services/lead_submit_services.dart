import 'dart:developer';

import 'package:dio/dio.dart';

import '../models/api_msg.dart';
import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class ShopRegisterServices {
  static Future<ApiResp> fetchUser({
    String? shopname,
    String? customername,
    String? phonenumber,
    String? email,
    String? organization,
    String? gst_number,
    String? pancard,
    String? category_info,
    String? budget_info,
    String? brand_info,
    String? addressline1,
    String? addressline2,
    String? pincode,
    String? instructions
  }) async {
    try {
      // Obtain the authentication token (you might need to implement this)
      String token = await getToken();

      // Make the API request with the authentication token
      dynamic resp;
      await errMAsync(() async {
        resp = await MyDio().customTravelPost(
          ApiPaths.leadformSubmit,
          data: {
            'shopname': shopname,
            'customername': customername,
            'phonenumber': phonenumber,
            'email': email,
            'organization': organization,
            'gst_number': gst_number,
            'pancard': pancard,
            'category_info': category_info,
            'budget_info': budget_info,
            'brand_info': brand_info,
            'addressline1': addressline1,
            'addressline2': addressline2,
            'pincode': pincode,
            'instructions': instructions
          },
          options: Options(
            headers: {
              'Authorization': 'Token $token',
              'Content-Type': 'application/json',
            },
          ),
        );
      },
          title: 'Travel Details Failed');

      if (resp is DioError) {
        if (resp.response?.statusCode == 400) {
          log('400 >> ${resp.response}');
          showMsg("Invalid Details", "Registration Failed");
        }
        if (resp.type == DioErrorType.connectTimeout) {
          showMsg('Connection timed-out. Check internet connection.', "Registration Failed");
        }
        if (resp.type == DioErrorType.receiveTimeout) {
          showMsg('Unable to connect to the server', "Registration Failed");
        }
        if (resp.type == DioErrorType.other) {
          showMsg('Something went wrong with server communication', "Registration Failed");
        }
      } else {
        return resp != null
            ? ApiResp(
          ok: true,
          rdata: resp,
          msgs: [
            // ApiMsg(
            //   msg: "",
            //   msgType: "",
            //   title: "Success",
            // )
          ],
          message: '',
        )
            : ApiResp(
          ok: false,
          rdata: "",
          msgs: [
            // ApiMsg(
            //   msg: "Server response failed",
            //   msgType: "0",
            //   title: "Failed",
            // )
          ], message: '',
        );
      }
    } catch (e) {
      print('Error during fetchUser: $e');
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [
         // ApiMsg(msg: 'Error during fetchUser: $e', title: 'Error', msgType: '')
        ], message: '',
      );
    }
    // Return a default ApiResp if execution reaches here
    return ApiResp(ok: false, rdata: '', msgs: [], message: '');
  }

  // Placeholder function to obtain the authentication token
  static Future<String> getToken() async {
    // Implement your token retrieval logic here
    return 'YOUR_AUTH_TOKEN';
  }
}



// abstract class ShopRegisterServices {
//   static Future<ApiResp> fetchUser({
//     String? shopname,
//     String? customername,
//     String? phonenumber,
//     String? email,
//     String? organization,
//     String? gst_number,
//     String? pancard,
//     String? category_info,
//     String? budget_info,
//     String? brand_info,
//     String? addressline1,
//     String? addressline2,
//     String? pincode,
//     String? instructions}) async {
//     dynamic resp;
//     await errMAsync(
//           () async {
//         resp = await MyDio().customPost(
//           ApiPaths.leadformSubmit,
//           data: {
//             'shopname': shopname,
//             'customername': customername,
//             'phonenumber': phonenumber,
//             'email': email,
//             'organization': organization,
//             'gst_number': gst_number,
//             'pancard': pancard,
//             'category_info': category_info,
//             'budget_info': budget_info,
//             'brand_info': brand_info,
//             'addressline1': addressline1,
//             'addressline2': addressline2,
//             'pincode': pincode,
//             'instructions': instructions
//           },
//         );
//       },
//       title: 'Shop Register Failed',
//     );
//
//     ApiResp respNew = resp is DioError
//         ? ApiResp(ok: false, rdata: null, msgs: [], message: '')
//         : ApiResp(ok: true, rdata: resp, msgs: [], message: '');
//
//     return respNew;
//   }
// }
