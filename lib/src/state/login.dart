import 'package:TesUjian/src/model/login.dart';

abstract class LoginState {
  void refreshData(LoginModel loginModel);
  void onSuccess(String success);
  void onMuridOff(String alert);
  void onError(String error);
}
