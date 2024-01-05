import 'package:tugas_akhir_mobile/url.dart';
import 'package:get/get.dart';

class InvoiceProvider extends GetConnect {
  Future<Response> getAll() {
    return get('${baseUrl}/orders', headers: AuthHeader);
  }

  Future<Response> findById(id) {
    return get('${baseUrl}/orders/${id}', headers: AuthHeader);
  }
}
