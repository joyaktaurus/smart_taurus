import 'dart:developer';
import 'package:dio/dio.dart';
import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class NewLeadServices {
  static Future<ApiResp> fetchUser({
    String? shop_id,
    String? title,
    String? note,

  }) async {
    try {
      String token = await getToken();
      dynamic resp;
      await errMAsync(() async {
        resp = await MyDio().customTravelPost(
          ApiPaths.NewLead,
          data: {
            'shop_id': shop_id,
            'title': title,
            'note': note,

          },
          options: Options(
            headers: {
              'Authorization': 'Token $token',
              'Content-Type': 'application/json',
            },
          ),
        );
      },
          title: 'Travel Details Failed');

      if (resp is DioError) {
        if (resp.response?.statusCode == 400) {
          log('400 >> ${resp.response}');
          showMsg("Invalid Details", "Registration Failed");
        }
        if (resp.type == DioErrorType.connectTimeout) {
          showMsg('Connection timed-out. Check internet connection.', "Registration Failed");
        }
        if (resp.type == DioErrorType.receiveTimeout) {
          showMsg('Unable to connect to the server', "Registration Failed");
        }
        if (resp.type == DioErrorType.other) {
          showMsg('Something went wrong with server communication', "Registration Failed");
        }
      } else {
        return resp != null
            ? ApiResp(
          ok: true,
          rdata: resp,
          msgs: [
          ],
          message: '',
        )
            : ApiResp(
          ok: false,
          rdata: "",
          msgs: [
          ], message: '',
        );
      }
    } catch (e) {
      print('Error during fetchUser: $e');
      return ApiResp(
        ok: false,
        rdata: '',
        msgs: [
          // ApiMsg(msg: 'Error during fetchUser: $e', title: 'Error', msgType: '')
        ], message: '',
      );
    }
    // Return a default ApiResp if execution reaches here
    return ApiResp(ok: false, rdata: '', msgs: [], message: '');
  }

  // Placeholder function to obtain the authentication token
  static Future<String> getToken() async {
    // Implement your token retrieval logic here
    return 'YOUR_AUTH_TOKEN';
  }
}



