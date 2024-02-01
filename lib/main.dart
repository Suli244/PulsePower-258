import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pulsepower_258/screen/splash/sp_screen.dart';
import 'package:pulsepower_258/screen/training_detail_screen/hive_model/train_hive_model.dart';
import 'package:pulsepower_258/style/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Apphud.start(apiKey: 'app_rhzmE4MhRQgHNZmn6RXBb48SZ4wzNn');
  await Hive.initFlutter();
  Hive.registerAdapter(TrainHiveModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pulse Power',
        home: child,
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColorsPulsePower.color1C1C1C,
            shadowColor: Colors.black,
          ),
          scaffoldBackgroundColor: AppColorsPulsePower.color1C1C1C,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
      ),
      child: const SplashScreen(),
    );
  }
}
