import '../models/api_resp.dart';
import '../models/task_notification_model.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

// abstract class NotificationServices {
//   static Future<ApiResp> fetchUnseenTaskCount(int customerId) async {
//     TaskNotification? taskNotification;
//     await errMAsync(() async {
//       var response = await MyDio().get(
//         'https://seowebsites.in/Smart_Taurus/smart_taurus/api/v1/get-newtask-count',
//       );
//       taskNotification = TaskNotification.fromJson(response);
//     });
//     return taskNotification != null
//         ? ApiResp(ok: true, rdata: taskNotification, msgs: [], message: '')
//         : ApiResp(ok: false, rdata: null, msgs: [], message: 'Error fetching notifications');
//   }
// }


abstract class NotificationServices {
  static Future<ApiResp> fetchUnseenTaskCount(int customer_id) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get('https://seowebsites.in/Smart_Taurus/smart_taurus/api/v1/get-newtask-count?customer_id=$customer_id');
    });
    return resp != null
        ? ApiResp(
      ok: true,
      rdata: resp,
      msgs: [],
      message: '',
    )
        : ApiResp(
      ok: false,
      rdata: resp,
      msgs: [],
      message: '',
    );
  }
}

