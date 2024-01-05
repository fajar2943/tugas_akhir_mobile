import 'package:tugas_akhir_mobile/app/data/checkout_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  RxList checkouts = [].obs;
  RxList outOfStock = [].obs;
  RxMap promo = {}.obs;
  RxList invalid = [].obs;
  RxString totalPrice = ''.obs;
  List cartList = box.read('cart');
  TextEditingController code = TextEditingController();
  RxBool isPromo = false.obs;
  RxBool firstLoad = true.obs;

  @override
  void onInit() {
    index();
    super.onInit();
  }

  void index() {
    EasyLoading.show();
    CheckoutProvider().getAll({
      'checkouts': box.read('checkouts'),
      'promo_code': code.text
    }).then((Response response) {
      if (response.statusCode == 200) {
        var responseBody = response.body;
        checkouts.assignAll(responseBody['checkouts']);
        outOfStock.assignAll(responseBody['out_of_stock']);
        invalid.assignAll(responseBody['invalid']);
        totalPrice.value = responseBody['total_price'];
        promo.value = responseBody['promo'];
        if (promo['discount'] > 0) {
          isPromo.value = true;
          Get.snackbar(
              "Kode promo valid", "Berhasil menambahkan promo potongan harga",
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          print(firstLoad.value);
          isPromo.value = false;
          if (!firstLoad.value) {
            Get.snackbar("Kode promo tidak valid",
                "kode promo tidak valid atau kadaluwarsa",
                backgroundColor: Colors.amber, colorText: Colors.white);
          }
        }
        EasyLoading.dismiss();
      } else if (response.statusCode == null) {
        Get.snackbar("Warning", "Periksa koneksi internet anda!",
            backgroundColor: Colors.amber, colorText: Colors.white);
      }
    });
  }

  void order() {
    EasyLoading.show();
    CheckoutProvider().orders({
      'checkouts': box.read('checkouts'),
      'promo_code': code.text
    }).then((Response response) {
      var responseBody = response.body;
      if (response.statusCode == 200) {
        for (var checkout in box.read('checkouts')) {
          cartList.removeWhere((element) => element['id'] == checkout['id']);
        }
        box.write('cart', cartList);
        Get.offAllNamed(Routes.MAIN, arguments: '1');
        EasyLoading.dismiss();
      } else if (response.statusCode == 422 &&
          responseBody['is_failed'] == true) {
        checkouts.assignAll(responseBody['checkouts']);
        outOfStock.assignAll(responseBody['out_of_stock']);
        invalid.assignAll(responseBody['invalid']);
        totalPrice.value = responseBody['total_price'];
        EasyLoading.dismiss();
        Get.snackbar("Pemesanan Gagal",
            "dikarenakan stok kurang atau produk tidak tersedia",
            backgroundColor: Colors.amber, colorText: Colors.white);
      } else if (response.statusCode == null) {
        EasyLoading.dismiss();
        Get.snackbar("Warning", "Periksa koneksi internet anda!",
            backgroundColor: Colors.amber, colorText: Colors.white);
      } else {
        EasyLoading.dismiss();
        Get.snackbar("Warning", "Terjadi kesalahan tidak Terduga",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    });
  }

  void notFirstLoad() {
    firstLoad.value = false;
  }
}
