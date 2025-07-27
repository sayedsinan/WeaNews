import 'package:hive/hive.dart';
import 'package:jitak_machine/model/user_model.dart';

class HiveUserService {
  static const String _userBox = 'userBox';

  static Future<void> registerUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(_userBox);
    await box.put(user.email, user);
  }

  static Future<UserModel?> getUser(String email) async {
    final box = await Hive.openBox<UserModel>(_userBox);
    return box.get(email);
  }

  static Future<void> deleteUser(String email) async {
    final box = await Hive.openBox<UserModel>(_userBox);
    await box.delete(email);
  }
}
