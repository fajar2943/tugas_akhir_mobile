import 'package:get/get.dart';
import 'package:tugas_akhir_mobile/url.dart';

class NotifProvider extends GetConnect {
  Future<Response> getAll() {
    return get('${baseUrl}/notif', headers: AuthHeader);
  }

  Future<Response> update(data) {
    return post('${baseUrl}/notif', data, headers: AuthHeader);
  }
}
