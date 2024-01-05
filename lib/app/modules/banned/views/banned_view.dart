import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/banned_controller.dart';

class BannedView extends GetView<BannedController> {
  const BannedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BannedView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BannedView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
