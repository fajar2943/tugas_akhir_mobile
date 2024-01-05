import 'package:get/get.dart';
import 'package:tugas_akhir_mobile/url.dart';

class CartProvider extends GetConnect {
  Future<Response> getAll(data) {
    return post('${baseUrl}/carts', data, headers: AuthHeader);
  }

  Future<Response> getFavorite(data) {
    return post('${baseUrl}/favorites', data, headers: AuthHeader);
  }
}
