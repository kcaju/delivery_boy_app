import 'package:delivery_boy_app/controller/signin_screen_controller.dart';
import 'package:delivery_boy_app/firebase_options.dart';
import 'package:delivery_boy_app/view/loginscreen/login_screen.dart';
import 'package:delivery_boy_app/view/loginscreen/widget/intermediate_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SigninScreenController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntermediateScreen(),
      ),
    );
  }
}
