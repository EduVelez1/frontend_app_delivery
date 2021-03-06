class Rol {
  String? id;
  String? name;
  String? image;
  String? route;

  Rol({
    this.id,
    this.name,
    this.image,
    this.route,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        id: json["id"] is int ? json['id'].toString() : json["id"],
        name: json["name"],
        image: json["image"],
        route: json["route"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "route": route,
      };
}
