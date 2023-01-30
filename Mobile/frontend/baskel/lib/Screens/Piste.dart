import 'package:baskel/Classes/MyCart.dart';
import 'package:baskel/Constantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:routing_client_dart/routing_client_dart.dart';
import 'package:baskel/Classes/Piste.dart';

class PistePage extends StatefulWidget {
  const PistePage({super.key});

  @override
  State<PistePage> createState() => _PistePageState();
}

class _PistePageState extends State<PistePage> {
  late MapController _mapController;
  int selectedPiste = 0;

  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey =
      '5b3ce3597851110001cf62486d5cfc78392446fba599f60bfeffe0dd';

  final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; // For holding instance of Marker
  List<String> instructions = [];

  final String profile = 'cycling-regular';
  double d = 0;

  List<LatLng> points = [];
  getDirections() async {
    points = [];
    final String url =
        'https://api.openrouteservice.org/v2/directions/${profile}?api_key=5b3ce3597851110001cf624892482b83497246f1b0d2bd58cb7c8bb3&start=${pistes.elementAt(selectedPiste).start!.longitude},${pistes.elementAt(selectedPiste).start!.latitude}&end=${pistes.elementAt(selectedPiste).end!.longitude},${pistes.elementAt(selectedPiste).end!.latitude}';
    final response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body);
    var xy = data['features'][0]['geometry']['coordinates'] as List<dynamic>;
    String distance =
        data['features'][0]['properties']['segments'][0]['distance'].toString();

    var json = jsonDecode(response.body);
    var segments = json["features"][0]["properties"]["segments"];
    List<String> instruction = [];
    for (var segment in segments) {
      for (var step in segment["steps"]) {
        instruction.add(step["instruction"]);
      }
    }

    print("instructions length = ${instructions.length}");
    print("distance = $distance");
    print("xy lenght = ${xy.length}");

    for (var i in xy) {
      points.add(
          LatLng(double.parse(i[1].toString()), double.parse(i[0].toString())));
    }
    setState(() {
      d = double.parse(distance) / 1000;
      instructions = instruction;
    });
  }

  List<Piste> pistes = [];
  Future<List<Piste>> getPistes() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.12:3070/getPistes'),
    );

    var result = jsonDecode(response.body);
    final data = result as List<dynamic>;

    List<Piste> pistesFetched = data.map((e) => Piste.fromJson(e)).toList();
    print("length = ${pistesFetched.length}");
    return pistesFetched;
  }

  @override
  void initState() {
    _mapController = MapController();
    getPistes().then((value) {
      setState(() {
        pistes = value;
      });
      print("length = ${pistes.length}");
      getDirections();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "center = (${pistes.elementAt(selectedPiste).center!.latitude}, ${pistes.elementAt(selectedPiste).center!.latitude})");
    // print(
    //     "start = (${pistes.elementAt(selectedPiste).start!.latitude}, ${pistes.elementAt(selectedPiste).start!.latitude})");
    // print(
    //     "end = (${pistes.elementAt(selectedPiste).end!.latitude}, ${pistes.elementAt(selectedPiste).end!.latitude})");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                (pistes.isEmpty)
                    ? Center(
                        child: CircularProgressIndicator(color: mainColor),
                      )
                    : FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          center: pistes.elementAt(selectedPiste).center,
                          zoom: 14,
                          onLongPress: (tapPosition, point) =>
                              {print("pressed")},
                        ),
                        nonRotatedChildren: [
                          AttributionWidget.defaultWidget(
                            source: 'OpenStreetMap contributors',
                            onSourceTapped: null,
                          ),
                        ],
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: pistes.elementAt(selectedPiste).start!,
                                width: 50,
                                height: 50,
                                builder: (context) => const Icon(
                                    Icons.location_pin,
                                    size: 50,
                                    color: Colors.green),
                              ),
                              Marker(
                                point: pistes.elementAt(selectedPiste).end!,
                                width: 50,
                                height: 50,
                                builder: (context) => const Icon(
                                    Icons.location_pin,
                                    size: 50,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          if (pistes.isNotEmpty)
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: points,
                                  color: Colors.red,
                                  strokeWidth: 5,
                                ),
                              ],
                            ),
                        ],
                      ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _mapController.move(
                              _mapController.center,
                              _mapController.zoom + 1,
                            );
                          },
                          child: Icon(Icons.add),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _mapController.move(
                              _mapController.center,
                              _mapController.zoom - 1,
                            );
                          },
                          child: Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: MediaQuery.of(context).size.width / 2 - 70,
                  child: Container(
                    width: 140,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Distance",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "${d.toStringAsFixed(1)} KM",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPiste--;
                            if (selectedPiste == -1) {
                              selectedPiste = pistes.length - 1;
                            }
                            _mapController.move(
                              pistes.elementAt(selectedPiste).center!,
                              _mapController.zoom,
                            );
                          });
                          getDirections();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "${pistes.elementAt(selectedPiste).nom}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPiste++;
                            if (selectedPiste == pistes.length) {
                              selectedPiste = 0;
                            }
                            _mapController.move(
                              pistes.elementAt(selectedPiste).center!,
                              _mapController.zoom,
                            );
                          });
                          getDirections();
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    pistes.elementAt(selectedPiste).description!,
                    style: const TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("DIRECTIONS"),
                              Container(
                                height: 600,
                                child: ListView.builder(
                                    itemCount: instructions.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          instructions.elementAt(index),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Get Directions"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
