import 'dart:convert';
import 'dart:io';

import 'package:baskel/Classes/MyCart.dart';
import 'package:baskel/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../HomeDefault.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool hide = true;
  bool valid = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController adresseController = TextEditingController();

  int etat = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 43, 63, 66),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 8 - 40),
              Container(
                height: MediaQuery.of(context).size.height * 2 / 3 + 70,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (etat == 0) firstPage(),
                        if (etat == 1) SecondPage(),
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.12:3070/insert_client'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'phone': phoneController.text.toString(),
        'cin': cinController.text.toString(),
        'password': passwordController.text.toString(),
        'email': emailController.text.toString(),
        'nom': nomController.text.toString(),
        'prenom': prenomController.text.toString(),
        'adresse': adresseController.text.toString(),
      }),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "User registered successfuly",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Provider.of<MyCart>(context, listen: false)
          .loadClient(emailController.text.toString());
      Provider.of<MyCart>(context, listen: false)
          .getAgencies(emailController.text.toString());
      Provider.of<MyCart>(context, listen: false)
          .getBikes(emailController.text.toString());
      Provider.of<MyCart>(context, listen: false)
          .getLikedBikes(emailController.text.toString());
      Provider.of<MyCart>(context, listen: false)
          .getLikedAgencies(emailController.text.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeDefault(),
        ),
      );
    }
  }

  clientExist() async {
    String email = emailController.text.toString();
    final response = await http.post(
      Uri.parse('http://192.168.1.12:3070/search_client'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    var data = jsonDecode(response.body).toString();

    if (data == "true") {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Widget firstPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Phone number",
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset('lib/assets/images/tunisia-flag.jpg'),
                    const SizedBox(width: 10),
                    const Text(
                      "+216",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 55,
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  // errorText: (!valid) ? "Tel est Obligatoire !" : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: "Tel",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 25,
                  ),
                ),
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "E-mail",
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: TextField(
            controller: emailController,
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "E-mail",
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 25,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const Text(
          "Password",
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 20,
          ),
          child: TextField(
            controller: passwordController,
            autocorrect: false,
            obscureText: hide,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    hide = !hide;
                  });
                },
                child: const Icon(Icons.remove_red_eye),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Password",
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 17,
                horizontal: 25,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              if (!(phoneController.text.toString().isEmpty ||
                  emailController.text.toString().isEmpty ||
                  passwordController.text.toString().isEmpty)) {
                clientExist().then(((value) {
                  if (value) {
                    setState(() {
                      etat = 1;
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: "User exists! try to login",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                }));
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 43, 63, 66),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: const Text(
              "Next",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget SecondPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cin",
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 20,
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: cinController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Votre CIN",
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 17,
                horizontal: 25,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const Text(
          "Nom",
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: TextField(
            controller: nomController,
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Nom",
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 25,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const Text(
          "Prénom",
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: TextField(
            controller: prenomController,
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Prénom",
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 25,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const Text(
          "Adresse",
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: TextField(
            controller: adresseController,
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Password",
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 25,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              if (!(cinController.text.toString().isEmpty ||
                  nomController.text.toString().isEmpty ||
                  prenomController.text.toString().isEmpty ||
                  adresseController.text.toString().isEmpty)) {
                sendMessage();
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 43, 63, 66),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
