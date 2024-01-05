import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/_input.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        notchMargin: 10,
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
          child: ElevatedButton(
            onPressed: () {
              controller.order();
            },
            child: Text("Pesan Sekarang"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: (controller.invalid.length > 0) ? true : false,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Text("Barang tidak lagi tersedia",
                              style: h3Black),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        Obx(
                          () => Column(
                            children: [
                              for (var index in controller.invalid)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Nama barang :"),
                                        Text("${index['product_name']}"),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Nama variant :"),
                                        Text("${index['name']}"),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                )
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Atur dan hapus barang dari keranjang"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: (controller.outOfStock.length > 0) ? true : false,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text("Stok kurang/habis", style: h3Black),
                          ),
                          SizedBox(height: 10),
                          Divider(),
                          Obx(
                            () => Column(
                              children: [
                                for (var index in controller.outOfStock)
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Nama barang :"),
                                          Text("${index['product_name']}"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Nama variant :"),
                                          Text("${index['name']}"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Harga :"),
                                          Row(
                                            children: [
                                              Visibility(
                                                visible:
                                                    index['is_discount'] == true
                                                        ? true
                                                        : false,
                                                child: Text(
                                                  "${index['real_price']}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Text("${index['price']}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Qty :"),
                                          Text("x ${index['qty']}"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Stok tersedia :"),
                                          Text("${index['available_stock']}"),
                                        ],
                                      ),
                                      Divider()
                                    ],
                                  )
                              ],
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 10),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("Atur di keranjang"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text("Detail", style: h3Black),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Obx(
                        () => Column(
                          children: [
                            for (var index in controller.checkouts)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nama barang :"),
                                      Text("${index['product_name']}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nama variant :"),
                                      Text("${index['name']}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Harga :"),
                                      Row(
                                        children: [
                                          Visibility(
                                            visible:
                                                index['is_discount'] == true
                                                    ? true
                                                    : false,
                                            child: Text(
                                              "${index['real_price']}",
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Text("${index['price']}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Qty :"),
                                      Text("x ${index['qty']}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sub Total :"),
                                      Text("${index['subtotal']}"),
                                    ],
                                  ),
                                  Divider()
                                ],
                              )
                          ],
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.isPromo.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount promo ${controller.promo['name']}",
                                style: TextStyle(color: Colors.green),
                              ),
                              Text("- ${controller.promo['discount']}"),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Harga :", style: h4Dark),
                          Obx(
                            () => Text("${controller.totalPrice.value}",
                                style: h4Dark),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kode Promo (Optional)",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: controller.code,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.primary),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.notFirstLoad();
                                controller.index();
                              },
                              child: Text("Cek"),
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.isPromo.value,
                          child: Text(
                            "Kode promo valid",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
