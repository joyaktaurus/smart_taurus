
import 'package:dio/dio.dart';
import '../models/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/local_store.dart';
import '../utils/mydio.dart';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;


abstract class LoginServices {
  static Future<ApiResp> fetchUser(String username, String password, File selfiepic,
      String latitude, String longitude, String place
      ) async {
    dynamic resp;
    await errMAsync(
          () async {
        FormData formData = FormData.fromMap({
          'username': username,
          'password': password,
          'selfiepic': await MultipartFile.fromFile(selfiepic.path, filename: selfiepic.path.split('/').last),
          'latitude': latitude,
          'longitude': longitude,
          'place': place,
        });

        resp = await MyDio().customPost(
          ApiPaths.login,
          data: formData,
        );
      },
      title: 'Login Failed',
    );

    ApiResp respNew = resp is DioError
        ? ApiResp(ok: false, rdata: null, msgs: [], message: '')
        : ApiResp(ok: true, rdata: resp, msgs: [], message: '');

    return respNew;
  }
}
