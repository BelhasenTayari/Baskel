import 'package:baskel/Classes/evenement.dart';
import 'package:baskel/Constantes.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  Evenement evenement;
  EventCard({required this.evenement});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(children: [
        ListTile(
          title: Text("Evenement ${evenement.id.toString()}"),
          subtitle: Text(evenement.address.toString()),
        ),
        Divider(),
        ListTile(
          title: Text(evenement.date.toString().substring(0, 10)),
          subtitle: Text("${evenement.heure}H"),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(evenement.description.toString()),
        ),
      ]),
    );
    ;
  }
}
