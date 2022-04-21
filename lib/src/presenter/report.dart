// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:convert';

import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/model/overall_stat.dart';
import 'package:TesUjian/src/model/total_nilai_detail.dart';
import 'package:TesUjian/src/model/tryout.dart';
import 'package:TesUjian/src/resources/TryoutApi.dart';
import 'package:TesUjian/src/resources/bayarApi.dart';
import 'package:TesUjian/src/resources/tryoutDetailApi.dart';
import 'package:TesUjian/src/state/report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class ReportPresenterAbstract {
  set view(ReportNilaiState view) {}
  void getData(int idMurid) {}
  void check(int idMurid, int idTryout, int harga) {}
  void getMatpels(int idTryout) {}
  void setMatpel(id, BuildContext context) {}
  void checkPembayaranStatus(String idBayar) {}
  void checkStatus(int idMurid, int idTryout, int harga) {}
}

class ReportPresenter implements ReportPresenterAbstract {
  TotalNilaiDetailModel _totalNilaiModel = new TotalNilaiDetailModel();
  ReportNilaiState _totalNilaiState;
  TryoutDetailsApi _historyTryoutApi = new TryoutDetailsApi();
  BayarApi _bayarApi = new BayarApi();
  TryoutApi _tryoutApi = new TryoutApi();
  TryoutModel _tryoutModel = new TryoutModel();
  BayarModel _bayarModel = new BayarModel();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(ReportNilaiState view) {
    // ignore: todo
    // TODO: implement view
    this._totalNilaiState = view;
    this._totalNilaiState.refreshData(this._totalNilaiModel);
  }

  @override
  void check(int idMurid, int idTryout, int harga) {
    // print('harga :$harga');
    this._tryoutModel.isloading = true;
    this._bayarApi.checkStatus(idMurid, idTryout, harga).then((value) {
      this._tryoutModel.isloading = false;
      if (value == 'false') {
        this._totalNilaiState.onCheck(value, harga);
      } else {
        print('true');
        this._totalNilaiState.onCheckStatus(idMurid, idTryout, harga);
      }
    }).catchError((err) {
      this._totalNilaiState.onError(err.toString());
    });
  }

  @override
  void checkPembayaranStatus(String idBayar) {
    this._tryoutModel.isloading = true;
    print('+++++++pembayaranStatus');
    this._bayarModel.bayars.clear();
    this._bayarApi.checkPembayaranStatuss(idBayar).then((value) {
      this._bayarModel.bayars.add(new Bayar(
          amount: value.dataBayar.data.amount,
          bank: value.dataBayar.data.vaNumber[0].bank,
          batasWaktu: value.dataBayar.data.batasWaktu,
          idTryout: value.dataBayar.data.idTryout,
          transactionStatus: value.dataBayar.data.transactionStatus,
          transactionTime: value.dataBayar.data.tanggal,
          vaNumber: value.dataBayar.data.vaNumber[0].vaNumber));
      this._tryoutModel.isloading = false;
      this._totalNilaiState.onCheckBayar(this._bayarModel);
    }).catchError((err) {
      this._tryoutModel.isloading = false;
      this._totalNilaiState.onError(err.toString());
    });
  }

  @override
  void checkStatus(int idMurid, int idTryout, int harga) {
    this._tryoutModel.isloading = true;
    this._bayarModel.bayars.clear();
    this._totalNilaiState.refreshDataBayar(this._bayarModel);
    // this._totalNilaiState.removeDataBayar('test');

    this._bayarApi.checkPembayaran(idMurid, idTryout, harga).then((value) {
      this._tryoutModel.isloading = false;
      String tanggal = DateFormat("d, MMMM - y")
          .format(DateTime.parse(value.dataBayar.tgl))
          .toString();
      List<String> time = value.dataBayar.batasWaktu.split("T");
      List<String> times = time[1].split(".");
      String batasTanggal = DateFormat("d, MMMM - y")
          .format(DateTime.parse(value.dataBayar.batasWaktu))
          .toString();
      this._bayarModel.bayars.add(new Bayar(
          amount: value.dataBayar.jumlah,
          bank: value.dataBayar.metodePembayaran,
          batasTanggal: batasTanggal,
          batasWaktu: times[0].substring(1, 5),
          idTryout: value.dataBayar.idTryout,
          orderId: value.dataBayar.id,
          status: value.dataBayar.status,
          transactionStatus: 'Pending',
          transactionTime: tanggal,
          deepLink: value.dataBayar.deeplink != null
              ? value.dataBayar.deeplink
              : null,
          vaNumber: value.dataBayar.vaNumber));
      this._tryoutModel.isloading = false;
      this._totalNilaiState.refreshDataBayar(this._bayarModel);
      this._totalNilaiState.onCheckBayar(this._bayarModel);
    }).catchError((err) {
      this._tryoutModel.isloading = false;
      this._totalNilaiState.refreshDataModel(this._tryoutModel);
      this._totalNilaiState.onError(err.toString());
    });
  }

  @override
  void getMatpels(int idTryout) {
    print('getMatpels');
    this._tryoutModel.isloading = true;
    this._tryoutModel.idTryout = idTryout;
    this._totalNilaiState.refreshDataModel(this._tryoutModel);
    this._tryoutApi.getMatpels(idTryout).then((value) {
      this._tryoutModel.tryoutDetailResponse = value;
      this._totalNilaiState.refreshDataModel(this._tryoutModel);
      this._tryoutApi.getInfo(idTryout).then((c) {
        this._tryoutModel.tryoutInfoResponse = c;
        this._tryoutModel.isloading = false;
        this._totalNilaiState.refreshDataModel(this._tryoutModel);
      }).catchError((onError) {
        print(onError.toString());
        print("info");
        this._tryoutModel.isloading = false;
        this._totalNilaiState.refreshDataModel(this._tryoutModel);
      });
    }).catchError((onError) {
      print(onError.toString());
      print("matpels");
      this._tryoutModel.isloading = false;
      this._totalNilaiState.refreshDataModel(this._tryoutModel);
    });
  }

  @override
  void getData(idMurid) {
    // ignore: todo
    // TODO: implement getData
    print(idMurid);
    this._totalNilaiModel.isloading = true;
    this._totalNilaiState.refreshData(this._totalNilaiModel);
    this._historyTryoutApi.getHistoryTryouts(idMurid).then((value) {
      value.data.forEach((element) {
        List<OverallStatModel> overallStat = new List<OverallStatModel>();
        int t = 0;
        int totalBenar = element.totalBenar;
        int totalSalah = element.totalSalah;
        int totalDilewati = element.jumlahSoal - (totalBenar + totalSalah);
        this._totalNilaiModel.paketDetails.add(new TotalNilaiDetail(
            id: element.id,
            namaMatpel: element.nama,
            jumlahSoal: element.jumlahSoal,
            totalBenar: element.totalBenar,
            totalSalah: element.totalSalah,
            totalDilewati: totalDilewati,
            nilai: element.nilai));
        this._totalNilaiModel.overallStat.add(new OverallStatModel(
              namaPelajaran: element.nama,
              jumlahSoal: element.jumlahSoal,
              totalBenar: element.totalBenar,
              totalSalah: element.totalSalah,
              totalDilewati: totalDilewati,
              nilai: element.nilai,
            ));
        t++;
      });
      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.refreshData(this._totalNilaiModel);
    }).catchError((err) {
      print(err.toString());
      this._totalNilaiModel.isloading = false;
      this._totalNilaiState.refreshData(this._totalNilaiModel);
      this._totalNilaiState.onError(err.toString());
    });
  }

  @override
  void setMatpel(id, BuildContext context) {
  }
}
