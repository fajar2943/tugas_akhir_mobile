import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          launcher.launchUrl(
            Uri.parse('https://wa.me/905434657780'),
            mode: launcher.LaunchMode.externalApplication,
          );
        },
        child: Image.asset('assets/icons/wa.png'),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 10,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomBarItem(
                    controller: controller,
                    isCurrentPage: controller.currentPage == 0,
                    icon: IconlyLight.home,
                    page: 0,
                    label: "Home",
                  ),
                  BottomBarItem(
                    controller: controller,
                    isCurrentPage: controller.currentPage == 1,
                    icon: IconlyLight.bookmark,
                    page: 1,
                    label: "Transaksi",
                  ),
                  BottomBarItem(
                    controller: controller,
                    isCurrentPage: controller.currentPage == 2,
                    icon: IconlyLight.heart,
                    page: 2,
                    label: "Favorite",
                  ),
                  BottomBarItem(
                    controller: controller,
                    isCurrentPage: controller.currentPage == 3,
                    icon: IconlyLight.user,
                    page: 3,
                    label: "Profile",
                  ),
                ],
              )),
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: controller.animateToTab,
        children: [...controller.pages],
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    super.key,
    required this.controller,
    required this.isCurrentPage,
    required this.icon,
    required this.page,
    required this.label,
  });

  final MainController controller;
  final bool isCurrentPage;
  final IconData icon;
  final int page;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () => controller.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isCurrentPage ? MyColors.primary : Colors.grey,
              size: 20,
            ),
            Text(
              label,
              style: TextStyle(
                  color: isCurrentPage ? MyColors.primary : Colors.grey,
                  fontSize: 13,
                  fontWeight: isCurrentPage ? FontWeight.w600 : null),
            ),
          ],
        ),
      ),
    );
  }
}
