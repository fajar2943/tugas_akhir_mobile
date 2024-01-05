import 'package:get/get.dart';
import 'package:tugas_akhir_mobile/url.dart';

class AuthProvider extends GetConnect {
  Future<Response> register(var data) {
    return post('${baseUrl}/register', data, headers: BasicHeader);
  }

  Future<Response> login(var data) {
    return post('${baseUrl}/login', data, headers: BasicHeader);
  }

  Future<Response> directSetPassword(var data) {
    return post('${baseUrl}/directSetPassword', data, headers: BasicHeader);
  }
}
