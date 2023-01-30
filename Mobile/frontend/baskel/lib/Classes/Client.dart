class Client {
  String email;
  String? cin;
  String? nom;
  String? prenom;
  String? image;
  String? tel;
  String? adresse;

  Client({
    required this.email,
    this.cin,
    this.nom,
    this.prenom,
    this.image,
    this.tel,
    this.adresse,
  });

  factory Client.fromMap(Map<String, dynamic> json) {
    String url =
        "http://192.168.1.12:3070/images/clients/" + json['image'].toString();
    return Client(
      email: json['email'].toString(),
      cin: json['cin'].toString(),
      nom: json['nom'].toString(),
      prenom: json['prenom'].toString(),
      tel: json['tel'].toString(),
      adresse: json['adresse'].toString(),
      image: url,
    );
  }
}
