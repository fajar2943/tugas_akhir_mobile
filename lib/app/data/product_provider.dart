import 'package:get/get.dart';
import 'package:tugas_akhir_mobile/url.dart';

class ProductProvider extends GetConnect {
  Future<Response> getAll(data) {
    return get('${baseUrl}/products${data}', headers: AuthHeader);
  }
}
