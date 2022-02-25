import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/tryout.dart';
import 'package:flutter/widgets.dart';

abstract class TryoutState {
  void refreshData(TryoutModel tryoutModel);
  void refreshDataBayar(BayarModel bayarModel);
  void onSuccess(String success);
  void onError(String error);
  void onCheck(String error, int skemaHarga);
  void onCheckMatpelStatus(bool statusMatpel, int indexs);
  void onCheckMatpelStatusPondok(int statusMatpel, int indexs);
  void onCheckStatusSilver(int idMurid, int idTryout, int harga);
  void onCheckStatus(int idMurid, int idTryout, int harga);
  void showMatpel(BuildContext context);
  void onCheckBayarSilver(BayarModel bayarModel);
  void onCheckBayar(BayarModel bayarModel);
  void refreshTampilan();
  void selectAreaTujuan();
}
