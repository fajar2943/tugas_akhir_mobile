import 'package:tugas_akhir_mobile/app/modules/main/controllers/favorite_controller.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavoriteTab extends StatelessWidget {
  FavoriteTab({super.key});

  final FavoriteController controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.onRefresh(),
        child: Obx(
          () => Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: Text("Favorite", style: h3Black),
              ),
              Expanded(
                child: controller.products.length == 0
                    ? Container(
                        height: 800,
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text("Tidak ada data"),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(10),
                        child: Obx(
                          () => ListView.separated(
                            shrinkWrap: true,
                            itemCount: controller.products.length,
                            itemBuilder: (BuildContext context, index) {
                              return Card(
                                elevation: 1,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL, arguments: [
                                      controller.products[index]['id']
                                    ]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              controller.products[index]
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
                                                "${controller.products[index]['name']}",
                                                style: strongBlack,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "${controller.products[index]['description']}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "${controller.products[index]['price']}",
                                                style: pSuccess,
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.remove(controller
                                                .products[index]['id']);
                                          },
                                          icon: Icon(
                                            IconlyLight.delete,
                                            color: MyColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
    );
  }
}
