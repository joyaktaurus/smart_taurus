import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../app.dart';
import '../models/api_msg.dart';
import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';


class AddOrderSubmitServices {
  static Future<ApiResp> fetchUser({
    required int shop_id,
    required int total,
    required String product_names,
    required String product_qtys,
    required String product_ids,
    required String product_amts,
    String? payment_status,
    String? payment_method,
    String? cheque_number,
    String? cheque_date,
  }) async {
    try {
      String token = "${App.user.apiToken}";

      // Correctly format URL with proper separators
      String url = "${ApiPaths.AddOrderSubmit}?"
          "shop_id=$shop_id"
          "&total=$total"
          "&product_names=${Uri.encodeComponent(product_names)}"
          "&product_ids=${Uri.encodeComponent(product_ids)}"
          "&product_qtys=${Uri.encodeComponent(product_qtys)}"
          "&product_amts=${Uri.encodeComponent(product_amts)}"
          "&payment_status=${Uri.encodeComponent(payment_status ?? '')}"
          "&payment_method=${Uri.encodeComponent(payment_method ?? '')}"
          "&cheque_number=${Uri.encodeComponent(cheque_number ?? '')}"
          "&cheque_date=${Uri.encodeComponent(cheque_date ?? '')}";

      dynamic resp;

      await errMAsync(() async {
        resp = await MyDio().markPost(
          url,
          options: Options(
            headers: {
              'Authorization': 'Token $token',
              'Content-Type': 'application/json',
            },
          ),
        );
      }, title: 'Submit Order Failed');

      if (resp is DioError) {
        log('Error type >>> ${resp.type}');
        log('Error response >>> ${resp.response?.data}');
        return ApiResp(ok: false, rdata: "", msgs: [], message: 'Order submission failed');
      } else {
        return resp != null
            ? ApiResp(ok: true, rdata: resp, msgs: [], message: '')
            : ApiResp(ok: false, rdata: "", msgs: [], message: '');
      }
    } catch (e) {
      print('Error during fetchUser: $e');
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [],
        message: 'Order submission failed',
      );
    }
  }
}



// class AddOrderSubmitServices {
//   static Future<ApiResp> fetchUser({
//     required int shop_id,
//     required int total,
//     required String product_names,
//     required String product_qtys,
//     required String product_ids,
//     required String product_amts,
//     String? payment_status,
//     String? payment_method,
//     String? cheque_number,
//     String? cheque_date,
//     // String? card_number,
//     // String? gpay_transaction_id,
//   }) async {
//     try {
//       String token = "${App.user.apiToken}"; // Fetch the token
//       dynamic resp;
//
//       // Prepare query parameters as part of the URL
//       String url = "${ApiPaths.AddOrderSubmit}?"
//           "shop_id=$shop_id&&total=$total&&"
//           "product_names=$product_names&&product_ids=$product_ids&&"
//           "product_qtys=$product_qtys&&product_amts=$product_amts"
//           "payment_status=$payment_status&&payment_method=$payment_method"
//           "cheque_number=$cheque_number&&cheque_date=$cheque_date";
//         //  "card_number=$card_number&&gpay_transaction_id=$gpay_transaction_id";
//
//
//       await errMAsync(() async {
//         resp = await MyDio().markPost(
//           url,
//           options: Options(
//             headers: {
//               'Authorization': 'Token $token',
//               'Content-Type': 'application/json',
//             },
//           ),
//         );
//       }, title: 'Submit Order Failed');
//
//       if (resp is DioError) {
//         log('Error type >>> ${resp.type}');
//         log('Error response >>> ${resp.response?.data}');
//         return ApiResp(ok: false, rdata: "", msgs: [], message: 'Order submission failed');
//       } else {
//         return resp != null
//             ? ApiResp(ok: true, rdata: resp, msgs: [], message: '')
//             : ApiResp(ok: false, rdata: "", msgs: [], message: '');
//       }
//     } catch (e) {
//       print('Error during fetchUser: $e');
//       return ApiResp(
//         ok: false,
//         rdata: '',
//         msgs: [],
//         message: 'Order submission failed',
//       );
//     }
//   }
// }

