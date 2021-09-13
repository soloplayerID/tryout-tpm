import 'package:TesUjian/screen/fragment/profil/total_nilai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:TesUjian/src/resources/session.dart';

class ProfileHistory extends StatefulWidget {
  @override
  ProfileHistoryState createState() => ProfileHistoryState();
}

class ProfileHistoryState extends State<ProfileHistory>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String nama = "";
  void getName() {
    Session.getName().then((value) {
      setState(() {
        this.nama = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.getName();
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
                      'History',
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
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffeeeeee),
                              blurRadius: 7,
                            )
                          ]),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Image.asset("assets/img/paket.png",
                          //     color: Colors.blue, fit: BoxFit.fill),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text('Paket Semester 2 2020 SMP'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.checkmark_circle,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("12",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.close_circle_outline,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("30",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.remove_circle_outline,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("8",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Container(
                                    child: Icon(
                                      Ionicons.chevron_forward_outline,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
