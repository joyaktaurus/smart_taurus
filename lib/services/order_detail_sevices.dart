import 'package:dio/dio.dart';

import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class OrderDetailServices {
  static Future<ApiResp> fetchOrderDetails(int orderId) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get('https://seowebsites.in/Smart_Taurus/smart_taurus/api/v1/get-order-details?order_id=$orderId');
    });

    return resp != null
        ? ApiResp(
      ok: true,
      rdata: resp,
      msgs: [

      ], message: '',
    )
        : ApiResp(
      ok: false,
      rdata: resp,
      msgs: [

      ], message: '',
    );
  }
}