import 'package:tugas_akhir_mobile/style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notif_controller.dart';

class NotifView extends GetView<NotifController> {
  const NotifView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.notif.length == 0
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
            : Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.notif.length,
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        controller.goto(
                            controller.notif[index]['type'],
                            controller.notif[index]['value'],
                            controller.notif[index]['status'],
                            controller.notif[index]['id']);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: controller.notif[index]['status'] != 'Read'
                            ? Colors.blueGrey[50]
                            : Colors.white,
                        child: Column(
                          children: [
                            Divider(
                              height: 0,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.notif[index]['title'],
                                        style: h4Black,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        controller.notif[index]['description'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        controller.notif[index]['created_at'],
                                        style: h5Dark,
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
