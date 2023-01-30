import 'dart:math';

import 'package:latlong2/latlong.dart';

class Piste {
  String? nom;
  String? ville;
  String? description;
  LatLng? center;
  LatLng? start;
  LatLng? end;
  double? distance;

  Piste({
    this.nom,
    this.ville,
    this.description,
    this.center,
    this.start,
    this.end,
  });

  factory Piste.fromJson(Map<String, dynamic> json) {
    LatLng center = LatLng(double.parse(json['centerlat'].toString()),
        double.parse(json['centerlag'].toString()));
    LatLng start = LatLng(double.parse(json['startlat'].toString()),
        double.parse(json['startlag'].toString()));
    LatLng end = LatLng(double.parse(json['endlat'].toString()),
        double.parse(json['endlag'].toString()));
    return Piste(
      nom: json['nom'],
      ville: json['ville'],
      description: json['description'].toString(),
      center: center,
      start: start,
      end: end,
    );
  }
}
