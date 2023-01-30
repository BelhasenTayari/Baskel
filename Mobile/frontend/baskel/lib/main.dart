import 'package:baskel/Classes/MyCart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyCart>(
      create: (context) => MyCart(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Baskel',
        color: Colors.black,
        home: Splash(),
      ),
    );
  }
}
