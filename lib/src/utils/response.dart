// class ApiResponse {
//   String msg = '';
//   int msgCode = 0;
//   dynamic data;
// }

// ApiResponse successMessage({int msgCode = 1, String msg = "Success", data}) {
//   var resp = ApiResponse();
//   resp.msgCode = msgCode;
//   resp.data = data;
//   resp.msg = msg;
//   return resp;
// }

// ApiResponse failureMessage({int msgCode = 0, String msg = "Failure", data}) {
//   var resp = ApiResponse();
//   resp.msgCode = msgCode;
//   resp.data = data;
//   resp.msg = msg;
//   return resp;
// }
class ApiResponse {
  String msg = '';
  int msgCode = 0;
  int? statusCode;
  dynamic data;
}

ApiResponse successMessage({
  int msgCode = 1,
  String msg = "Success",
  statusCode,
  data,
}) {
  var resp = ApiResponse();
  resp.msgCode = msgCode;
  resp.data = data;
  resp.msg = msg;
  resp.statusCode = statusCode;
  return resp;
}

ApiResponse failureMessage(
    {int msgCode = 0, String msg = "Failure", statusCode, data}) {
  var resp = ApiResponse();
  resp.msgCode = msgCode;
  resp.data = data;
  resp.msg = msg;
  resp.statusCode = statusCode;
  return resp;
}
