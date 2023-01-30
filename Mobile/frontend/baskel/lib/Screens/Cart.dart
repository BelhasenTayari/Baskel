import 'package:baskel/CartCard.dart';
import 'package:baskel/Classes/Bike.dart';
import 'package:baskel/Classes/MyCart.dart';
import 'package:baskel/Constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<MyCart>(builder: (context, myCart, child) {
        return Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Cart Items".toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: myCart.cart.length,
                    itemBuilder: (context, index) {
                      return CartCard(bike: myCart.cart.elementAt(index));
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Rent Now"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
