import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/my_btn.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => Image(
                      image: NetworkImage(controller.imgVariant.value),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => IconButton(
                          color: Colors.red,
                          icon: Icon(controller.isFavorite.value != true
                              ? IconlyLight.heart
                              : IconlyBold.heart),
                          onPressed: () {
                            controller.switchFavorite();
                          },
                        ),
                      ),
                      Obx(
                        () => Stack(
                          children: [
                            IconButton(
                              color: Colors.red,
                              icon: Icon(IconlyLight.buy),
                              onPressed: () {
                                Get.toNamed(Routes.CART);
                              },
                            ),
                            Visibility(
                              visible: controller.totalCart.value == 0
                                  ? false
                                  : true,
                              child: Container(
                                padding: EdgeInsets.only(left: 30, top: 8),
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      controller.totalCart.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(top: 260),
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                          itemCount: controller.variants.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(right: 1),
                                child: InkWell(
                                  onTap: () {
                                    controller.setVariant(index);
                                  },
                                  child: Card(
                                    elevation:
                                        (controller.active.value == index)
                                            ? 3
                                            : 0,
                                    child: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    (controller.active.value ==
                                                            index)
                                                        ? MyColors.primary
                                                        : Colors.black26,
                                                width: 1),
                                            color: (controller.active.value ==
                                                    index)
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    6, 255, 255, 255)),
                                        child: Image.network(controller
                                            .variants[index]['image'])),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 1.0,
              minChildSize: 0.6,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 5,
                                  width: 35,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.product['name'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      controller
                                              .variants[controller.active.value]
                                          ['name'],
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: controller.variants[controller
                                                .active.value]['is_discount'] ==
                                            true
                                        ? true
                                        : false,
                                    child: Row(
                                      children: [
                                        Text(
                                          "${controller.variants[controller.active.value]['real_price']}",
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(2, 3, 2, 3),
                                          child: Text(
                                              "-${controller.variants[controller.active.value]['discount']}",
                                              style: h5Primary),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    height: 30,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: MyColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Center(
                                      child: Text(
                                        controller
                                            .variants[controller.active.value]
                                                ['rupiah']
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Deskripsi :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Container(
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: MyColors.primary,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                                child: Center(
                                  child: Text(
                                    "Stok : ${controller.variants[controller.active.value]['stock']}",
                                    style: h5Primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(controller.product['description'].toString()),
                          SizedBox(height: 20),
                          Obx(
                            () => Visibility(
                              visible: controller.isCart.value,
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    controller.removeCart(controller
                                            .variants[controller.active.value]
                                        ['id']);
                                  },
                                  child: Text(
                                    "Hapus dari keranjang",
                                    style: TextStyle(color: MyColors.primary),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: !controller.isCart.value,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.addCart(controller
                                      .variants[controller.active.value]['id']);
                                  // print(controller.cartList);
                                },
                                child: Text(
                                  "Masukan Keranjang",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: MyBtn.primary_full,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
