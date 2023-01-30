import 'package:flutter/material.dart';

import 'Classes/Bike.dart';

class CartCard extends StatefulWidget {
  Bike bike;
  CartCard({required this.bike});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20)),
                  width: 120,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 17, left: 5, right: 5),
                    child: Image.network(widget.bike.photo),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    widget.bike.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${widget.bike.price} TND",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.orange,
                    ),
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.remove)),
                      const Text(
                        "1",
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                      Expanded(child: Container()),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
