import 'package:tugas_akhir_mobile/url.dart';
import 'package:get/get.dart';

class ProfileProvider extends GetConnect {
  Future<Response> update(data) {
    return post('${baseUrl}/users', data, headers: AuthHeader);
  }

  Future<Response> changePassword(data) {
    return post('${baseUrl}/changePassword', data, headers: AuthHeader);
  }
}
