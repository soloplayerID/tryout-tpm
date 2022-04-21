import 'package:TesUjian/src/response/sekolah.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SelectSekolahScreen extends StatefulWidget {
  final SekolahResponse sekolahResponse;

  const SelectSekolahScreen({Key key, this.sekolahResponse}) : super(key: key);
  @override
  _SelectSekolahScreenState createState() =>
      _SelectSekolahScreenState(sekolahResponse);
}

class _SelectSekolahScreenState extends State<SelectSekolahScreen> {
  // ignore: unused_field
  SekolahResponse _sekolahResponse;
  _SelectSekolahScreenState(SekolahResponse sekolahResponse) {
    this._sekolahResponse = sekolahResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Sekolah Asalmu"),
      ),
      body: this._sekolahResponse.dataSekolah == null
          ? Center(
                          child: InkWell(
                            splashColor: Color(0xff7474BF),
                            onTap: () {
                              setState(() {
                                print('refresh');
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 43,
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 28),
                                        blurRadius: 40,
                                        spreadRadius: -12)
                                  ],
                                  color: Color(0xff1d63dc),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  "data sekolah kosong, refresh",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
          : ListView.builder(
              itemCount: this._sekolahResponse.dataSekolah.data.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Icon(Ionicons.school),
                  title: Text(
                      "${this._sekolahResponse.dataSekolah.data[index].nama}"),
                  onTap: (() {
                    Navigator.pop(context, index);
                  }),
                );
              },
            ),
    );
  }
}
