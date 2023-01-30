import 'dart:convert';
import 'dart:io';

import 'package:baskel/Classes/Agence.dart';
import 'package:baskel/Classes/MyCart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AgencyCard extends StatefulWidget {
  Agence agence;
  AgencyCard({required this.agence});

  @override
  State<AgencyCard> createState() => _AgencyCardState();
}

class _AgencyCardState extends State<AgencyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(widget.agence.photo),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.agence.nom,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          child: Icon(
                            (!widget.agence.liked)
                                ? Icons.favorite_border
                                : Icons.favorite,
                            size: 26,
                            color: (widget.agence.liked) ? Colors.red : null,
                          ),
                          onTap: () {
                            setState(() {
                              widget.agence.liked = !widget.agence.liked;
                              if (widget.agence.liked) {
                                likeAgence();
                                Provider.of<MyCart>(context, listen: false)
                                    .likeAgence(widget.agence);
                              } else {
                                dislikeAgence();
                                Provider.of<MyCart>(context, listen: false)
                                    .dislikeAgence(widget.agence);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.agence.description,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child:
                            Image.asset("lib/assets/images/world-wide-web.png"),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.agence.website,
                        style: const TextStyle(
                          color: Colors.blue,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  likeAgence() async {
    await http.post(
      Uri.parse('http://192.168.1.12:3070/likeAgence'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'email': Provider.of<MyCart>(context, listen: false).client.email,
        'id': widget.agence.id,
      }),
    );
  }

  dislikeAgence() async {
    await http.post(
      Uri.parse('http://192.168.1.12:3070/dislikeAgence'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'email': Provider.of<MyCart>(context, listen: false).client.email,
        'id': widget.agence.id,
      }),
    );
  }
}
