import 'package:tugas_akhir_mobile/app/data/invoice_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  var id = Get.arguments;
  RxMap invoice = {}.obs;

  void onInit() {
    index();
    super.onInit();
  }

  void index() {
    EasyLoading.show();
    InvoiceProvider().findById(id).then((Response response) {
      var responseBody = response.body;
      if (response.statusCode == 200) {
        invoice.assignAll(responseBody);
        EasyLoading.dismiss();
      }
    });
  }
}
