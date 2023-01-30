import 'package:baskel/Classes/MyCart.dart';
import 'package:baskel/Classes/evenement.dart';
import 'package:baskel/Constantes.dart';
import 'package:baskel/Widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCart>(builder: ((context, myCart, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: (myCart.events.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Center(
                    child: Text(
                      "Upcoming Events",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    height: 600,
                    child: ListView.builder(
                      itemCount: myCart.events.length,
                      itemBuilder: ((context, index) {
                        return EventCard(
                            evenement: myCart.events.elementAt(index));
                      }),
                    ),
                  ),
                ],
              ),
      );
    }));
  }
}
