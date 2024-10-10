import 'package:dio/dio.dart';

import '../models/api_msg.dart';
import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';


abstract class OrderStatusServices {
  static Future<ApiResp> getOrderList() async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get(ApiPaths.orderListing);
    });
    ApiResp respNew = resp is DioError
        ? ApiResp(ok: false, rdata: null, msgs: [], message: '')
        : ApiResp(ok: true, rdata: resp, msgs: [], message: '');

    return respNew;
  }
}
