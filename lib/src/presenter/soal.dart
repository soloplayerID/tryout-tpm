// ignore_for_file: avoid_return_types_on_setters

import 'dart:io';

import 'package:TesUjian/src/model/soal.dart';
import 'package:TesUjian/src/resources/TryoutApi.dart';
import 'package:TesUjian/src/state/soal.dart';

import 'package:http/http.dart' as http;
import 'package:TesUjian/helper/paths.dart';

abstract class SoalPresenterAbstract {
  set view(SoalState view) {}
  void getSoal(int idmatpel, int idTryoutDetail) {}
  void getSoalPsikotes(int idTryoutDetail) {}
  void getSoalImla(int idTryoutDetail) {}
  void getSoalBacaQuran(int idTryoutDetail) {}
  void getSoalHukumTajwids(int idTryoutDetail) {}
  void getSoalHafalanJuz(int idTryoutDetail) {}
  void getSoalAmmaliyah(int idTryoutDetail) {}
  void getSoalQoliyah(int idTryoutDetail) {}
  void getSoalBerhitungSoal(int idTryoutDetail) {}
  void getSoalBerhitungAngka(int idTryoutDetail) {}
  void getSoalBahasaIndonesia(int idTryoutDetail) {}
  void selected(int index) {}
  void jawab(int index) {}
  void submit() {}
  void submitPondok() {}
  void jawabEssay(String jawaban) {}
  void jawabFile(String fileNya, int number) {}
  void jawabFilePsikotes(String fileNya, int number) {}
  void jawabGambar(List<String> jawaban, int number) {}
  void jawabVideo(List<String> jawaban, int number) {}
  void kumpulkan() {}
  void kumpulkanPondok() {}
  void kumpulkanFile() {}
}

