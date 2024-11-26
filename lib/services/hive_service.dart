import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pokedex_app/models/user_model.dart';

class HiveService {
  static final HiveService _hiveService = HiveService._internal();
  static const String _boxName = 'flutter_pokedex';
  static Box<dynamic>? _box;
  static UserModel? currentUser;
  factory HiveService() {
    return _hiveService;
  }

  HiveService._internal();
  static Future<void> init() async {
    if (_box != null && _box!.isOpen) return;
    final appDocumentDir = await getDirectory();
    Hive.init(appDocumentDir?.path);
    await adapterRegistration();
    _box = await Hive.openBox(_boxName);
    await setUser();
  }

  static Future<Directory?> getDirectory() async {
    return await path_provider.getApplicationDocumentsDirectory();
  }

  static Future<void> adapterRegistration() async {
    Hive.registerAdapter(UserModelAdapter());
  }

  static Future<void> saveUser(UserModel user) async {
    await init();
    currentUser = user;
    await _box!.put('user', user);
  }

  static Future<void> setUser() async {
    await init();
    currentUser = (_box!.get('user') as UserModel?);
  }

  static Future<void> clearDB() async {
    await init();
    await _box!.delete('user');
  }
}
