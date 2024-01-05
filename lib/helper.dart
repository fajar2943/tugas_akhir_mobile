import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();
bool checkStatus() {
  print(box.read('status'));
  if (box.read('status') == 'Verify') {
    Get.offAllNamed(Routes.VERIFY);
  } else if (box.read('status') == 'Banned') {
    Get.offAllNamed(Routes.BANNED);
  } else if (box.read('status') == 'Active') {
    return true;
  } else {
    Get.offAllNamed(Routes.WELCOME);
  }
  return false;
}
