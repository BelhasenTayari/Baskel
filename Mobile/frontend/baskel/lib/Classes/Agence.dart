class Agence {
  String id;
  String nom;
  String adresse;
  String description;
  String photo;
  String email;
  String website;
  bool liked;

  Agence({
    required this.id,
    required this.nom,
    required this.adresse,
    required this.description,
    required this.photo,
    required this.email,
    required this.website,
    required this.liked,
  });

  factory Agence.fromMap(Map<String, dynamic> json) {
    String url =
        "http://192.168.1.12:3070/images/agencies/" + json['photo'].toString();
    print(json['liked'].toString());
    return Agence(
      id: json['id_agence'],
      nom: json['nom'],
      adresse: json['adresse'],
      description: json['description'],
      email: json['email'],
      photo: url,
      website: json['website'],
      liked: json['liked'].toString() == "true",
    );
  }
}
