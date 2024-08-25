import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // TODO: Add Widget Binding
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  /// TODO: Init Local Storage
  GetStorage.init();

  // TODO: Init Payment Method

  // TODO: Await Native Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // TODO: Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  // TODO: Initialize Authentication

  runApp(const MyApp());
}