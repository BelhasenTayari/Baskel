import 'dart:convert';
import 'dart:io';

import 'package:baskel/Classes/Agence.dart';
import 'package:baskel/Classes/Bike.dart';
import 'package:baskel/Classes/Client.dart';
import 'package:baskel/Classes/evenement.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Classes/Piste.dart';

class MyCart extends ChangeNotifier {
  List<Bike> cart = [];
  List<Bike> bikes = [];
  List<Bike> likedBikes = [];
  List<Agence> agencies = [];
  List<Agence> likedAgencies = [];
  List<Piste> pistes = [];
  List<Evenement> events = [];

  Client client = Client(email: "email");

  addBikeToCart(Bike b) {
    cart.add(b);
    notifyListeners();
  }

  loadClient(String email) {
    if (client != null) {
      getClient(email).then((value) {
        client = value;
        notifyListeners();
      });
    }
  }

  Future<Client> getClient(String email) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.12:3070/getClient'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    var data = jsonDecode(response.body);
    return Future.value(Client.fromMap(data));
  }

  getBikes(String email) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.12:3070/getBikes'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    var result = jsonDecode(response.body);
    final data = result as List<dynamic>;

    List<Bike> bikesFetched = data.map((e) => Bike.fromMap(e)).toList();
    bikes = bikesFetched;
    notifyListeners();
  }

  getAgencies(String email) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.12:3070/getAgencies'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    var result = jsonDecode(response.body);
    final data = result as List<dynamic>;

    List<Agence> agenciesFetched = data.map((e) => Agence.fromMap(e)).toList();
    agencies = agenciesFetched;
    notifyListeners();
  }

  getLikedBikes(String email) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.12:3070/getLikedBikes'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    var result = jsonDecode(response.body);
    final data = result as List<dynamic>;

    List<Bike> bikesFetched = data.map((e) => Bike.fromMap(e)).toList();

    likedBikes = bikesFetched;

    for (var a in likedBikes) {
      a.liked = true;
    }
    notifyListeners();
  }

  getLikedAgencies(String email) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.12:3070/getLikedAgencies'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    var result = jsonDecode(response.body);
    final data = result as List<dynamic>;

    List<Agence> AgenciesFetched = data.map((e) => Agence.fromMap(e)).toList();
    likedAgencies = AgenciesFetched;
    for (var a in likedAgencies) {
      a.liked = true;
    }
    notifyListeners();
  }

  getEvents() async {
    final response =
        await http.post(Uri.parse('http://192.168.1.12:3070/getEvents'));

    var result = jsonDecode(response.body);
    print(result);
    final data = result as List<dynamic>;

    List<Evenement> eventsFetched =
        data.map((e) => Evenement.fromMap(e)).toList();
    events = eventsFetched;
    notifyListeners();
  }

  likeBike(Bike b) {
    likedBikes.add(b);
    notifyListeners();
  }

  likeAgence(Agence a) {
    likedAgencies.add(a);
    notifyListeners();
  }

  dislikeAgence(Agence a) {
    Agence? c;
    for (var i in likedAgencies) {
      if (a.id == i.id) {
        c = i;
      }
    }
    likedAgencies.remove(c);
    notifyListeners();
  }
}
