import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'main_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  await _initHive();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  String key = dotenv.get('PUBLISH_KEY',fallback: "");
  Stripe.publishableKey = key ;
  Stripe.instance.applySettings();

  runApp(const MainApp(

  ));
}

Future<void> _initHive() async{
  await Hive.initFlutter();
  await Hive.openBox("login");
  await Hive.openBox("accounts");
}
