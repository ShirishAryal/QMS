// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qms/src/api_services/app_exceptions.dart';
import 'package:qms/src/utils/response.dart';
import 'package:qms/src/widgets/toast_message.dart';

class BaseClient {
  static const int TIME_OUT_DURATION = 20;
  static const _baseUrl = 'https://questms.herokuapp.com';
  static const token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjU0Mjc4NjYzLCJpYXQiOjE2NTQwMTk0NjMsImp0aSI6ImZkM2ZlNDA0NDU2NDRiNDk4ZTMwMTk3ODczNTNhNGUzIiwiZW1haWwiOiJhYmNAZ21haWwuY29tIiwidXNlcl9pZCI6MSwicm9sZSI6Mn0.fb4xAt-Y4egXJDcBAAFNK3iPWX_keMonQHdIlfm1Jho';

  //Login method
  Future<dynamic> postLogin(String api, var data) async {
    var uri = Uri.parse(_baseUrl + api);
    try {
      var response = await http
          .post(uri, body: data)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      ApiResponse apiResponse = parseResponse(
        response,
      );
      return apiResponse;
    } on SocketException {
      ApiResponse apiResponse = parseResponse(null, 'No internet connection');

      return apiResponse;
    } on TimeoutException {
      ApiResponse apiResponse = parseResponse(null, 'Response timeout');
      return apiResponse;
    }
  }

  //GET
  // Future<dynamic> get(String api) async {
  //   var uri = Uri.parse(_baseUrl + api);
  //   try {
  //     print('api requested');
  //     var response = await http.get(
  //       uri,
  //       headers: {
  //         "Content-Type": "application/json",
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(Duration(seconds: TIME_OUT_DURATION));

  //     return _processResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet Connection', uri.toString());
  //   } on TimeoutException {
  //     throw ApiNotRespondingException(
  //         'API not responded in time', uri.toString());
  //   }
  // }

  //POST Method
  // Future<ApiResponse> postSign(String api, var payloadObj) async {
  //   var uri = Uri.parse(_baseUrl + api);
  //   try {
  //     var response = await http
  //         .post(uri, body: payloadObj)
  //         .timeout(Duration(seconds: TIME_OUT_DURATION));
  //     return _processResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet Connection', uri.toString());
  //   } on TimeoutException {
  //     throw ApiNotRespondingException(
  //         'API not responded in time', uri.toString());
  //   }
  // }

  // Future<dynamic> postData(String api, var payloadObj) async {
  //   var uri = Uri.parse(_baseUrl + api);
  //   try {
  //     var response = await http
  //         .post(uri, body: payloadObj)
  //         .timeout(const Duration(seconds: TIME_OUT_DURATION));
  //     print(response.statusCode);
  //     print(response.body);
  //     return _processResponse(response);
  //   } on SocketException {
  //     throw FetchDataException('No Internet Connection', uri.toString());
  //   } on TimeoutException {
  //     throw ApiNotRespondingException(
  //         'API not responded in time', uri.toString());
  //   }
  // }

  // _processResponse(http.Response response) {s

  // static ApiResponse parseResponse(http.Response resp) {
  //   if (resp.statusCode >= 200 && resp.statusCode <= 300) {
  //     try {
  //       var x = json.decode(resp.body);

  //       if (x is String) {
  //         return successMessage(msg: resp.body);
  //       } else {
  //         try {} finally {}
  //         return successMessage(data: x);
  //       }
  //     } catch (error) {
  //       print(error.toString());
  //     }
  //   }
  //   var x = json.decode(resp.body);
  //   return failureMessage(data: x);
  // }
  static ApiResponse parseResponse(http.Response? resp, [String? msg]) {
    if (resp == null) {
      return failureMessage(data: null, statusCode: -1, msg: msg!);
    } else {
      if (resp.statusCode >= 200 && resp.statusCode <= 300) {
        return successMessage(
            data: jsonDecode(resp.body), statusCode: resp.statusCode);
      } else if (resp.statusCode == 401) {
        return failureMessage(
            data: jsonDecode(resp.body),
            statusCode: resp.statusCode,
            msg: 'Invalid Credentials!!');
      } else {
        return failureMessage(
            data: jsonDecode(resp.body), statusCode: resp.statusCode);
      }
    }
  }
}

// class _AuthData {
//   String token, refreshToken;
//   _AuthData(this.token, this.refreshToken);
//   Map<String, dynamic> toJson() {
//     final Map
//   }
// }
