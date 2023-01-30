import 'dart:convert';
import 'dart:io';

import 'package:baskel/Classes/MyCart.dart';
import 'package:baskel/Constantes.dart';
import 'package:baskel/Widgets/AgencyCard.dart';
import 'package:baskel/Widgets/BikeCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Classes/Agence.dart';
import '../Classes/Bike.dart';

import 'package:http/http.dart' as http;

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  int selectedIndex = 0;

  BoxDecoration selectedContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: mainColor,
  );

  BoxDecoration unselectedContainer = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    border: Border.all(width: 2),
  );

  TextStyle selectedStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  TextStyle unselectedStyle = TextStyle(
    fontSize: 16,
    letterSpacing: 0.5,
    color: mainColor,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCart>(builder: ((context, myCart, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: (selectedIndex == 0)
                            ? selectedContainer
                            : unselectedContainer,
                        child: Center(
                          child: Text(
                            "Agencies",
                            style: (selectedIndex == 0)
                                ? selectedStyle
                                : unselectedStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: (selectedIndex == 1)
                            ? selectedContainer
                            : unselectedContainer,
                        child: Center(
                          child: Text(
                            "Bikes",
                            style: (selectedIndex == 1)
                                ? selectedStyle
                                : unselectedStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: (selectedIndex == 0)
                  ? ListView.builder(
                      itemCount: myCart.likedAgencies.length,
                      itemBuilder: ((context, index) {
                        return AgencyCard(
                            agence: myCart.likedAgencies.elementAt(index));
                      }),
                    )
                  : ListView.builder(
                      itemCount: myCart.likedBikes.length,
                      itemBuilder: ((context, index) {
                        return BikeCard(
                            bike: myCart.likedBikes.elementAt(index));
                      }),
                    ),
            ),
          ],
        ),
      );
    }));
  }
}
