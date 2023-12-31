import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:p3l_gah_android/model/customer.dart';
import 'package:p3l_gah_android/model/user.dart';
import 'package:p3l_gah_android/routes/app_page.dart';
import 'package:p3l_gah_android/routes/app_route.dart';
import 'package:p3l_gah_android/theme/app_theme.dart';

import 'package:hive_flutter/adapters.dart';

Alice alice = Alice(showNotification: true, showInspectorOnShake: true);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(DataAdapter());
  Hive.registerAdapter(RoleAdapter());
  Hive.registerAdapter(CustomerAdapter());

  configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? widget) {
        return GetMaterialApp(
          getPages: AppPage.list,
          initialRoute: AppRoute.splashScreen,
          navigatorKey: alice.getNavigatorKey(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}
