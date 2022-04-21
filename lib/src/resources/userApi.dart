// ignore: unused_import
import 'package:TesUjian/src/response/login.dart';
import 'package:http/http.dart' show Client;
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
// ignore: unused_import
import 'package:TesUjian/helper/rijndael.dart';
import 'dart:convert';

class UserApi {
  Client _client = new Client();
  Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  // ignore: missing_return
  Future<LoginResponse> login(String data) async {
    final response = await _client.post(
        Uri.parse("${Paths.BASEURL}${Paths.LOGIN}"),
        body: data,
        headers: _headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      if (res['success']) {
        LoginResponse loginResponse =
            LoginResponse.fromJson(json.decode(response.body));
        return loginResponse;
      } else {
        print('akun tidak ada');
        Future.error("${res['data']}");
      }
    } else {
      Future.error("Yah, Internet kamu error!");
    }
  }
}
