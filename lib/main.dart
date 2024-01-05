import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir_mobile/color.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

// background notif
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // permission firebase
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // listen background message notif
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //listen foreground message notif
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      RemoteNotification notification = message.notification!;
      Get.defaultDialog(
        title: notification.title!,
        content: Text(notification.body!),
        titlePadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(10),
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  });

  await GetStorage.init();
  await GetStorage.init('cart');
  await GetStorage.init('favorite');

  var initial_route = Routes.WELCOME;
  if (box.read('token') != null && box.read('status') == 'Active') {
    initial_route = Routes.MAIN;
  } else if (box.read('token') != null && box.read('status') == 'Verify' ||
      box.read('status') == 'ResetPassword') {
    initial_route = Routes.VERIFY;
  } else if (box.read('token') != null && box.read('status') == 'Banned') {
    initial_route = Routes.BANNED;
  } else if (box.read('status') == 'SetPassword') {
    initial_route = Routes.SET_PASSWORD;
  }

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: initial_route,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: primary,
        scaffoldBackgroundColor: Colors.transparent,
      ),
    ),
  );

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
}
