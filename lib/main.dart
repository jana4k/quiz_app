import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/authentication/auth_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(
                  const Size(double.infinity, 50),
                ),
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xffEB60DF)),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))))),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffE21FD0)),
        useMaterial3: true,
      ),
      home: const AuthenticationWrapper(),
    );
  }
}
