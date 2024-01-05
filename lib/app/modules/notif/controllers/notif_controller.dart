import 'package:tugas_akhir_mobile/app/data/notif_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class NotifController extends GetxController {
  RxList notif = [].obs;

  @override
  void onInit() {
    index();
    super.onInit();
  }

  void index() {
    EasyLoading.show();
    NotifProvider().getAll().then((Response response) {
      if (response.statusCode == 200) {
        var responseBody = response.body;
        notif.assignAll(responseBody);
        EasyLoading.dismiss();
      } else if (response.statusCode == null) {
        Get.snackbar("Warning", "Periksa koneksi internet anda!",
            backgroundColor: Colors.amber, colorText: Colors.white);
        EasyLoading.dismiss();
      } else {
        Get.snackbar("Terjadi Kesalahan", "Coba beberapa saat lagi..",
            backgroundColor: Colors.amber, colorText: Colors.white);
        EasyLoading.dismiss();
      }
    });
  }

  void goto(type, value, status, id) {
    if (status == 'Sended' || status == 'Seen') {
      NotifProvider().update({'status': 'Read', 'id': id});
    }
    if (type == 'Order') {
      Get.offAllNamed(Routes.INVOICE, arguments: value);
    }
  }
}
