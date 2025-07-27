import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jitak_machine/controller/login_controller.dart';
import 'package:jitak_machine/controller/news_controller.dart';
import 'package:jitak_machine/controller/register_controller.dart';
import 'package:jitak_machine/controller/weather_controller.dart';
import 'package:jitak_machine/model/user_model.dart';
import 'package:jitak_machine/services/hive_boxes.dart';
import 'package:jitak_machine/view/login_page.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  Hive.registerAdapter(UserModelAdapter());

  await HiveBoxes.openBoxes();
  Get.put(LoginController());
  Get.put(NewsController());
  Get.put(WeatherController());
  Get.put(RegisterController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
