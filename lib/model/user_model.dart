import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart'; // required for Hive adapter

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final String imagePath;

  UserModel({
    required this.email,
    required this.password,
    required this.imagePath,
  });

  /// Derived name from email
  String get name {
    final prefix = email.split('@').first;
    final parts = prefix.split(RegExp(r'[._]')); // handle sayed.sinan or sayed_sinan
    return parts.first.capitalizeFirst ?? prefix;
  }
}
