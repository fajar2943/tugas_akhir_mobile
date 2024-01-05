import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_mobile/url.dart';

class OtpProvider extends GetConnect {
  var myHeader = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${box.read('token')}'
  };

  var defaultHeader = {
    'Accept': 'application/json',
  };
  Future<Response> sendOTP(var data) {
    return post('${baseUrl}/sendOtp', data, headers: myHeader);
  }

  Future<Response> directOTP(var data) {
    return post('${baseUrl}/directOtp', data, headers: defaultHeader);
  }

  Future<Response> verify(var data) {
    return post('${baseUrl}/verify', data, headers: defaultHeader);
  }
}
