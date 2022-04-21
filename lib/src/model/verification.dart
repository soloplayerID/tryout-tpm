import 'package:TesUjian/src/response/verifications.dart';
import 'package:flutter/material.dart';

class VerificationModel {
  bool isloading = false;
  bool isSuccess = false;
  String code = "";
  final TextEditingController otp = new TextEditingController();
  VerifiyResponse verifiyResponse;
}
