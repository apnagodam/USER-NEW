import 'package:apnagodam/presentation/login_screen/models/AuthenticationModel.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Future<bool> addNewMovie(UserDetailsAuth m) async {
    var db = await Db.create(
        "mongodb+srv://apnagodam:l2F97uxKZ73eq251@cluster0.humxj.mongodb.net/userData");
    await db.open();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    db.collection(androidInfo.id.toString()).drop();

    var userDetailsCollection = db.collection(androidInfo.id.toString());
    await userDetailsCollection.createIndex(keys: {
      'createdAt': 1,
    }); // 1 hour
    try {
      Map<String, dynamic> sampleMap = {};
      sampleMap.addAll(m.toMap());

      await userDetailsCollection.insert(sampleMap);

      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}

final databaseProvider = Provider((ref) => Database());
