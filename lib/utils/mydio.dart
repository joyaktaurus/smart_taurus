import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '../app.dart';
import '../models/api_resp.dart';
import '../presets/api_paths.dart';

ApiResp respNew = ApiResp(
  ok: false,
  rdata: null,
  msgs: [], message: '',
);

class MyDio {
  static String baseUrl = ApiPaths.baseUrl;

  late Dio _dio;

  MyDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 500,
      // 30 seconds
      receiveTimeout: 60 * 1000,
      // 60 seconds

      responseType: ResponseType.plain,
      headers: {
        Headers.contentTypeHeader: "application/json",
        if (App.token!.isNotEmpty) "Authorization": "Token ${App.user.apiToken}",
      },
    );

    _dio = Dio(options);

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
  }
  Future<dynamic> customget(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      Response resp = await _dio.get(baseUrl + path,
          options: Options(
            responseType: ResponseType.plain,
            headers: {
              Headers.contentTypeHeader: "application/json",
              "Token": "${App.user.apiToken}"
            },
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp;
      if (resp.data.toString().isNotEmpty) {
        apiResp = jsonDecode(resp.data);
      }
      return apiResp;
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());

      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        // ignore: avoid_print
        print(path);
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      Response resp = await _dio.get(
          path,
          queryParameters: queryParameters,
          options: Options(
              responseType: ResponseType.plain,
              headers: {
                Headers.contentTypeHeader: "application/json",
                "Token": "${App.user.apiToken}"
              }
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp;
      if (resp.data.toString().isNotEmpty) {
        apiResp = jsonDecode(resp.data);
      }
      return apiResp;
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());

      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        // ignore: avoid_print
        print(path);
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<dynamic> customPost(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      Response resp = await _dio.post(
        path,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
          responseType: ResponseType.json,
          headers: {
            if (App.token.isNotEmpty) "Authorization": "Token ${App.user.apiToken}",
          },
        ),
      );

      log('Response Data: ${resp.data}');
      return resp.data;
    } on DioError catch (ex) {
      log("Error: ${ex.response?.data}");
      throw ex;
    }
  }
  Future<dynamic> customTravelPost(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      Response resp = await _dio.post(
        baseUrl + path,
        data: data,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            Headers.contentTypeHeader: "application/json",
            "Token": "${App.user.apiToken}"
          },
        ),
      );

      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint("REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }

      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");

      dynamic apiResp = jsonDecode(resp.data);
      return apiResp;
    } on DioError catch (ex) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint("REQUEST[${ex.response?.statusCode}] => PATH: ${ex.requestOptions.path}");
      debugPrint("ResMethodType : [${ex.requestOptions.method}]");
      ex.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      ex.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(ex.requestOptions.queryParameters.toString());

      if (ex.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(ex.requestOptions.data)}");
      }

      log('error type >>>${ex.type}');
      debugPrint("************** Error End ************************");

      // Instead of returning the exception, create a consistent error response
      return {
        'error': 'DioError',
        'message': ex.message,
        'type': ex.type.toString(),
        // You may include additional error details if needed
      };
    }
  }

  Future<dynamic> markPost(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {

      Response resp = await _dio.post(baseUrl + path,
          data: data,
          queryParameters: queryParameters,
          options: Options(
              responseType: ResponseType.plain,
              headers: {
                Headers.contentTypeHeader: "application/json",
                "Token": "${App.user.apiToken}"
              }
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp = jsonDecode(resp.data);
      return apiResp;
    } on DioError catch (ex) {
      // nav.Get.to(MAErrorScreenWidget(onRetry: () {}));
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${ex.response?.statusCode}] => PATH: ${ex.requestOptions.path}");
      debugPrint("ResMethodType : [${ex.requestOptions.method}]");
      ex.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      ex.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(ex.requestOptions.queryParameters.toString());

      if (ex.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(ex.requestOptions.data)}");
      }
      log('error type >>>${ex.type}');
      debugPrint("************** Error End ************************");
      if (ex.type == DioErrorType.connectTimeout) {
        throw Exception(ex.message);
      } else {
        return ex;
      }
    }
  }

  Future<dynamic> salesPost(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      // Dio dio = Dio();
      // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //     (HttpClient client) {
      //   client.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) => true;
      //   return null;
      // };

      Response resp = await _dio.post(baseUrl + path,
          data: data,
          queryParameters: queryParameters,
          options: Options(
              responseType: ResponseType.plain,
              headers: {
                Headers.contentTypeHeader: "application/json",
                "Token": "${App.user.apiToken}"
              }
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp = jsonDecode(resp.data);
      return apiResp;
    } on DioError catch (ex) {
      // nav.Get.to(MAErrorScreenWidget(onRetry: () {}));
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${ex.response?.statusCode}] => PATH: ${ex.requestOptions.path}");
      debugPrint("ResMethodType : [${ex.requestOptions.method}]");
      ex.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      ex.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(ex.requestOptions.queryParameters.toString());

      if (ex.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(ex.requestOptions.data)}");
      }
      log('error type >>>${ex.type}');
      debugPrint("************** Error End ************************");
      if (ex.type == DioErrorType.connectTimeout) {
        throw Exception(ex.message);
      } else {
        return ex;
      }
    }
  }


  Future<dynamic> customPatch(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      Response resp = await _dio.patch(baseUrl + path,
          data: data,
          options: Options(
            responseType: ResponseType.plain,
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${resp.requestOptions.data}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp = jsonDecode(resp.data);
      return apiResp;
    } on DioError catch (ex) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${ex.response?.statusCode}] => PATH: ${ex.requestOptions.path}");
      debugPrint("ResMethodType : [${ex.requestOptions.method}]");
      ex.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      ex.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(ex.requestOptions.queryParameters.toString());

      if (ex.requestOptions.data != null) {
        debugPrint("Body: ${ex.requestOptions.data}");
      }
      log('error type >>>${ex.type}');
      debugPrint("************** Error End ************************");
      if (ex.type == DioErrorType.connectTimeout) {
        throw Exception(ex.message);
      } else {
        return ex;
      }
    }
  }

  Future<dynamic> post(String path,
      {data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress}) async {
    try {
      Response resp = await _dio.post(baseUrl + path,
          data: data,
          options: Options(
            responseType: ResponseType.plain,
             headers:
            {
              Headers.contentTypeHeader: "application/json",
              if(App.token.isNotEmpty)
              "Authorization": "Token ${App.user.apiToken}"
            }
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("**************** Response End ************************");
      dynamic apiResp;
      if (resp.data.toString().isNotEmpty) {
        apiResp = jsonDecode(resp.data);
      }
      if (apiResp != null) {
        debugPrint("Response: ${jsonEncode(apiResp)}");
      }
      return apiResp;
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(e.response?.statusMessage.toString());
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());
      if (e.response != null && e.response!.data != null) {
        Map<String, dynamic> errorData = json.decode(e.response!.data);
        debugPrint("errorData:$errorData");
        if (errorData.containsKey('non_field_errors') &&
            errorData['non_field_errors'] is List) {
          List<String> nonFieldErrors =
          errorData['non_field_errors'].cast<String>();
          debugPrint('Non-field errors: ${nonFieldErrors.join(', ')}');
        }
      }
      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());

      throw Exception(e.toString());
    }
  }

  Future<dynamic> put(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      Response resp = await _dio.put(baseUrl + path,
          data: data,
          options: Options(
            responseType: ResponseType.plain,
            //  headers:
            // {
            //   Headers.contentTypeHeader: "application/json",
            //   if(App.token.isNotEmpty)
            //   "Authorization": "Token ${App.user.token}"
            // }
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp;
      if (resp.data.toString().isNotEmpty) {
        apiResp = jsonDecode(resp.data);
      }
      return apiResp;
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());

      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  // Future<dynamic> get(
  //     String path, {
  //       data,
  //       Map<String, dynamic>? queryParameters,
  //       Options? options,
  //       CancelToken? cancelToken,
  //       ProgressCallback? onSendProgress,
  //       ProgressCallback? onReceivedProgress,
  //     }) async {
  //   try {
  //     Response resp = await _dio.get(baseUrl + path,
  //         options: Options(
  //           responseType: ResponseType.plain,
  //         ));
  //     debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
  //     debugPrint(
  //         "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
  //     debugPrint("ResMethodType : [${resp.requestOptions.method}]");
  //     resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));
  //
  //     debugPrint("QueryParameters:");
  //     resp.requestOptions.queryParameters
  //         .forEach((k, v) => debugPrint('$k: $v'));
  //     debugPrint(resp.requestOptions.queryParameters.toString());
  //
  //     if (resp.requestOptions.data != null) {
  //       debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
  //     }
  //     log('resp >>>${resp.data}');
  //     debugPrint("************** Response End ************************");
  //     dynamic apiResp;
  //     if (resp.data.toString().isNotEmpty) {
  //       apiResp = jsonDecode(resp.data);
  //     }
  //     return apiResp;
  //   } on DioError catch (e) {
  //     debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
  //     debugPrint(
  //         "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
  //     debugPrint("ResMethodType : [${e.requestOptions.method}]");
  //     e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));
  //
  //     debugPrint("QueryParameters:");
  //     e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
  //     debugPrint(e.requestOptions.queryParameters.toString());
  //
  //     if (e.requestOptions.data != null) {
  //       debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
  //     }
  //     debugPrint("************** Error End ************************");
  //     if (e.type == DioErrorType.response) {
  //       // ignore: avoid_print
  //       print(path);
  //       throw Exception('No proper response from server');
  //     }
  //     if (e.type == DioErrorType.connectTimeout) {
  //       throw Exception('Connection timed-out. Check internet connection.');
  //     }
  //     if (e.type == DioErrorType.receiveTimeout) {
  //       throw Exception('Unable to connect to the server');
  //     }
  //     if (e.type == DioErrorType.other) {
  //       throw Exception('Something went wrong with server communication');
  //     }
  //     log(e.toString());
  //     throw Exception(e.toString());
  //   }
  // }


  // Future<dynamic> get(
  //     String path, {
  //       data,
  //       Map<String, dynamic>? queryParameters,
  //       Options? options,
  //       CancelToken? cancelToken,
  //       ProgressCallback? onSendProgress,
  //       ProgressCallback? onReceivedProgress,
  //     }) async {
  //   try {
  //     Response resp = await _dio.get(baseUrl + path,
  //         queryParameters: queryParameters,
  //         options: Options(
  //             responseType: ResponseType.plain,
  //             headers: {
  //               Headers.contentTypeHeader: "application/json",
  //               "Token": "${App.user.apiToken}"
  //             }
  //         ));
  //     debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
  //     debugPrint(
  //         "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
  //     debugPrint("ResMethodType : [${resp.requestOptions.method}]");
  //     resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));
  //
  //     debugPrint("QueryParameters:");
  //     resp.requestOptions.queryParameters
  //         .forEach((k, v) => debugPrint('$k: $v'));
  //     debugPrint(resp.requestOptions.queryParameters.toString());
  //
  //     if (resp.requestOptions.data != null) {
  //       debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
  //     }
  //     log('resp >>>${resp.data}');
  //     debugPrint("************** Response End ************************");
  //     dynamic apiResp;
  //     if (resp.data.toString().isNotEmpty) {
  //       apiResp = jsonDecode(resp.data);
  //     }
  //     return apiResp;
  //   } on DioError catch (e) {
  //     debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
  //     debugPrint(
  //         "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
  //     debugPrint("ResMethodType : [${e.requestOptions.method}]");
  //     e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));
  //
  //     debugPrint("QueryParameters:");
  //     e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
  //     debugPrint(e.requestOptions.queryParameters.toString());
  //
  //     if (e.requestOptions.data != null) {
  //       debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
  //     }
  //     debugPrint("************** Error End ************************");
  //     if (e.type == DioErrorType.response) {
  //       // ignore: avoid_print
  //       print(path);
  //       throw Exception('No proper response from server');
  //     }
  //     if (e.type == DioErrorType.connectTimeout) {
  //       throw Exception('Connection timed-out. Check internet connection.');
  //     }
  //     if (e.type == DioErrorType.receiveTimeout) {
  //       throw Exception('Unable to connect to the server');
  //     }
  //     if (e.type == DioErrorType.other) {
  //       throw Exception('Something went wrong with server communication');
  //     }
  //     log(e.toString());
  //     throw Exception(e.toString());
  //   }
  // }

  Future<dynamic> delete(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      Response resp = await _dio.delete(baseUrl + path,
          options: Options(
            responseType: ResponseType.plain,
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      // dynamic apiResp;
      // if (resp.data.toString().isNotEmpty) {
      //   apiResp = jsonDecode(resp.data);
      // }
      // return apiResp;
      if (resp.statusCode == 204 || resp.statusCode == 200) {
        return 'success';
      } else {
        return 'failed';
      }
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());

      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        // ignore: avoid_print
        print("pathhhhhhhhhhh");
        // ignore: avoid_print
        print(path);
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<dynamic> patch(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      Response resp = await _dio.patch(baseUrl + path,
          data: data,
          options: Options(
            responseType: ResponseType.plain,
            //  headers:
            // {
            //   Headers.contentTypeHeader: "application/json",
            //   if(App.token.isNotEmpty)
            //   "Authorization": "Token ${App.user.token}"
            // }
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp;
      if (resp.data.toString().isNotEmpty) {
        apiResp = jsonDecode(resp.data);
      }
      return apiResp;
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());

      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<dynamic> customDelete(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      Response resp = await _dio.delete(path,
          data: data,
          options: Options(
            responseType: ResponseType.plain,
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp = jsonDecode(resp.data);
      return apiResp;
    } on DioError catch (ex) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${ex.response?.statusCode}] => PATH: ${ex.requestOptions.path}");
      debugPrint("ResMethodType : [${ex.requestOptions.method}]");
      ex.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      ex.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(ex.requestOptions.queryParameters.toString());

      if (ex.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(ex.requestOptions.data)}");
      }
      log('error type >>>${ex.type}');
      debugPrint("************** Error End ************************");
      if (ex.type == DioErrorType.connectTimeout) {
        throw Exception(ex.message);
      } else {
        return ex;
      }
    }
  }

  Future<dynamic> fileUpload(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress,
      }) async {
    try {
      Response resp = await _dio.post(baseUrl + path,
          data: data,
          options: Options(responseType: ResponseType.plain,
              //headers: {"Content-Type": "multipart/form-data"}
              // Headers.contentTypeHeader: "application/json",

              headers: {
                Headers.contentTypeHeader: "multipart/form-data",
              }));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      // if (resp.requestOptions.data != null) {
      //   debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      // }
      log('resp >>>${resp.data}');
      debugPrint("************** Response End ************************");
      dynamic apiResp;
      if (resp.data.toString().isNotEmpty) {
        apiResp = jsonDecode(resp.data);
      }
      return apiResp;
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());

      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      log('resp >>>${jsonEncode(e.requestOptions.data)}');
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  //========================================================>

  Future<dynamic> documentpost(String path,
      {data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceivedProgress}) async {
    try {
      Response resp = await _dio.post(baseUrl + path,
          data: data,
          options: Options(
            responseType: ResponseType.bytes,
          ));
      debugPrint("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      debugPrint("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      // log('resp >>>${resp.data}');
      debugPrint("**************** Response End ************************");
      dynamic apiResp;
      if (resp.data.toString().isNotEmpty) {
        apiResp = resp.data;
      }
      if (apiResp != null) {
        debugPrint("Response: ${jsonEncode(apiResp)}");
      }
      return apiResp;
    } on DioError catch (e) {
      debugPrint("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      debugPrint(e.response?.statusMessage.toString());
      debugPrint(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}");
      debugPrint("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => debugPrint('$k: $v'));

      debugPrint("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint(e.requestOptions.queryParameters.toString());
      if (e.response != null && e.response!.data != null) {
        Map<String, dynamic> errorData = json.decode(e.response!.data);
        debugPrint("errorData:$errorData");
        if (errorData.containsKey('non_field_errors') &&
            errorData['non_field_errors'] is List) {
          List<String> nonFieldErrors =
          errorData['non_field_errors'].cast<String>();
          debugPrint('Non-field errors: ${nonFieldErrors.join(', ')}');
        }
      }
      if (e.requestOptions.data != null) {
        debugPrint("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      debugPrint("************** Error End ************************");
      if (e.type == DioErrorType.response) {
        throw Exception('No proper response from server');
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioErrorType.other) {
        throw Exception('Something went wrong with server communication');
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}