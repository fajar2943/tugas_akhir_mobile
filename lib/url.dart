import 'package:tugas_akhir_mobile/my_storage.dart';

var BasicHeader = {
  'Accept': 'application/json',
};

var AuthHeader = {
  'Accept': 'application/json',
  'Authorization': 'Bearer ${box.read('token')}'
};
// String url = 'http://f454-180-254-244-235.ngrok-free.app';
String url = 'https://mypackaging.my.id';
String baseUrl = '${url}/api/v1';
String defaultImage = '${url}/cipuk/img/default.png';
