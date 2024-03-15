import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makki_tv_app/admin/admin_home.dart';
import 'package:makki_tv_app/firebase_options.dart';
import 'package:makki_tv_app/home_page.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WakelockPlus.enable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MediaQuery.sizeOf(context).width > 600
          ? const HomePage()
          : const AdminHome(),
    );
  }
}
