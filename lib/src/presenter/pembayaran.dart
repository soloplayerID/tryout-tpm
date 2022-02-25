import 'dart:convert';

import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/state/bayar.dart';

abstract class PembayaranPresenterAbstract {
  set view(PembayaranState view) {}
  void getHarga(int idskema) {}
  void checkPembayaranStatus(String idBayar) {}
  void checkPembayaran(int idMurid, int idTryout, int harga) {}
  void checkout(int idMurid, int idTryout, String metode, String jumlah) {}
}

class PembayaranPresenter implements PembayaranPresenterAbstract {
  BayarModel _bayarModel = new BayarModel();
  PembayaranState _pembayaranState;
  BayarApi _bayarApi = new BayarApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(PembayaranState view) {
    // ignore: todo
    // TODO: implement view
    this._pembayaranState = view;
    this._pembayaranState.refreshData(this._bayarModel);
  }

  @override
  void checkPembayaranStatus(String idBayar) {
    // this._bayarModel.bayars.clear();
    this._bayarModel.isloading = false;
    this._pembayaranState.refreshData(this._bayarModel);
    this._bayarApi.checkPembayaranStatuss(idBayar).then((value) {
      this._bayarModel.bayars.add(new Bayar(
          amount: value.dataBayar.data.amount,
          bank: value.dataBayar.data.vaNumber[0].bank,
          batasWaktu: value.dataBayar.data.batasWaktu,
          idTryout: value.dataBayar.data.idTryout,
          transactionStatus: value.dataBayar.data.transactionStatus,
          transactionTime: value.dataBayar.data.tanggal,
          vaNumber: value.dataBayar.data.vaNumber[0].vaNumber));
      // this._totalNilaiModel.pakets.add(new TotalNilai(
      //     metodePembayaran: value.dataBayar.metodePembayaran,
      //     jumlahBayar: value.dataBayar.jumlah,
      //     batasWaktu: DateFormat("d, MMMM - y")
      //         .format(DateTime.parse(value.dataBayar.batasWaktu))
      //         .toString()));
      // this._totalNilaiState.refreshData(this._totalNilaiModel);
      this._bayarModel.isloading = false;
      this._pembayaranState.refreshData(this._bayarModel);
      this._pembayaranState.onCheckBayar(this._bayarModel);
    }).catchError((err) {
      this._bayarModel.isloading = false;
      this._pembayaranState.refreshData(this._bayarModel);
      this._pembayaranState.onError(err.toString());
    });
  }

  @override
  void checkout(int idMurid, int idTryout, String metode, String jumlah) {
    print('bayar step:2');
    this._bayarModel.isloading = true;
    this._pembayaranState.refreshData(this._bayarModel);
    // this._pembayaranModel.isloading = true;
    Map param = {
      'id_murid': idMurid,
      'id_tryout': idTryout,
      'metode_pembayaran': metode,
      'jumlah': jumlah
    };
    this._bayarApi.bayarPost(json.encode(param)).then((value) {
      this._pembayaranState.onCheck(idTryout, int.parse(jumlah));
      this._bayarModel.isloading = false;
      this._pembayaranState.refreshData(this._bayarModel);
    }).catchError((err) {
      this._bayarModel.isloading = false;
      this._pembayaranState.refreshData(this._bayarModel);
      this._pembayaranState.onError(err.toString());
    });
  }

  @override
  void getHarga(int idskema) {
    this._bayarApi.hargaGet(idskema).then((value) {
      this._bayarModel.isloading = false;
      this._bayarModel.harga = value.dataBayar[0].harga;
      this._pembayaranState.refreshData(this._bayarModel);
    }).catchError((err) {
      this._bayarModel.isloading = false;
      this._pembayaranState.refreshData(this._bayarModel);
      this._pembayaranState.onError(err.toString());
    });
  }

  @override
  void checkPembayaran(int idMurid, int idTryout, int harga) {
    // this._bayarModel.bayars.clear();
    this._bayarModel.isloading = false;
    this._pembayaranState.refreshData(this._bayarModel);
    this._bayarApi.checkPembayaran(idMurid, idTryout, harga).then((value) {
      this._bayarModel.bayars.add(new Bayar(
          amount: value.dataBayar.jumlah,
          bank: value.dataBayar.metodePembayaran,
          batasWaktu: value.dataBayar.batasWaktu,
          idTryout: value.dataBayar.idTryout,
          transactionStatus: value.dataBayar.status ? 'settlement' : 'pending',
          transactionTime: value.dataBayar.tgl,
          vaNumber: value.dataBayar.vaNumber,
          deepLink: value.dataBayar.deeplink != null ? value.dataBayar.deeplink : null ));
      // this._totalNilaiModel.pakets.add(new TotalNilai(
      //     metodePembayaran: value.dataBayar.metodePembayaran,
      //     jumlahBayar: value.dataBayar.jumlah,
      //     batasWaktu: DateFormat("d, MMMM - y")
      //         .format(DateTime.parse(value.dataBayar.batasWaktu))
      //         .toString()));
      // this._totalNilaiState.refreshData(this._totalNilaiModel);
      this._bayarModel.isloading = false;
      this._pembayaranState.refreshData(this._bayarModel);
      this._pembayaranState.onCheckBayar(this._bayarModel);
    }).catchError((err) {
      this._bayarModel.isloading = false;
      this._pembayaranState.refreshData(this._bayarModel);
      this._pembayaranState.onError(err.toString());
    });
  }
}
