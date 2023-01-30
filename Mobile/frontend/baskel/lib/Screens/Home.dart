import 'dart:convert';
import 'dart:io';

import 'package:baskel/Classes/Agence.dart';
import 'package:baskel/Classes/Bike.dart';
import 'package:baskel/Classes/MyCart.dart';
import 'package:baskel/Screens/BikeInfo.dart';
import 'package:baskel/Widgets/AgencyCard.dart';
import 'package:baskel/Widgets/BikeCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../Classes/Client.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCart>(builder: (context, myCart, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Most Popular",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 330,
                  child: ListView.builder(
                    itemCount: myCart.bikes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => BikeInfo(
                                      bike: myCart.bikes.elementAt(index),
                                    )),
                              ),
                            );
                          }),
                          child: BikeCard(
                            bike: myCart.bikes.elementAt(index),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Find Agencies",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 400,
                  child: ListView.builder(
                    itemCount: (myCart.agencies.length > 3)
                        ? 3
                        : myCart.agencies.length,
                    itemBuilder: ((context, index) {
                      return AgencyCard(
                          agence: myCart.agencies.elementAt(index));
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
