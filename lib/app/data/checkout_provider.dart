import 'package:tugas_akhir_mobile/url.dart';
import 'package:get/get.dart';

class CheckoutProvider extends GetConnect {
  Future<Response> getAll(data) {
    return post('${baseUrl}/checkouts', data, headers: AuthHeader);
  }

  Future<Response> orders(data) {
    return post('${baseUrl}/orders', data, headers: AuthHeader);
  }
}
