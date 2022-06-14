import 'dart:io';

import 'package:TesUjian/src/model/profile.dart';
import 'package:TesUjian/src/presenter/profile_header.dart';
import 'package:TesUjian/src/state/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:TesUjian/helper/getStorage.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({ Key key }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with SingleTickerProviderStateMixin
    implements ProfileHeaderState {
  AnimationController _controller;

  File _image;
  String fileName;
  final ImagePicker _picker = ImagePicker();
  bool kosong;

  ProfileModel _profileModel;
  ProfileHeaderPresenter _profileHeaderPresenter;

  _EditProfileScreenState(){
    this._profileHeaderPresenter = new ProfileHeaderPresenter();
  }

  @override
  void initState() {
    super.initState();
    this._profileHeaderPresenter.view = this;
    this._profileHeaderPresenter.getData(GetStorage().read(ID_MURID));
    this._profileHeaderPresenter.getDaftar(GetStorage().read(ID_MURID));
    if (Profile().checkIfAnyIsNull()) {
      kosong = true;
    }
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._profileModel.profiles.isEmpty
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                'Ubah Profile',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 40),
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    color: Color(0xffecedf2),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            )
            : SafeArea(
              child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    child: Column(
                      children: [
              Container(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Row(
                  children: [
                    Row(
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
                          'Ubah Profile',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15),
                  height: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.blue,
                                      child: _image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.file(
                                                _image,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            )
                                          : Container(
                                              width: 80,
                                              height: 80,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xff2D8EFF),
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: _image == null
                                                          ? this
                                                                      ._profileModel
                                                                      .profiles[
                                                                          0]
                                                                      .picture ==
                                                                  null
                                                              ? ExactAssetImage(
                                                                  "assets/img/user.png",
                                                                )
                                                              : NetworkImage(
                                                                  // "assets/img/user.png"
                                                                  "http://103.41.207.247:3000/" +
                                                                      this
                                                                          ._profileModel
                                                                          .profiles[
                                                                              0]
                                                                          .picture)
                                                          : Image.file(
                                                              _image)))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    child: InkWell(
                                      child: Text("Perbarui Foto Profile",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.blue,
                                          )),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Ambil Gambar"),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        child: Text(
                                                            'Ambil dari Kamera'),
                                                        onTap: () {
                                                          getImage();
                                                        },
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                      ),
                                                      GestureDetector(
                                                        child: Text(
                                                            'Ambil dari Galery'),
                                                        onTap: () {
                                                          getImageGalery();
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 50,
                                                        // ignore: deprecated_member_use
                                                        child: RaisedButton(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          color: Colors.blue,
                                                          disabledColor:
                                                              Colors.red,
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop('Success');
                                                          },
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                          child: Text(
                                                            'Selesai',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Nama Lengkap',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    this._profileModel.profiles[0].nama,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                    child: Container(
                                        child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        'Ubah',
                                        style: TextStyle(
                                            color: Colors.blue.withOpacity(1.0),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Email',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    this._profileModel.profiles[0].email,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                      child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Ubah',
                                      style: TextStyle(
                                          color: Colors.blue.withOpacity(1.0),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Nomer Telepon',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    this._profileModel.profiles[0].phone,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                      child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Ubah',
                                      style: TextStyle(
                                          color: Colors.blue.withOpacity(1.0),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Jenis Kelamin',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    this._profileModel.profiles[0].kelamin,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                      child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Ubah',
                                      style: TextStyle(
                                          color: Colors.blue.withOpacity(1.0),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Tanggal Lahir',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    this._profileModel.profiles[0].tglLahir,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                      child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Ubah',
                                      style: TextStyle(
                                          color: Colors.blue.withOpacity(1.0),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Alamat',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    this._profileModel.profiles[0].alamat ??
                                        'belum diisi',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                      child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Ubah',
                                      style: TextStyle(
                                          color: Colors.blue.withOpacity(1.0),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Asal Sekolah',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    this._profileModel.profiles[0].namaSekolah,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                      child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Ubah',
                                      style: TextStyle(
                                          color: Colors.blue.withOpacity(1.0),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ],
                              ),
                                    
                      ],
                    ),
                  ),
                ),
              )
                      ],
                    ),
                  ),
            ),
    );
  }

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
        fileName = _image.path.split('/').last;
        print(fileName);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGalery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
        fileName = _image.path.split('/').last;
        print(fileName);
      } else {
        print('No image selected.');
      }
    });
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
  void onUpdateSuccess(String success) {
    
  }

  @override
  void refreshData(ProfileModel profileModel) {
    setState(() {
      this._profileModel = profileModel;
    });
  }

  @override
  void saveAreaJenjang(int jenjang) {
    
  }

  @override
  void saveAreaJenjangTujuan(int jenjang) {
    
  }

  @override
  void selectSekolah() {
    
  }

  @override
  void selectSekolahTujuan() {
    
  }

  @override
  void showJenjang(BuildContext context, int idParent) {
    
  }

  @override
  void showJenjangTujuan(BuildContext context, int idParent) {
    
  }
}