import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dps/network/http.dart';
import 'package:dps/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import 'common/helper.dart';
import 'network/ssl_override.dart';
import 'provider/login_provider.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };
    dio.interceptors.add(LogInterceptor());

    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    await FlutterDownloader.initialize(debug: true);

    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    await initializeDateFormatting('id_ID', null)
        .then((_) => runApp(const MyApp()));
    // runApp(MyApp());
  }, (Object error, StackTrace stack) {
    // LoginProvider().sendError(error.toString());
    wLogs(error.toString());
    wLogs(stack.toString());
    // myErrorsHandler.onError(error, stack);
    // exit(1);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pengajuan Surat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
