import 'package:flutter/material.dart';
import 'package:TesUjian/src/model/detail.dart';
import 'package:TesUjian/src/presenter/detail.dart';
import 'package:TesUjian/src/state/detail.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailPembelian extends StatefulWidget {
  final int id;

  const DetailPembelian({Key key, this.id}) : super(key: key);

  @override
  _DetailPembelianState createState() => _DetailPembelianState(id);
}

class _DetailPembelianState extends State<DetailPembelian>
    with SingleTickerProviderStateMixin
    implements DetailState {
  AnimationController _controller;
  // ignore: unused_field
  int _id;
  DetailModel _detailModel;
  DetailPresenter _detailPresenter;

  _DetailPembelianState(int id) {
    this._id = id;
    _detailPresenter = new DetailPresenter();
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    this._detailPresenter.view = this;
    this._detailPresenter.getDetailPembelian(_id);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Detail Penjualan"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Column(
            children: [
              Text(
                  "Warehouse : ${this._detailModel.detailPembelian.data != null ? this._detailModel.detailPembelian.data.warehouse.name : ''}"),
              SizedBox(
                height: 9,
              ),
              Text(
                  "Faktur : #${this._detailModel.detailPembelian.data != null ? this._detailModel.detailPembelian.data.id : ''}"),
              SizedBox(
                height: 9,
              ),
              Text(
                  "Tanggal : ${this._detailModel.detailPembelian.data != null ? this._detailModel.detailPembelian.data.tanggal : ''}"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onError(String error) {
    Fluttertoast.showToast(
        msg: "$error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void onSuccess(String success) {
    Fluttertoast.showToast(
        msg: "$success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void refreshData(DetailModel detailModel) {
    setState(() {
      this._detailModel = detailModel;
    });
  }
}
