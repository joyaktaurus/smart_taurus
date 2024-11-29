import '../models/api_resp.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class SalesGraphServices {
  static Future<ApiResp> fetchGraphDetails(String startDate, String endDate, String year) async {
    try {
      var resp = await MyDio().get(
          'https://seowebsites.in/Smart_Taurus/smart_taurus/api/v1/get-sales-report-mdy',
          queryParameters: {
            'start_date': startDate,
            'end_date': endDate,
            'year': year,
          }
      );
      return ApiResp(ok: true, rdata: resp.data, msgs: [], message: '');
    } catch (e) {
      return ApiResp(ok: false, msgs: ['Failed to fetch data'], rdata: null, message: '');
    }
  }
}