class SoalPresenter implements SoalPresenterAbstract {
  // ignore: unused_field
  SoalModel _soalModel = new SoalModel();
  SoalState _soalState;
  // ignore: unused_field
  TryoutApi _tryoutApi = new TryoutApi();
  @override
  void set view(SoalState view) {
    this._soalState = view;
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void getSoal(int idmatpel, int idTryoutDetail) {
    print("=========================getsoal$idmatpel||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idmatpel = idmatpel;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoal(idmatpel, idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalResponse = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalImla(int idTryoutDetail) {
    print("=========================getsoals||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalImla(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalPsikotes(int idTryoutDetail) {
    print("=========================getsoal||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalPsikotes(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalBacaQuran(int idTryoutDetail) {
    print("=========================getsoal||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalBacaQuran(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalAmmaliyah(int idTryoutDetail) {
    print("=========================getsoal||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalAmmaliyah(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalQoliyah(int idTryoutDetail) {
    print("=========================getsoal||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalQoliyah(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalHafalanJuz(int idTryoutDetail) {
    print("=========================getsoal||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalHafalanJuz(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalHukumTajwids(int idTryoutDetail) {
    print("=========================getsoal||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalHukumTajwids(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalBerhitungSoal(int idTryoutDetail) {
    print("=========================getsoal||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalBerhitungSoal(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalBahasaIndonesia(int idTryoutDetail) {
    print("=========================getsoal||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalBahasaIndonesia(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void getSoalBerhitungAngka(int idTryoutDetail) {
    print("=========================getsoal||||$idTryoutDetail");
    this._soalModel.isloading = true;
    this._soalModel.idTryoutDetail = idTryoutDetail;
    this._soalState.refreshData(this._soalModel);
    this._tryoutApi.getSoalBerhitungAngka(idTryoutDetail).then((value) {
      this._soalModel.tryoutSoalPondok = value;
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    }).catchError((onError) {
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
      this._soalState.onError(onError.toString());
    });
  }

  @override
  void selected(int index) {
    this._soalModel.currentIndex = index;
    this._soalModel.jawabanEssay.clear();
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void jawab(int index) {
    this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .jawabanUser =
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .choice[index]
            .choice;
    this
        ._soalModel
        .tryoutSoalResponse
        .dataTryout[this._soalModel.currentIndex]
        .status = true;
    int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
    if ((this._soalModel.currentIndex + 1) < totalSoal) {
      this._soalModel.currentIndex++;
    }
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void jawabEssay(String jawaban) {
    this
        ._soalModel
        .tryoutSoalResponse
        .dataTryout[this._soalModel.currentIndex]
        .jawabanUser = jawaban;
    this
        ._soalModel
        .tryoutSoalResponse
        .dataTryout[this._soalModel.currentIndex]
        .status = true;
    int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
    if ((this._soalModel.currentIndex + 1) < totalSoal) {
      this._soalModel.currentIndex++;
    }
    this._soalModel.jawabanEssay.clear();
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void submit() {
    int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
    if ((this._soalModel.currentIndex + 1) < totalSoal) {
      this._soalModel.currentIndex++;
    }
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void submitPondok() {
    int totalSoal = this._soalModel.tryoutSoalPondok.data.length;
    if ((this._soalModel.currentIndex + 1) < totalSoal) {
      this._soalModel.currentIndex++;
    }
    this._soalState.refreshData(this._soalModel);
  }

  @override
  // Future<void> jawabFile(List<String> jawaban, int number) async {
  Future<void> jawabFile(String fileNya, int number) async {
    this
        ._soalModel
        .tryoutSoalResponse
        .dataTryout[this._soalModel.currentIndex]
        .jawabanUser = fileNya;
    this
        ._soalModel
        .tryoutSoalResponse
        .dataTryout[this._soalModel.currentIndex]
        .statusSoal = number;
    this
        ._soalModel
        .tryoutSoalResponse
        .dataTryout[this._soalModel.currentIndex]
        .status = true;

    this._soalState.refreshData(this._soalModel);
  }

  @override
  // Future<void> jawabFile(List<String> jawaban, int number) async {
  Future<void> jawabFilePsikotes(String fileNya, int number) async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    print('jawabfile ' + fileNya);
    this
        ._soalModel
        .tryoutSoalPondok
        .data[this._soalModel.currentIndex]
        .jawabanUser = fileNya;
    this._soalModel.tryoutSoalPondok.data[this._soalModel.currentIndex].status =
        1;

    this._soalModel.isloading = false;
    this._soalState.refreshData(this._soalModel);
  }

  @override
  void kumpulkan() async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    await Future.forEach(this._soalModel.tryoutSoalResponse.dataTryout,
        (element) async {
      if (element.jawabanUser != null) {
        print(element.idTryoutDetailSoals);
        print(' saveTryoutDetailSoal ');
        Map<String, String> body = <String, String>{
          "id": element.idTryoutDetailSoals.toString(),
          "jawaban_user": element.jawabanUser,
        };
        var a = await this._tryoutApi.kumpulkan(body);
        print(a);
      }
    });
    this._tryoutApi.finishMatpel(this._soalModel.idTryoutDetail).then((value) {
      print('finishMatpel');
    }).catchError((onError) {
      this._soalState.onError(onError.toString());
    });
    this._soalModel.isloading = false;
    this._soalState.refreshData(this._soalModel);
    this._soalState.onSuccess("selesai");
  }

  @override
  void kumpulkanPondok() async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    print("KUMPULKAN Pondok");
    this
        ._tryoutApi
        .finishMatpelPondok(this._soalModel.idTryoutDetail)
        .then((value) {
      print(value);
    }).catchError((onError) {
      this._soalState.onError(onError.toString());
    });
    this._soalModel.isloading = false;
    this._soalState.refreshData(this._soalModel);
    this._soalState.onSuccess("selesai");
  }

  @override
  void kumpulkanFile() async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    await Future.forEach(this._soalModel.tryoutSoalResponse.dataTryout,
        (element) async {
      if (element.jawabanUser != null) {
        print(element.idTryoutDetailSoals);
        print(' hehe ');
        print(element.jawabanUser);
        Map<String, String> body = <String, String>{
          // "id": this._soalModel.idTryoutDetail.toString(),
          "id": element.idTryoutDetailSoals.toString(),
          "jawaban_user": element.jawabanUser,
          "stringFile": element.jawabanUser
        };
        var a = await this._tryoutApi.kumpulkan(body);
        print(a);
      }
    });
    this._tryoutApi.finishMatpel(this._soalModel.idTryoutDetail).then((value) {
      print(value);
    }).catchError((onError) {
      this._soalState.onError(onError.toString());
    });
    this._soalModel.isloading = false;
    this._soalState.refreshData(this._soalModel);
    this._soalState.onSuccess("selesai");
  }

  @override
  Future<void> jawabGambar(List<String> jawaban, int number) async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    // print(jawaban[this._soalModel.currentIndex]);
    final hasil = jawaban.firstWhere(
        (element) => element.endsWith(number.toString() + '.jpg'), orElse: () {
      return null;
    });
    if (hasil == null) {
      this._soalState.onError('jawab dulu pertanyaannya :)');
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    } else {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_KUMPULKAN_V2}"),
      );
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(http.MultipartFile('filename',
          File(hasil).readAsBytes().asStream(), File(hasil).lengthSync(),
          filename: hasil.split("/").last));
      request.headers.addAll(headers);
      request.fields.addAll({
        "id": "$number",
        "jawaban_user": hasil.split("/").last,
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print("This is response:" + respStr.toString());
      if (response.statusCode == 200) {
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .jawabanUser = hasil.split("/").last;
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .status = true;
        int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
        if ((this._soalModel.currentIndex + 1) < totalSoal) {
          this._soalModel.currentIndex++;
        }
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
      } else {
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
        this._soalState.onError("Yah, Internet Kamu error!");
      }
    }
  }

  @override
  Future<void> jawabVideo(List<String> jawaban, int number) async {
    this._soalModel.isloading = true;
    this._soalState.refreshData(this._soalModel);
    // print(jawaban[this._soalModel.currentIndex]);
    final hasil = jawaban.firstWhere(
        (element) => element.endsWith(number.toString() + '.mp4'), orElse: () {
      return null;
    });
    if (hasil == null) {
      this._soalState.onError('jawab dulu pertanyaannya :)');
      this._soalModel.isloading = false;
      this._soalState.refreshData(this._soalModel);
    } else {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_KUMPULKAN_V2}"),
      );
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(http.MultipartFile('filename',
          File(hasil).readAsBytes().asStream(), File(hasil).lengthSync(),
          filename: hasil.split("/").last));
      request.headers.addAll(headers);
      request.fields.addAll({
        "id": "$number",
        "jawaban_user": hasil.split("/").last,
      });
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print("This is response:" + respStr.toString());
      if (response.statusCode == 200) {
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .jawabanUser = hasil.split("/").last;
        this
            ._soalModel
            .tryoutSoalResponse
            .dataTryout[this._soalModel.currentIndex]
            .status = true;
        int totalSoal = this._soalModel.tryoutSoalResponse.dataTryout.length;
        if ((this._soalModel.currentIndex + 1) < totalSoal) {
          this._soalModel.currentIndex++;
        }
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
      } else {
        this._soalModel.isloading = false;
        this._soalState.refreshData(this._soalModel);
        this._soalState.onError("Yah, Internet Kamu error!");
      }
    }
  }
}
