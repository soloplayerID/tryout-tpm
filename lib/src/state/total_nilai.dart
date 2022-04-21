import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/total_nilai.dart';

abstract class TotalNilaiState {
  void refreshData(TotalNilaiModel paketModel);
  void onSuccess(String success);
  void onError(String error);
  void onCheck(String error, int skemaHarga);
  void onCheckStatus(int idMurid, int idTryout, int harga);
  void onCheckStatusSilver(int idMurid, int idTryout, int harga);
  void removeDataBayar(String error);
  void refreshDataBayar(BayarModel bayarModel);
  void onCheckBayar(BayarModel bayarModel);
  void onCheckBayarSilver(BayarModel bayarModel);
}
