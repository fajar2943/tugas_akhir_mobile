import 'package:tugas_akhir_mobile/app/modules/main/controllers/transaction_controller.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionTab extends StatelessWidget {
  TransactionTab({super.key});

  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Text("Transactions", style: h3Black),
            ),
            Expanded(
              child: controller.transactions.length == 0
                  ? SmartRefresher(
                      controller: controller.refreshController,
                      onRefresh: () => controller.onRefresh(),
                      child: Container(
                        height: 800,
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text("Tidak ada data"),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(10),
                      child: Obx(
                        () => ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.transactions.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: () {
                                Get.offAllNamed(Routes.INVOICE,
                                    arguments: controller.transactions[index]
                                        ['id']);
                              },
                              child: Card(
                                elevation: 1,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "#${controller.transactions[index]['inv']}",
                                            style: h4Black,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: MyColors().statusColor(
                                                  controller.transactions[index]
                                                      ['status_color']),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              "${controller.transactions[index]['status']}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Visibility(
                                        visible: controller.transactions[index]
                                                ['is_promo']
                                            ? true
                                            : false,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${controller.transactions[index]['promo_name']}",
                                              style: strongDark,
                                            ),
                                            Text(
                                              "- ${controller.transactions[index]['promo']}",
                                              style: strongDark,
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Bayar", style: h4Black),
                                          Text(
                                              "${controller.transactions[index]['total_price']}",
                                              style: h4Black),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${controller.transactions[index]['created_at']}",
                                              style: smallDark),
                                          Visibility(
                                            visible:
                                                controller.transactions[index]
                                                            ['saving'] ==
                                                        0
                                                    ? false
                                                    : true,
                                            child: Text(
                                                "Potongan Harga: Rp. ${controller.transactions[index]['saving']}",
                                                style: smallDark),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
