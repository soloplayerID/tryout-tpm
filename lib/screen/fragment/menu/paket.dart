import 'package:TesUjian/helper/utils.dart';
import 'package:TesUjian/src/model/paket.dart';
import 'package:TesUjian/src/presenter/paket.dart';
import 'package:TesUjian/src/state/paket.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaketScreen extends StatefulWidget {
  final TryoutCallback onTryoutgo;
  final bool isList;
  final bool isPondok;
  const PaketScreen({Key key, this.onTryoutgo, this.isList, this.isPondok})
      : super(key: key);
  @override
  _PaketScreenState createState() =>
      _PaketScreenState(onTryoutgo, isList, isPondok);
}

class _PaketScreenState extends State<PaketScreen> implements PaketState {
  // ignore: unused_field
  PaketModel _paketModel;
  PaketPresenter _paketPresenter;
  final TryoutCallback onTryoutgo;
  final bool isList;
  final bool isPondok;
  _PaketScreenState(this.onTryoutgo, this.isList, this.isPondok) {
    this._paketPresenter = new PaketPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._paketPresenter.view = this;
    this._paketPresenter.getData(isPondok);
    this._paketPresenter.getJenjang();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: this._paketModel.pakets.isEmpty
          ? CarouselSlider.builder(
              options: CarouselOptions(
                height: 130,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(microseconds: 5000),
                viewportFraction: 0.9,
                aspectRatio: 2.0,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int itemIndex) => Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff25509e),
                        Color(0xff25509e),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffaaaaaa),
                          blurRadius: 20,
                          spreadRadius: -12)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    SkeletonAnimation(
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          SkeletonAnimation(
                            child: Container(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Ionicons.timer_sharp,
                                color: Colors.white54,
                                size: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Ionicons.calendar_outline,
                                color: Colors.white54,
                                size: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          : this._paketModel.pakets == null
              ? CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 130,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(microseconds: 5000),
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                  ),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff25509e),
                            Color(0xff25509e),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xffaaaaaa),
                              blurRadius: 20,
                              spreadRadius: -12)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: <Widget>[
                        SkeletonAnimation(
                          child: Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              SkeletonAnimation(
                                child: Container(
                                  height: 15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.timer_sharp,
                                    color: Colors.white54,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SkeletonAnimation(
                                    child: Container(
                                      height: 12,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey[300]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.calendar_outline,
                                    color: Colors.white54,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SkeletonAnimation(
                                    child: Container(
                                      height: 12,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey[300]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : this.isList
                  ? ListView.builder(
                      controller: ScrollController(),
                      physics: ScrollPhysics(parent: PageScrollPhysics()),
                      itemCount: this._paketModel.pakets.length,
                      itemBuilder: (BuildContext context, int itemIndex) =>
                          InkWell(
                        onTap: () {
                          this.onTryoutgo(this._paketModel.pakets[itemIndex].id,
                              false, this._paketModel.pakets[itemIndex].title);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff25509e),
                                  Color(0xff25509e),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffaaaaaa),
                                    blurRadius: 20,
                                    spreadRadius: -12)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Image.asset("assets/img/paket.png",
                                  fit: BoxFit.fill),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    AutoSizeText(
                                      this._paketModel.pakets[itemIndex].title,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xffffffff)),
                                      ),
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Ionicons.timer_sharp,
                                          color: Colors.white54,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            "${this._paketModel.pakets[itemIndex].durasi}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white54,
                                                fontSize: 12)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Ionicons.calendar_outline,
                                          color: Colors.white54,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            this
                                                ._paketModel
                                                .pakets[itemIndex]
                                                .tanggal,
                                            style: GoogleFonts.poppins(
                                                color: Colors.white54,
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 130,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(microseconds: 5000),
                        viewportFraction: 0.9,
                        aspectRatio: 2.0,
                      ),
                      itemCount: this._paketModel.pakets.length,
                      itemBuilder: (BuildContext context, int itemIndex) =>
                          InkWell(
                        onTap: () {
                          this.onTryoutgo(this._paketModel.pakets[itemIndex].id,
                              false, this._paketModel.pakets[itemIndex].title);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff25509e),
                                  Color(0xff25509e),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffaaaaaa),
                                    blurRadius: 20,
                                    spreadRadius: -12)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Image.asset("assets/img/paket.png",
                                  fit: BoxFit.fill),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    AutoSizeText(
                                      this._paketModel.pakets == null
                                          ? ''
                                          : this
                                              ._paketModel
                                              .pakets[itemIndex]
                                              .title,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xffffffff)),
                                      ),
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Ionicons.timer_sharp,
                                          color: Colors.white54,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            "${this._paketModel.pakets[itemIndex].durasi}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white54,
                                                fontSize: 12)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Ionicons.calendar_outline,
                                          color: Colors.white54,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            this
                                                ._paketModel
                                                .pakets[itemIndex]
                                                .tanggal,
                                            style: GoogleFonts.poppins(
                                                color: Colors.white54,
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }

  @override
  void onError(String error) {
    print(error);
    print("error paket");
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
  void refreshData(PaketModel paketModel) {
    setState(() {
      this._paketModel = paketModel;
    });
  }
}
