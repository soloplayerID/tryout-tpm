// ignore_for_file: deprecated_member_use

import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/screen/fragment/tagihan/pembayaran_bayar.dart';
import 'package:TesUjian/src/model/bayar.dart';
import 'package:TesUjian/src/presenter/pembayaran.dart';
import 'package:TesUjian/src/state/bayar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'fragment/tagihan/webview_gopay.dart';

class CheckoutScreen extends StatefulWidget {
  final int idTryout;
  final int idSkemaHarga;
  final String namaPaket;
  final String jenjang;
  const CheckoutScreen({Key key, this.idTryout, this.idSkemaHarga, this.namaPaket, this.jenjang})
      : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState(this.idTryout);
}

class _CheckoutScreenState extends State<CheckoutScreen>
    implements PembayaranState {
  final int idTryout;
  String selected;
  BayarModel _bayarModel;
  PembayaranPresenter _pembayaranPresenter;
  _CheckoutScreenState(this.idTryout) {
    this._pembayaranPresenter = new PembayaranPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._pembayaranPresenter.getHarga(widget.idSkemaHarga);
    this._pembayaranPresenter.view = this;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return this._bayarModel.isloading
        ? Loading()
        : SafeArea(
          child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Icon(LineIcons.arrowLeft),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Pembayaran',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        )),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      color: Color(0xffecedf2),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'Tes Ujian Online',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Container(
                                      child: Text(
                                        'Tryout ' +
                                            widget.jenjang +
                                            ' | ' +
                                            widget.namaPaket,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Container(
                                      child: Text(
                                        this._bayarModel.harga.toString(),
                                        style: GoogleFonts.poppins(
                                            color: Colors.red,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  EdgeInsets.only(left: 20, top: 20, bottom: 10),
                              child: Text(
                                'Pilih Metode Pembayarannya',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 20, bottom: 10),
                              child: Text(
                                'Bank Transfer',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'bsi';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 7.5, top: 7.5),
                                decoration: BoxDecoration(
                                    color: selected == 'bsi'
                                        ? Colors.grey[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 60,
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                                'assets/img/bsi.png'),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'bri';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 7.5, top: 7.5),
                                decoration: BoxDecoration(
                                    color: selected == 'bri'
                                        ? Colors.grey[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 60,
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                                'assets/img/bri.png'),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'gopay';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 7.5, top: 7.5),
                                decoration: BoxDecoration(
                                    color: selected == 'gopay'
                                        ? Colors.grey[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 60,
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(10),
                                            child:
                                                Image.asset('assets/img/gopay.png'),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'permata';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 7.5, top: 7.5),
                                decoration: BoxDecoration(
                                    color: selected == 'permata'
                                        ? Colors.grey[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 60,
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child:
                                                Image.asset('assets/img/permata.png'),  
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'bni';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 7.5, top: 7.5),
                                decoration: BoxDecoration(
                                    color: selected == 'bni'
                                        ? Colors.grey[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 60,
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(10),
                                            child:
                                                Image.asset('assets/img/bni.png'),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'mandiri';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 7.5, top: 7.5),
                                decoration: BoxDecoration(
                                    color: selected == 'mandiri'
                                        ? Colors.grey[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 60,
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                                'assets/img/mandiri.png'),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 20, bottom: 10),
                              child: Text(
                                'E-Wallet',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'ovo';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 7.5, top: 7.5),
                                decoration: BoxDecoration(
                                    color: selected == 'ovo'
                                        ? Colors.grey[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 60,
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                                'assets/img/ovo.png'),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'dana';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 7.5, top: 7.5),
                                decoration: BoxDecoration(
                                    color: selected == 'dana'
                                        ? Colors.grey[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 60,
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                                'assets/img/dana.png'),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'shopeepay';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 7.5, top: 7.5),
                                decoration: BoxDecoration(
                                    color: selected == 'shopeepay'
                                        ? Colors.grey[400]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 43,
                                          margin: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            // borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                                'https://storage.googleapis.com/go-merchant-production.appspot.com/uploads/2020/10/f7fb2e0ab8572355142dba33ddc7b8d6_0747205be87147c03d04217ad4eb06c3_compressed.png'),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 5, right: 5, bottom: 2),
                      height: 45,
                      child: RaisedButton(
                        padding: EdgeInsets.all(10),
                        color: Colors.blue,
                        disabledColor: Colors.red,
                        onPressed: () async {
                          print('1');
                          // Navigator.pushNamed(context, "/pembayaran_detail");
                          if (selected == null) {
                            Fluttertoast.showToast(
                                msg: "bank harus dipilih",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            this._pembayaranPresenter.checkout(
                                GetStorage().read(ID_MURID),
                                idTryout,
                                selected,
                                this._bayarModel.harga.toString());
                          }
                          // Navigator.pushNamed(context, "/pembayaran_detail");
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        child: Text(
                          'Checkout',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        );
  }

  @override
  void onCheck(int orderId, int jumlah) {
    print('bayar step:3');
    print(orderId);
    // if (orderId == 'false') {
    //   print(
    //       'response API: Anda Masih Punya Pembayaran Yang Belum Selesai, padahal bisa aja expire/cancel dll');
    // }
    // Toast.show(
    //     "response API: Anda Masih Punya Pembayaran Yang Belum Selesai", context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    this._pembayaranPresenter.checkPembayaran(
        GetStorage().read(ID_MURID), orderId, jumlah);
  }

  @override
  void onError(String error) {
    print(error);
    print("history ====");
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
  void refreshData(BayarModel bayarModel) {
    setState(() {
      this._bayarModel = bayarModel;
    });
  }

  @override
  void onCheckBayar(BayarModel bayarModel) {
    print('bayar step:4');
    if(bayarModel.bayars[0].deepLink != null) {
        _openGopay(bayarModel.bayars[0].deepLink);
    }else{
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PembayaranBayar(
                    metode: bayarModel.bayars[0].bank,
                    jumlah: bayarModel.bayars[0].amount,
                    va: bayarModel.bayars[0].vaNumber,
                    batasWaktu: bayarModel.bayars[0].batasWaktu,
                    status: bayarModel.bayars[0].transactionStatus,
                  )));
    }
  }

  _openGopay(String deeplink) async {
    if (await canLaunch(deeplink)) {
      await launch(deeplink);
    } else {
      throw 'Could not launch $deeplink';
    }
  }

  @override
  void refreshDataBayar(BayarModel bayarModel) {
    setState(() {
      this._bayarModel = bayarModel;
    });
  }

  @override
  void removeDataBayar(String error) {
    setState(() {
      this._bayarModel.bayars.clear();
    });
  }
}
