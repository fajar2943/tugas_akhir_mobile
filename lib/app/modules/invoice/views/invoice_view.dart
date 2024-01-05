import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir_mobile/url.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import 'package:get/get.dart';

import '../controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  const InvoiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Invoice"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.MAIN, arguments: '1');
              },
              icon: Icon(Icons.arrow_back)),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 1,
          notchMargin: 10,
          child: Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Bayar", style: h4Black),
                      Obx(
                        () => Text("${controller.invoice['total_price']}",
                            style: h4Black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text("${controller.invoice['created_at']}",
                            style: smallDark),
                      ),
                      Visibility(
                        visible:
                            controller.invoice['saving'] == 0 ? false : true,
                        child: Obx(
                          () => Text(
                              "Anda hemat: ${controller.invoice['saving']}",
                              style: smallDark),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                "#${controller.invoice['inv']}",
                                style: strongBlack,
                              ),
                            ),
                            Obx(
                              () => Text("${controller.invoice['created_at']}"),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status"),
                            Obx(
                              () => Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: MyColors().statusColor(
                                      controller.invoice['status_color']),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${controller.invoice['status']}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Obx(
                      () => Column(
                        children: [
                          for (var i in controller.invoice['details'] ?? [])
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Product :"),
                                    Text(
                                      "${i['product_name']}",
                                      style: pDark,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Variant :"),
                                    Text(
                                      "${i['name']}",
                                      style: pDark,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Harga :"),
                                    Text(
                                      "${i['price']}",
                                      style: pDark,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Qty :"),
                                    Text(
                                      "x ${i['qty']}",
                                      style: pDark,
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: i['discount'] == 0 ? false : true,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Potongan harga:"),
                                      Text(
                                        "- ${i['discount']}",
                                        style: pDark,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Subtotal:",
                                    ),
                                    Text(
                                      "${i['subtotal']}",
                                      style: strongBlack,
                                    ),
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Obx(
                      () => Column(
                        children: [
                          // Text("data"),
                          Visibility(
                            visible: controller.invoice['is_promo'] != null &&
                                    controller.invoice['is_promo'] != false
                                ? true
                                : false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.invoice['promo_name']}",
                                  style: strongDark,
                                ),
                                Text(
                                  "- ${controller.invoice['promo']}",
                                  style: strongDark,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  launcher.launchUrl(
                    Uri.parse(
                        '${baseUrl}/pdf/${controller.invoice['id']}/${controller.invoice['pdf_token']}'),
                    mode: launcher.LaunchMode.externalApplication,
                  );
                },
                child: Text("Print PDF"),
              ),
            ],
          ),
        ));
  }
}
