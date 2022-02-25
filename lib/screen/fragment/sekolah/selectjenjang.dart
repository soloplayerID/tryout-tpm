import 'package:TesUjian/src/response/jenjang.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SelectJenjang extends StatefulWidget {
  final JenjangResponse areaResponse;

  const SelectJenjang({Key key, this.areaResponse}) : super(key: key);
  @override
  _SelectJenjangState createState() => _SelectJenjangState(areaResponse);
}

class _SelectJenjangState extends State<SelectJenjang> {
  // ignore: unused_field
  JenjangResponse _areaResponse;
  _SelectJenjangState(JenjangResponse areaResponse) {
    this._areaResponse = areaResponse;
    print(areaResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Area"),
      ),
      body: ListView.builder(
        itemCount: this._areaResponse.data.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Ionicons.school),
            title: Text("${this._areaResponse.data[index].jenjang}"),
            onTap: (() {
              Navigator.pop(context, index);
            }),
          );
        },
      ),
    );
  }
}
