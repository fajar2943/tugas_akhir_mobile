import 'package:get/get.dart';
import 'package:tugas_akhir_mobile/url.dart';

class CategoryProvider extends GetConnect {
  Future<Response> getAll() {
    return get('${baseUrl}/categories', headers: AuthHeader);
  }
}
