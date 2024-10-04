import '../models/api_resp.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class EmpDetailServices {
  static Future<ApiResp> fetchEmpDetails(int shopId) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get('https://seowebsites.in/Smart_Taurus/smart_taurus/api/v1/get-employee');
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
