import 'package:baskel/Authentification/Login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    showProgressBar();
  }

  Future showProgressBar() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 43, 63, 66),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "BASKEL",
                style: TextStyle(
                  fontSize: 70,
                  letterSpacing: 5,
                  color: Colors.white,
                  fontFamily: 'BebasNeue',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Bike rent app",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 200),
              if (loading) const CircularProgressIndicator(color: Colors.white),
              if (loading) const SizedBox(height: 20),
              if (loading)
                const Text(
                  "Please wait...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
