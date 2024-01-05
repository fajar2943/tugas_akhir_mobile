import 'package:get/get.dart';

import 'package:tugas_akhir_mobile/app/modules/main/controllers/favorite_controller.dart';
import 'package:tugas_akhir_mobile/app/modules/main/controllers/home_controller.dart';
import 'package:tugas_akhir_mobile/app/modules/main/controllers/profile_controller.dart';
import 'package:tugas_akhir_mobile/app/modules/main/controllers/transaction_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
    Get.lazyPut<FavoriteController>(
      () => FavoriteController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<MainController>(
      () => MainController(),
    );
  }
}
