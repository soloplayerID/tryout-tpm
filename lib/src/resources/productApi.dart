// ignore: unused_import
import 'package:http/http.dart' show Client;
// ignore: unused_import
import 'package:TesUjian/src/model/user.dart';
// ignore: unused_import
import 'package:TesUjian/helper/paths.dart';
// ignore: unused_import
import 'package:TesUjian/helper/rijndael.dart';
// import 'package:skripsi/src/model/warehouse.dart';
import 'package:TesUjian/src/response/products.dart';
import 'dart:convert';

class ProductApi {
  Client _client = new Client();
  Map<String, String> _headers = {
    'Content-type': 'text/plain',
    'Accept': 'text/plain',
  };
  Future<Product> getStock(String data) async {
    final response = await _client.post(
        Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_STOCK}"),
        body: encryptAESCryptoJS(data, Paths.KEY),
        headers: _headers);
    if (response.statusCode == 200) {
      Product product = Product.fromJson(
          json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
      return product;
    } else {
      return null;
    }
  }

  Future<Product> getAllWarehouse() async {
    final response =
        await _client.get(Uri.parse("${Paths.BASEURL}${Paths.ENDPOINT_STOCK}"));
    if (response.statusCode == 200) {
      Product product = Product.fromJson(
          json.decode(decryptAESCryptoJS(response.body, Paths.KEY)));
      return product;
    } else {
      return null;
    }
  }
}
