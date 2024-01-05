import 'package:tugas_akhir_mobile/app/modules/main/controllers/home_controller.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: () => controller.onRefresh(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade300,
                Colors.white,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        box.read('name'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(92, 224, 224, 224),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            IconButton(
                              color: Colors.red,
                              icon: Icon(IconlyLight.buy),
                              onPressed: () {
                                Get.toNamed(Routes.CART);
                              },
                            ),
                            Obx(
                              () => Container(
                                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                child: Visibility(
                                  visible: controller.totalCart.value == 0
                                      ? false
                                      : true,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        controller.totalCart.value.toString(),
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Obx(
                        () => Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(92, 224, 224, 224),
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: [
                              IconButton(
                                color: Colors.black,
                                icon: Icon(
                                    int.parse(controller.unreadNotif.value) != 0
                                        ? Icons.notifications_active_outlined
                                        : Icons.notifications_none_outlined),
                                onPressed: () {
                                  Get.toNamed(Routes.NOTIF);
                                },
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                child: Visibility(
                                  visible:
                                      int.parse(controller.unreadNotif.value) ==
                                              0
                                          ? false
                                          : true,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Obx(
                                        () => Text(
                                          controller.unreadNotif.value
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
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
                ],
              ),
              SizedBox(height: 20),
              Obx(
                () => Visibility(
                  visible: controller.promos.length == 0 ? false : true,
                  child: Container(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: controller.promos.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: controller.promos[index]
                                                  ['image'] ==
                                              controller.promos[index]
                                                  ['default_image']
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 3,
                                                horizontal: 7,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: MyColors.primary,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${controller.promos[index]['name']}",
                                                    style: h4,
                                                  ),
                                                  Text(
                                                    "Diskon ${controller.promos[index]['discount']} hingga ${controller.promos[index]['max_discount']}",
                                                    style: h5,
                                                  ),
                                                  Text(
                                                    "Kode Promo: ${controller.promos[index]['code']}",
                                                    style: small,
                                                  ),
                                                  Text(
                                                    "${controller.promos[index]['start_date']} - ${controller.promos[index]['finish_date']}",
                                                    style: small,
                                                  )
                                                ],
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                "${controller.promos[index]['image']}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.search,
                onSubmitted: (value) {
                  controller.current_category = 0;
                  controller.getProduct();
                  controller.active.value = 0;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  hintText: "Search",
                  suffixIcon: const Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: MyColors.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => Padding(
                                  padding: const EdgeInsets.only(right: 1),
                                  child: InkWell(
                                    onTap: () {
                                      controller.setCategory(index);
                                    },
                                    child: Card(
                                      elevation:
                                          (controller.active.value == index)
                                              ? 3
                                              : 0,
                                      child: Container(
                                        width: 130,
                                        padding: const EdgeInsets.only(left: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    (controller.active.value ==
                                                            index)
                                                        ? Colors.white
                                                        : Colors.black26,
                                                width: 0.2),
                                            color: (controller.active.value ==
                                                    index)
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    6, 255, 255, 255)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.beenhere_sharp,
                                                size: 20,
                                                color:
                                                    (controller.active.value ==
                                                            index)
                                                        ? Colors.black
                                                        : Colors.black26),
                                            Text(
                                              controller.categories[index]
                                                  ['name'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: (controller
                                                              .active.value ==
                                                          index)
                                                      ? Colors.black
                                                      : Colors.black26),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Produk",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              Obx(() {
                if (controller.products.length == 0) {
                  return Expanded(
                    child: Container(
                      height: 400,
                      child: Center(
                        child: Text("Produk tidak tersedia"),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: .8,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL,
                                arguments: [controller.products[index]['id']]);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                        controller.products[index]['image']
                                            .toString(),
                                        fit: BoxFit.cover),
                                  ),
                                  Visibility(
                                    visible: controller.products[index]
                                                ['discount'] ==
                                            0
                                        ? false
                                        : true,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(20))),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${controller.products[index]['discount']}",
                                              style: TextStyle(
                                                  color: MyColors.primary,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              "OFF",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                controller.products[index]['price'].toString(),
                                style: TextStyle(color: MyColors.primary),
                              ),
                              Expanded(
                                child: Text(
                                  controller.products[index]['name'].toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
