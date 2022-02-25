
import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/src/model/pilih_sekolah.dart';
import 'package:TesUjian/src/resources/TryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/resources/sekolahApi.dart';
import 'package:TesUjian/src/state/pilih_sekolah.dart';
import 'package:get_storage/get_storage.dart';

abstract class SelectSekolahPresenterAbstract {
  set view(SelectSekolahState view) {}
  void getProv() {}
  void checkTryout(int idPaket, int idJenjang) {}
  void getArea(int idProv) {}
  void getJenjang(int idJenjang) {}
  void getSekolah(int area, int jenjang) {}
  void getSekolahJenjang(int area, int jenjang) {}
}

class SelectSekolahPresenter implements SelectSekolahPresenterAbstract {
  SelectSekolahModel _selectSekolahModel = new SelectSekolahModel();
  SelectSekolahState _selectSekolahState;
  TryoutApi _tryoutApi = new TryoutApi();
  SekolahApi _sekolahApi = new SekolahApi();
  int idTryout = 0;
  int jenjangTujuan = 0;

  @override
  // ignore: avoid_return_types_on_setters
  void set view(SelectSekolahState view) {
    // ignore: todo
    // TODO: implement view
    this._selectSekolahState = view;
    this._selectSekolahState.refreshData(this._selectSekolahModel);
  }

  @override
  void checkTryout(int idPaket, int idJenjang) {

    print('go to check tryout, idPaket&idJenjang: $idPaket||$idJenjang');
    this
        ._tryoutApi
        .checkTryout(GetStorage().read(ID_MURID), idJenjang, idPaket)
        .then((value) {
      print('pengecekan tryout, id tryout:');
      if (value.dataTryout.data.isEmpty) {
        print('paket kosong');
        this._selectSekolahModel.isloading = false;
        this._selectSekolahState.refreshData(this._selectSekolahModel);
      } else {
        print('paket ada');
        print(value.dataTryout.data[0].id);
        this._selectSekolahModel.sekolahTujuanid =
            value.dataTryout.data[0].idSekolahTujuan;
        this.idTryout = value.dataTryout.data[0].id;
        this
            ._selectSekolahState
            .toTryout(GetStorage().read(ID_MURID), idJenjang, idPaket, this._selectSekolahModel.sekolahTujuanid, this.idTryout);
        this._selectSekolahModel.isloading = false;
        this._selectSekolahState.refreshData(this._selectSekolahModel);
      }
    });
  }

  @override
  void getProv() {
    // ignore: todo
    // TODO: implement getSekolah
    this._sekolahApi.getProv().then((value) {
      this._selectSekolahModel.provinsi = value;
      this._selectSekolahState.refreshData(this._selectSekolahModel);
    }).catchError((err) {
      this._selectSekolahState.onError(err.toString());
    });
  }

  @override
  void getArea(int idProv) {
    this._sekolahApi.getArea(idProv).then((value) {
      this._selectSekolahModel.area = value;
      this._selectSekolahState.refreshData(this._selectSekolahModel);
    }).catchError((err) {
      this._selectSekolahState.onError(err.toString());
    });
  }
  @override
  void getJenjang(int idJenjang) {
    switch (idJenjang) {
      case 1:
        this.jenjangTujuan = 2;
        this._sekolahApi.getjenjang(jenjangTujuan).then((value) {
          this._selectSekolahModel.jenjangnya = value;
          this._selectSekolahState.refreshData(this._selectSekolahModel);
        }).catchError((err) {
          this._selectSekolahState.onError(err.toString());
        });
        break;
      case 2:
        this.jenjangTujuan = 3;
        this._sekolahApi.getjenjangBetween(3,8).then((value) {
          this._selectSekolahModel.jenjangnya = value;
          this._selectSekolahState.refreshData(this._selectSekolahModel);
        }).catchError((err) {
          this._selectSekolahState.onError(err.toString());
        });
        break;
      default:
      this._sekolahApi.getjenjangBetween(13, 14).then((value) {
          this._selectSekolahModel.jenjangnya = value;
          this._selectSekolahState.refreshData(this._selectSekolahModel);
        }).catchError((err) {
          this._selectSekolahState.onError(err.toString());
        });
    }
    
  }

  @override
  void getSekolah(int area, int jenjang) {
    this._selectSekolahState.refreshData(this._selectSekolahModel);
    print(jenjang);
    print("+++++++++++");
    print(area);
    this._sekolahApi.getSekolah(area, jenjang).then((value) {
      this._selectSekolahModel.sekolah = value;
      this._selectSekolahModel.isloading = false;
      this._selectSekolahState.refreshData(this._selectSekolahModel);
    }).catchError((err) {
      this._selectSekolahState.onError(err.toString());
    });
  }
  @override
  void getSekolahJenjang(int area, int jenjang) {
    this._selectSekolahModel.isloading = true;
    this._selectSekolahState.refreshData(this._selectSekolahModel);
    print(jenjang);
    print("+++++++++++");
    print(area);
    this._sekolahApi.getSekolah(area, jenjang).then((value) {
      this._selectSekolahModel.sekolah = value;
      this._selectSekolahModel.isloading = false;
      this._selectSekolahState.refreshData(this._selectSekolahModel);
    }).catchError((err) {
      this._selectSekolahState.onError(err.toString());
    });
  }
}
