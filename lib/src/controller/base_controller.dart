import 'package:qms/src/api_services/app_exceptions.dart';
import 'package:qms/src/widgets/toast_message.dart';

class BaseController {
  void handelError(error) {
    if (error is BadRequestException) {
      var _message = 'Email already registered.';
      ToastMessage.error(_message.toString());
    } else if (error is FetchDataException) {
      var _message = error.message;
      ToastMessage.error('Something went wrong.');
    } else if (error is ApiNotRespondingException) {
      var _message = 'Something went wrong.';
      ToastMessage.error(_message.toString());
    }
  }
}
