import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:paperbrain/src/features/home/presentation/bindings/app_binding.dart';
import 'package:paperbrain/src/features/home/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize pdfrx
  pdfrxFlutterInitialize();

  // Initialize .env (Safely)
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // .env not found in production environment
    debugPrint(".env not found, using system environment instead.");
  }

  // Dependency Injection now managed by GetX Bindings (AppBinding)
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PaperBrain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      initialBinding: AppBinding(),
      home: const HomeScreen(),
    );
  }
}
