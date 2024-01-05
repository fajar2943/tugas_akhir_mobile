import 'package:get/get.dart';
import 'package:tugas_akhir_mobile/url.dart';

class DetailProvider extends GetConnect {
  Future<Response> getById(var id) {
    return get('${baseUrl}/detailProduct/${id}', headers: AuthHeader);
  }
}
