import 'package:flutter/material.dart';
import 'views/general/splash_screen.dart';
import 'package:frontend/views/utils/colors.dart';
import 'my_services.dart';

Future<void> main() async {
  MyService myService = MyService();
  myService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen Management App',
      theme: ThemeData(
        fontFamily: "Metropolis",
        primarySwatch: Colors.red,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            AppColor.orange,
          ),
          shape: MaterialStateProperty.all(
            const StadiumBorder(),
          ),
          elevation: MaterialStateProperty.all(0),
        )),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColor.primary, fontSize: 25),
          bodyMedium: TextStyle(
            color: AppColor.secondary,
          ),
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
