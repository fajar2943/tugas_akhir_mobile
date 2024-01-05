import 'package:tugas_akhir_mobile/url.dart';
import 'package:get/get.dart';

class PromoProvider extends GetConnect {
  Future<Response> getAll() {
    return get('${baseUrl}/promos', headers: AuthHeader);
  }
}
