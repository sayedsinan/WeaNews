import 'package:hive/hive.dart';
import 'package:jitak_machine/model/user_model.dart';

class HiveBoxes {
  static const String userBox = 'userBox';


  static Future<void> openBoxes() async {
    await Hive.openBox<UserModel>(userBox);
  }

  static Box<UserModel> getUserBox() => Hive.box<UserModel>(userBox);


  static Future<void> closeBoxes() async {
    await Hive.close();
  }
}
