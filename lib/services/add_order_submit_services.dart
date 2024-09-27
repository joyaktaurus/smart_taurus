import 'dart:developer';

import 'package:dio/dio.dart';

import '../app.dart';
import '../models/api_msg.dart';
import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class AddOrderSubmitServices {
  static Future<ApiResp> fetchUser({
    required int shop_id,
    required int total,
    required List<String> product_names,
    required List<String> product_qtys,
    required List<String> product_ids,
    required List<String> product_amts,
  }) async {
    try {
      String token = "${App.user.apiToken}"; // Fetch the token
      dynamic resp;
      await errMAsync(() async {
        resp = await MyDio().markPost(
          ApiPaths.AddOrderSubmit,
          data: {
            'shop_id': shop_id,
            'total': total,
            'product_names': product_names,
            'product_qtys': product_qtys,
            'product_ids': product_ids,
            'product_amts': product_amts,
          },
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
        // Handle errors as before...
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
        message: '',
      );
    }
    return ApiResp(ok: false, rdata: '', msgs: [], message: '');
  }

  // static Future<String> getToken() async {
  //   return '5bg3scJuvl2tsg3JW3MyeOVh5gjBNZuQHsCJF7wxbLeJAvCBxDH95O699UjoW6oc'; // Replace with actual token retrieval logic
  // }
}
