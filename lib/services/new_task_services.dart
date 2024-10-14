import 'dart:developer';

import 'package:dio/dio.dart';

import '../models/api_msg.dart';
import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class NewTaskServices {
  static Future<ApiResp> fetchNewTasks({
    String? task,
    String? task_date,

  }) async {
    try {
      // Obtain the authentication token (you might need to implement this)
      String token = await getToken();

      // Make the API request with the authentication token
      dynamic resp;
      await errMAsync(() async {
        resp = await MyDio().customTravelPost(
          ApiPaths.newTask,
          data: {
            'task': task,
            'task_date': task_date,
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
            // ApiMsg(
            //   msg: "",
            //   msgType: "",
            //   title: "Success",
            // )
          ],
          message: '',
        )
            : ApiResp(
          ok: false,
          rdata: "",
          msgs: [
            // ApiMsg(
            //   msg: "Server response failed",
            //   msgType: "0",
            //   title: "Failed",
            // )
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




