import 'package:tugas_akhir_mobile/app/data/detail_provider.dart';
import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:tugas_akhir_mobile/url.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  var id = Get.arguments[0];
  RxInt active = 0.obs;
  RxList variants = [].obs;
  var product = {}.obs;
  RxString imgVariant = "${defaultImage}".obs;
  int currentVariant = 0;
  RxInt totalCart = 0.obs;
  RxBool isCart = false.obs;
  RxBool isFavorite = false.obs;
  List cartList = box.read('cart');
  List favoriteList = box.read('favorite');

  @override
  void onInit() {
    isFavorite.value = favoriteList.contains(id);
    totalCart.value = cartList.length;
    variants.assign(
        {'name': 'Nama Produk', 'image': defaultImage, 'price': 'Rp 0'});
    index();
    super.onInit();
  }

  void index() {
    EasyLoading.show();
    DetailProvider().getById(id).then((Response response) {
      var responseBody = response.body;
      variants.assignAll(responseBody['variants']);
      product.value = responseBody['product'];
      imgVariant.value = variants[0]['image'];
      currentVariant = variants[0]['id'];

      // isCart.value =
      //     cartList.contains(variants[0]['id']); //check by value of list

      isCart.value = checkCart(variants[0]['id']);
      EasyLoading.dismiss();
    });
  }

  void setVariant(index) {
    active.value = index;
    imgVariant.value = variants[index]['image'];
    // isCart.value = cartList.contains(variants[index]['id']);
    isCart.value = checkCart(variants[index]['id']);
  }

  void addCart(id) {
    cartList.add({'id': id, 'qty': '1'});
    box.write('cart', cartList);
    isCart.value = true;
    totalCart++;
  }

  void removeCart(id) {
    var i = 0;
    String cartIndex = '';
    for (var element in cartList) {
      if (element['id'].toString() == id.toString()) {
        cartIndex = i.toString();
      }
      i++;
    }
    if (cartIndex != '') {
      cartList.removeAt(int.parse(cartIndex));
      // cartList.remove(id);
    }
    box.write('cart', cartList);
    isCart.value = false;
    totalCart--;
  }

  void switchFavorite() {
    if (favoriteList.contains(id)) {
      favoriteList.remove(id);
      isFavorite.value = false;
    } else {
      favoriteList.add(id);
      isFavorite.value = true;
    }
    box.write('favorites', favoriteList);
  }

  bool checkCart(id) {
    for (var element in cartList) {
      if (element['id'].toString() == id.toString()) {
        return true;
      }
    }
    return false;
  }
}
