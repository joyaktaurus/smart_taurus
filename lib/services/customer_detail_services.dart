import '../models/api_resp.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class CustomerDetailServices {
  static Future<ApiResp> fetchCustomerDetails(int shopId) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get('https://seowebsites.in/Smart_Taurus/smart_taurus/api/v1/shop-details?shopid=$shopId');
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
