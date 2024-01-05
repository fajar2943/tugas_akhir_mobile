import 'package:tugas_akhir_mobile/app/data/invoice_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionController extends GetxController {
  RxList transactions = [].obs;

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
    EasyLoading.show();
    InvoiceProvider().getAll().then((Response response) {
      if (response.statusCode == 200) {
        var responseBody = response.body;
        transactions.assignAll(responseBody);
        EasyLoading.dismiss();
      }
    });
  }
}
