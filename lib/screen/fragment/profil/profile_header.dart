// ignore_for_file: deprecated_member_use

import 'package:TesUjian/helper/getStorage.dart';
import 'package:TesUjian/src/model/profile.dart';
import 'package:TesUjian/src/presenter/profile_header.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:TesUjian/src/state/profile_header.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileHeader extends StatefulWidget {
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader>
    implements ProfileHeaderState {
  ProfileModel _profileModel;
  ProfileHeaderPresenter _profileHeaderPresenter;
  bool kosong;

  _ProfileHeaderState() {
    this._profileHeaderPresenter = new ProfileHeaderPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._profileHeaderPresenter.view = this;
    print(GetStorage().read(ID_MURID));
    Session.getId().then((value) {
      this._profileHeaderPresenter.getData(value);
    });
    if (Profile().checkIfAnyIsNull()) {
      kosong = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return this._profileModel.profiles.isEmpty
        ? Container(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        // onTap: () =>
                        //     Navigator.pushNamed(context, "/profile_detail"),
                        child: new Container(
                            width: 80,
                            height: 80,
                            padding: EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff2D8EFF),
                                image: this._profileModel.isloading
                                    ? new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: ExactAssetImage(
                                            "assets/img/user.png"
                                            // this
                                            //           ._profileModel
                                            //           .profiles[0]
                                            //           .picture ==
                                            //       null
                                            //   ? "assets/img/user.png"
                                            //   : "http://103.41.207.247:3000/public/" +
                                            //       this
                                            //           ._profileModel
                                            //           .profiles[0]
                                            //           .picture
                                            ))
                                    : new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: this
                                                    ._profileModel
                                                    .profiles[0]
                                                    .picture ==
                                                null
                                            ? ExactAssetImage(
                                                "assets/img/user.png"
                                                // this
                                                //           ._profileModel
                                                //           .profiles[0]
                                                //           .picture ==
                                                //       null
                                                //   ? "assets/img/user.png"
                                                //   : "http://103.41.207.247:3000/public/" +
                                                //       this
                                                //           ._profileModel
                                                //           .profiles[0]
                                                //           .picture
                                                )
                                            : NetworkImage(
                                                // "assets/img/user.png"
                                                "http://103.41.207.247:3000/" +
                                                    this
                                                        ._profileModel
                                                        .profiles[0]
                                                        .picture)))),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  child: Column(
                    children: [
                      Text(
                        this._profileModel.profiles == null
                            ? ''
                            : this._profileModel.profiles[0].nama,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        this._profileModel.profiles == null
                            ? ''
                            : this._profileModel.profiles[0].email,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Color(0xffaaaaaa),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                kosong == true
                    ? Container(
                        padding: EdgeInsets.only(left: 20, right: 5),
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'Sepertinya profilmu ada yang kurang',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              maxFontSize: 12,
                              minFontSize: 9,
                            ),
                            Expanded(
                              child: RaisedButton(
                                padding: EdgeInsets.all(1),
                                color: Colors.red,
                                disabledColor: Colors.red,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/profile_edit_profile");
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white)),
                                child: Text(
                                  'Lengkapi',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container()
              ],
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
  void refreshData(ProfileModel profileModel) {
    setState(() {
      this._profileModel = profileModel;
    });
  }

  @override
  void showJenjang(BuildContext context, int idParent) {
  }

  @override
  void saveAreaJenjang(int jenjang) {
  }

  @override
  void selectSekolah() {
  }

  @override
  void saveAreaJenjangTujuan(int jenjang) {
  }

  @override
  void selectSekolahTujuan() {
  }

  @override
  void showJenjangTujuan(BuildContext context, int idParent) {
  }

  @override
  void onUpdateSuccess(String success) {
  }
}
