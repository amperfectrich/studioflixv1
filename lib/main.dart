// @dart=2.9
// --no-sound-null-safety

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'common/global.dart';
import 'my_app.dart';
import '/services/repository/database_creator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  FlutterDownloader.initialize();
  await DatabaseCreator().initDatabase();

  // HttpOverrides.global = new MyHttpOverrides();

  authToken = await storage.read(key: "token");
  runApp(MyApp(token: authToken));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          // (X509Certificate cert, String host, int port) => true;
          (X509Certificate cert, String host, int port) {
        return host == "example.com" ? true : false;
      };
  }
}
