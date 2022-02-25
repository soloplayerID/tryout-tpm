import 'package:TesUjian/src/model/bayar.dart';

abstract class PembayaranState {
  void refreshData(BayarModel bayarModel);
  void onSuccess(String success);
  void onError(String error);
  void onCheck(int orderId, int jumlah);
  void removeDataBayar(String error);
  void refreshDataBayar(BayarModel bayarModel);
  void onCheckBayar(BayarModel bayarModel);
}
