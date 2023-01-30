class Evenement {
  String? id;
  String? idOrganization;
  String? idPiste;
  String? date;
  String? heure;
  String? address;
  String? description;

  Evenement({
    this.id,
    this.idOrganization,
    this.idPiste,
    this.date,
    this.heure,
    this.address,
    this.description,
  });

  factory Evenement.fromMap(Map<String, dynamic> json) {
    return Evenement(
      id: json["id"].toString(),
      address: json["id"].toString(),
      idOrganization: json["id_organization"].toString(),
      idPiste: json["id_piste"].toString(),
      date: json["date"].toString(),
      heure: json["heure"].toString(),
      description: json["description"].toString(),
    );
  }
}
