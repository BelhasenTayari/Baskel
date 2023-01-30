import 'package:baskel/Classes/Bike.dart';
import 'package:flutter/material.dart';

class BikeCard extends StatefulWidget {
  Bike bike;
  BikeCard({required this.bike});

  @override
  State<BikeCard> createState() => _BikeCardState();
}

class _BikeCardState extends State<BikeCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 330,
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.height - 20,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Hero(
                      tag: '${widget.bike.id}',
                      child: Image.network(widget.bike.photo),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.bike.brand,
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.bike.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.bike.price.round()}\$ / jour",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                          Text(
                            widget.bike.rate.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.black,
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
          ),
          Positioned(
            right: 30,
            top: 25,
            child: Icon(
              (!widget.bike.liked) ? Icons.favorite_border : Icons.favorite,
              size: 26,
              color: (widget.bike.liked) ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }
}
