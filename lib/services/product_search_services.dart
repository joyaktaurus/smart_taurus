import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class ProductSearchServices {
  static Future<ApiResp> fetchSearchListProduct(String productname) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get(ApiPaths.productSearch,
        queryParameters: {'productname': productname},
      ); });
    respNew = resp != null
        ? ApiResp(
      ok: true,
      rdata: resp,
      msgs: [

      ], message: '',
    )
        : ApiResp(
      ok: false,
      rdata: "",
      msgs: [

      ], message: '',
    );
    return respNew;
  }
}