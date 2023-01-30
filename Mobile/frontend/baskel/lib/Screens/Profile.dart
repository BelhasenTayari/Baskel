import 'dart:convert';
import 'dart:io';
import 'package:baskel/Classes/Client.dart';
import 'package:baskel/Classes/MyCart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Constantes.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Future<Client> getClient(String email) async {
  //   final response = await http.post(
  //     Uri.parse('http://192.168.1.12:3070/getClient'),
  //     headers: {
  //       HttpHeaders.contentTypeHeader: 'application/json',
  //     },
  //     body: jsonEncode({
  //       'email': email,
  //     }),
  //   );

  //   var data = jsonDecode(response.body);
  //   return Future.value(Client.fromMap(data));
  // }

  // @override
  // void initState() {
  //   getClient("belhassentayari09@gmail.com").then((value) {
  //     setState(() {
  //       client = value;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: clientContent(),
      ),
    );
  }

  Widget clientContent() {
    return Consumer<MyCart>(
      builder: (context, myCart, child) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              color: mainColor,
              child: Container(
                alignment: const Alignment(0.0, 2.5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(myCart.client.image.toString()),
                  radius: 60.0,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "${myCart.client.prenom} ${myCart.client.nom}",
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              myCart.client.adresse.toString(),
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              myCart.client.email.toString(),
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),
            const SizedBox(height: 150),
            SizedBox(
              height: 70,
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Delete Account"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
              ),
            ),
          ],
        );
      },
    );
  }
}
