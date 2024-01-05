import 'package:tugas_akhir_mobile/app/data/category_provider.dart';
import 'package:tugas_akhir_mobile/app/data/product_provider.dart';
import 'package:tugas_akhir_mobile/app/data/promo_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final box = GetStorage();

class HomeController extends GetxController {
  RxList promos = [].obs;
  RxList categories = [].obs;
  RxList products = [].obs;
  RxString unreadNotif = '0'.obs;
  RxInt active = 0.obs;
  TextEditingController search = TextEditingController(text: '');
  int current_category = 0;
  int page = 1;
  List cartList = [];
  RxInt totalCart = 0.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void onRefresh() async {
    index();
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    getPromo();
    index();
    super.onInit();
  }

  void index() {
    cartList = box.read('cart');
    totalCart.value = cartList.length;
    EasyLoading.show();
    CategoryProvider().getAll().then((Response response) {
      if (response.statusCode == 200) {
        var responseBody = response.body;
        var data = responseBody['data'];
        categories.value = [];
        categories.add({'id': 0, 'name': 'All'});
        categories.addAll(data);
        unreadNotif.value = responseBody['unreadNotif'].toString();
        getProduct();
      } else if (response.statusCode == 401) {
        box.erase();
        Get.offAllNamed(Routes.WELCOME);
      } else if (response.statusCode == null) {
        Get.snackbar("Warning", "Periksa koneksi internet anda!",
            backgroundColor: Colors.amber, colorText: Colors.white);
      }
      EasyLoading.dismiss();
    });
  }

  void getPromo() {
    EasyLoading.show();
    PromoProvider().getAll().then((Response response) {
      if (response.statusCode == 200) {
        var responseBody = response.body;
        promos.assignAll(responseBody);
        EasyLoading.dismiss();
      }
    });
  }

  void getProduct() {
    EasyLoading.show();
    String params = "?pages=${page}";
    if (current_category != 0) {
      params += "&category=${current_category}";
      search.text = '';
    } else if (search.text != '') {
      params += "&search=${search.text}";
    }
    ProductProvider().getAll(params).then((Response response) {
      if (response.statusCode == 200) {
        var responseBody = response.body;
        products.assignAll(responseBody);
      }
      EasyLoading.dismiss();
    });
  }

  void setCategory(index) {
    current_category = categories[index]['id'];
    active.value = index;
    getProduct();
  }
}
