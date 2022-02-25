import 'package:TesUjian/src/response/area.dart';
import 'package:TesUjian/src/response/finishPondokDetails.dart';
import 'package:TesUjian/src/response/provinsi.dart';
import 'package:TesUjian/src/response/tryoutDetailPondok.dart';
import 'package:TesUjian/src/response/tryoutdetail.dart';
import 'package:TesUjian/src/response/tryoutinfo.dart';

class TryoutModel {
  bool isloading = false;
  bool isSuccess = false;
  int idArea = 0;
  int idProv = 0;
  int idPaket = 0;
  int jenjang = 0;
  int idMurid = 0;
  int idTryout = 0;
  int silver = 12000;
  int gold = 10000;
  int platinum = 8000;
  bool statusMatpel = false;
  TryoutDetailResponse tryoutDetailResponse = new TryoutDetailResponse();
  TryoutDetailPondokResponse tryoutDetailPondokResponse =
      new TryoutDetailPondokResponse();
  AreaResponse area = new AreaResponse();
  ProvinsiResponse provinsi = new ProvinsiResponse();
  TryoutInfoResponse tryoutInfoResponse = new TryoutInfoResponse();
  FinishPondokDetail finishPondokDetail = new FinishPondokDetail();
}
