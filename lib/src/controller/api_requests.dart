import 'dart:convert';
import 'dart:io';
import 'package:qms/src/controller/base_controller.dart';
import 'package:qms/src/models/login_model.dart';
import 'package:qms/src/utils/response.dart';
import '../api_services/base_client.dart';
import 'package:http/http.dart' as http;

class ApiRequest with BaseController {
  Future<ApiResponse> userLogin(Map map) async {
    ApiResponse response =
        await BaseClient().postLogin('/api/user/login/', map);
    print("Response from api request ::${response.data.toString()} ");
    return response;
  }

  // Future<dynamic>? createUser(Map map) async {
  //   HttpResponse? response =
  //       await BaseClient().postData('/api/user/', map).catchError(handelError);
  //   if (response!.statusCode == 200) {
  //     return response;
  //   } else {
  //     return null;
  //   }
  // }

  // Future<LoginModel?> userLogin(Map map) async {
  //   var response = await BaseClient()
  //       .postSign('/api/user/login/', map)
  //       .catchError(handelError);
  //   if (response == null) return null;
  //   LoginModel result = LoginModel.fromJson(json.decode(response.data));
  //   return result;
  // }

  // userDetail() async {
  //   var response = await BaseClient().get('/api/user/').catchError(handelError);
  //   print(response);
  // }
}
