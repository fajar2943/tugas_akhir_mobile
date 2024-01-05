import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        notchMargin: 10,
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Item : ${controller.totalItem.value}",
                        style: h4Black),
                    Text("Total Harga : ${controller.totalPrice.value}",
                        style: h4Black),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.checkout();
                  },
                  child: Text("Checkout")),
            ],
          ),
        ),
      ),
      body: Obx(() {
        return SmartRefresher(
          controller: controller.refreshController,
          onRefresh: () => controller.onRefresh(),
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 50),
                          Text(
                            "Keranjang",
                            style: h1,
                          ),
                          Icon(
                            IconlyLight.buy,
                            color: Colors.white,
                            size: 40,
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                      Expanded(
                        child: controller.variants.length == 0
                            ? Container(
                                height: 800,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Center(
                                  child: Text("Tidak ada data"),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Obx(
                                  () => ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: controller.variants.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                controller.variants[index]
                                                        ['image']
                                                    .toString(),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller.variants[index]
                                                      ['product_name'],
                                                  style: h4Black,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  controller.variants[index]
                                                      ['name'],
                                                  style: h5Dark,
                                                ),
                                                Visibility(
                                                  visible: controller.variants[
                                                                  index]
                                                              ['is_discount'] ==
                                                          true
                                                      ? true
                                                      : false,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${controller.variants[index]['real_price']}",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "-${controller.variants[index]['discount']}",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              MyColors.primary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      controller.variants[index]
                                                              ['rupiah']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "Stok: ${controller.variants[index]['stock']}",
                                                      style: h5Dark,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .qtyMinus(index);
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              MyColors.primary,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                            size: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 40,
                                                      child: TextField(
                                                        onChanged: (value) {
                                                          controller
                                                              .cartOnChange(
                                                                  value, index);
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller: controller
                                                                .variants[index]
                                                            ['qtyTxt'],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .qtyPlus(index);
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              MyColors.primary,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Obx(
                                                () => Checkbox(
                                                  value: controller
                                                      .variants[index]
                                                          ['checkbox']
                                                      .value,
                                                  onChanged: (value) {
                                                    controller.checkbox(
                                                        value, index);
                                                  },
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  controller.remove(index);
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider();
                                    },
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
