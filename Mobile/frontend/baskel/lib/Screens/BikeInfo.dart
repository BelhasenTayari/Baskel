import 'dart:async';

import 'package:baskel/Classes/Bike.dart';
import 'package:baskel/Classes/MyCart.dart';
import 'package:flutter/material.dart';
import 'package:baskel/Constantes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BikeInfo extends StatefulWidget {
  Bike bike;
  BikeInfo({required this.bike});

  @override
  State<BikeInfo> createState() => _BikeInfoState();
}

class _BikeInfoState extends State<BikeInfo> {
  int selectedColorIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 32,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.favorite_border),
          )
        ],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 250,
                    child: Hero(
                      tag: '${widget.bike.id}',
                      child: Image.network(widget.bike.photo),
                    ),
                  ),
                ),
                Text(
                  widget.bike.brand,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.bike.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.bike.description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(25),
                              border: (selectedColorIndex == 0)
                                  ? Border.all(
                                      color: Colors.black,
                                      width: 2.5,
                                    )
                                  : null,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedColorIndex = 0;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25),
                              border: (selectedColorIndex == 1)
                                  ? Border.all(
                                      color: Colors.black,
                                      width: 2.5,
                                    )
                                  : null,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedColorIndex = 1;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.grey.shade300,
                          size: 35,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.bike.rate.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          " Reviews(300)",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                  child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset("lib/assets/images/speed.png"),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Speed",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${widget.bike.speed} KM/H",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset("lib/assets/images/star.png"),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Rating",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${widget.bike.rate}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Center(
                child: Text(
                  "${widget.bike.price.round()}\$ / jour",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: mainColor,
                  ),
                ),
              )),
              Expanded(child: Consumer<MyCart>(
                builder: (context, myCart, child) {
                  return GestureDetector(
                    onTap: () {
                      myCart.addBikeToCart(widget.bike);
                      Fluttertoast.showToast(
                        msg: "Bike added to cart successfuly",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Add to cart",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
            ],
          ),
        ],
      ),
    );
  }
}
