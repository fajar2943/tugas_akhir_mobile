import 'package:tugas_akhir_mobile/my_storage.dart';

var BasicHeader = {
  'Accept': 'application/json',
};

var AuthHeader = {
  'Accept': 'application/json',
  'Authorization': 'Bearer ${box.read('token')}'
};
String url =
    'http://52ed-2001-448a-4082-411b-d553-c707-151-6be7.ngrok-free.app';
String baseUrl = '${url}/api/v1';
String defaultImage = '${url}/cipuk/img/default.png';
