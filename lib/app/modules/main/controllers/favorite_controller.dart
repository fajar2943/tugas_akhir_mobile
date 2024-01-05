import 'package:tugas_akhir_mobile/app/data/cart_provider.dart';
import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavoriteController extends GetxController {
  List favorites = box.read('favorite');
  RxList products = [].obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    index();
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    index();
    super.onInit();
  }

  void index() {
    CartProvider()
        .getFavorite({'favorites': favorites}).then((Response response) {
      var responseBody = response.body;
      if (response.statusCode == 200) {
        products.value = [];
        List newFavorite = [];
        for (var favorite in box.read('favorite')) {
          for (var element in responseBody) {
            if (favorite == element['id']) {
              products.add(element);
              newFavorite.add(element['id']);
              break;
            }
          }
        }
        box.write('favorite', newFavorite);
      }
    });
  }

  void remove(id) {
    favorites.remove(id);
    products.removeWhere((element) => element['id'] == id);
    box.write('favorite', favorites);
  }
}
