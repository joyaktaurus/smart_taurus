
import 'package:dio/dio.dart';

import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class ProductServices {
  static Future<ApiResp> getproductList() async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get(ApiPaths.productListing);
    });
    ApiResp respNew = resp is DioError
        ? ApiResp(ok: false, rdata: null, msgs: [], message: '')
        : ApiResp(ok: true, rdata: resp, msgs: [], message: '');

    return respNew;
  }
}