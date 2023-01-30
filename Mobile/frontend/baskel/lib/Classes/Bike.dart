class Bike {
  String id;
  String brand;
  String name;
  String photo;
  String description;
  String color;
  double price;
  double rate;
  double? speed;
  bool liked;

  Bike({
    required this.id,
    required this.brand,
    required this.name,
    required this.photo,
    required this.description,
    required this.price,
    required this.color,
    required this.rate,
    this.speed,
    required this.liked,
  });

  factory Bike.fromMap(Map<String, dynamic> json) {
    String url =
        "http://192.168.1.12:3070/images/bikes/" + json['image'].toString();
    return Bike(
      id: json["id"].toString(),
      brand: json['marque'].toString(),
      color: json['color'].toString(),
      photo: url,
      description: json['description'].toString(),
      price: double.parse(json['prix'].toString()),
      rate: double.parse(json['rate'].toString()),
      name: json['nom'].toString(),
      speed: double.parse(json['speed'].toString()),
      liked: json['liked'].toString() == "true",
    );
  }
}
