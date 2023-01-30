import 'dart:convert';
import 'dart:io';
import 'package:baskel/Classes/MyCart.dart';
import 'package:baskel/Constantes.dart';
import 'package:baskel/HomeDefault.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'Signup.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hide = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  Future<bool> login() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.12:3070/login'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'email': emailController.text.toString(),
        'password': passwordController.text.toString(),
      }),
    );

    var data = jsonDecode(response.body).toString();

    if (data == "true") {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

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
                "Login",
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
                        const Text(
                          "Email address",
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
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "Your email",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 25,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),

                        //Password Input
                        /*
                        *
                        *
                        */
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
                                vertical: 20,
                                horizontal: 25,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "Forgot password?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 43, 63, 66),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Consumer<MyCart>(
                            builder: (context, myCart, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    loading = true;
                                  });
                                  login().then((value) => {
                                        if (value)
                                          {
                                            myCart.loadClient(
                                              emailController.text.toString(),
                                            ),
                                            myCart.getAgencies(
                                              emailController.text.toString(),
                                            ),
                                            myCart.getBikes(
                                              emailController.text.toString(),
                                            ),
                                            myCart.getLikedAgencies(
                                              emailController.text.toString(),
                                            ),
                                            myCart.getLikedBikes(
                                              emailController.text.toString(),
                                            ),
                                            myCart.getEvents(),
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeDefault(),
                                              ),
                                            )
                                          }
                                        else
                                          {
                                            setState(() {
                                              loading = false;
                                            }),
                                            Fluttertoast.showToast(
                                              msg: "ERROR login",
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 1,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            ),
                                          }
                                      });
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
                                child: (loading)
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Sign in",
                                        style: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 1,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have account?"),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()));
                                },
                                child: const Text(
                                  "Create new account",
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
}
