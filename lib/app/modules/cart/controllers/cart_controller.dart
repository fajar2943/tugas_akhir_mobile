import 'package:tugas_akhir_mobile/app/data/cart_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartController extends GetxController {
  List cartList = box.read('cart');
  List cartData = [];
  List cartQty = [];
  List dataCheckout = [];
  RxList variants = [].obs;
  RxInt totalItem = 0.obs;
  RxInt totalPrice = 0.obs;
  TextEditingController qty = TextEditingController(text: '4');

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    index();
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    super.onInit();
    index();
  }

  void index() {
    EasyLoading.show();
    cartData = [];
    print(cartList);
    for (var element in cartList) {
      cartData.add(element['id']);
    }
    CartProvider().getAll({'carts': cartData}).then((Response response) {
      if (response.statusCode == 200) {
        List newCart = [];
        var responseBody = response.body;
        variants.value = [];
        for (var cart in cartData) {
          for (var variant in responseBody) {
            if (cart == variant['id']) {
              String qty = getQty(variant['id']);
              variant['qtyTxt'] = TextEditingController(text: qty);
              variant['checkbox'] = false.obs;
              variants.add(variant);
              newCart.add({'id': variant['id'], 'qty': qty});
              break;
            }
          }
        }
        box.write('cart', newCart);
        EasyLoading.dismiss();
      } else if (response.statusCode == null) {
        Get.snackbar("Warning", "Periksa koneksi internet anda!",
            backgroundColor: Colors.amber, colorText: Colors.white);
      }
    });
  }

  void checkout() {
    if (dataCheckout.length == 0) {
      Get.snackbar("Warning", "Pilih minimal 1 produk",
          backgroundColor: Colors.amber, colorText: Colors.white);
    } else {
      box.write('checkouts', dataCheckout);
      // print(box.read('checkout'));
      Get.toNamed(Routes.CHECKOUT);
    }
  }

  void remove(index) {
    int cartListIndex = cartList
        .indexWhere((element) => element['id'] == variants[index]['id']);
    if (cartListIndex != -1) {
      cartList.removeAt(cartListIndex);
      box.write('cart', cartList);
      variants.removeAt(index);
    }
  }

  void checkbox(value, index) {
    variants[index]['checkbox'].value = value;
    setDataCheckout();
  }

  void qtyPlus(index) {
    var qty = (variants[index]['qtyTxt'].text.toString().isNotEmpty)
        ? int.parse(variants[index]['qtyTxt'].text)
        : 0;
    qty++;
    variants[index]['qtyTxt'].text = (qty > 0) ? qty.toString() : '1';
    cartOnChange(qty, index);
  }

  void qtyMinus(index) {
    var qty = (variants[index]['qtyTxt'].text.toString().isNotEmpty)
        ? int.parse(variants[index]['qtyTxt'].text)
        : 0;
    qty = (qty.toString().isNotEmpty) ? qty : 0;
    if (qty > 0) {
      qty--;
      variants[index]['qtyTxt'].text = (qty > 0) ? qty.toString() : '1';
    }
    cartOnChange(qty, index);
  }

  void cartOnChange(qty, index) {
    int cartListIndex = cartList
        .indexWhere((element) => element['id'] == variants[index]['id']);
    if (cartListIndex != -1) {
      cartList[cartListIndex]['qty'] = qty.toString();
      box.write('cart', cartList);
    }
    setDataCheckout();
  }

  void setDataCheckout() {
    dataCheckout = [];
    for (var variant in variants) {
      if (variant['checkbox'].value == true) {
        dataCheckout.add({
          'id': variant['id'],
          'product_name': variant['product_name'],
          'name': variant['name'],
          'qty': variant['qtyTxt'].text,
          'price': variant['price']
        });
      }
    }
    totalItem.value = dataCheckout.length;
    totalPrice.value = 0;
    for (var checkout in dataCheckout) {
      var qty = (checkout['qty'].toString().isNotEmpty &&
              int.parse(checkout['qty'].toString()) > 0)
          ? int.parse(checkout['qty'].toString())
          : 1;
      totalPrice += (qty * int.parse(checkout['price'].toString()));
    }
  }

  String getQty(id) {
    for (var element in box.read('cart')) {
      if (element['id'].toString() == id.toString()) {
        return element['qty'].toString();
      }
    }
    return '1';
  }
}
