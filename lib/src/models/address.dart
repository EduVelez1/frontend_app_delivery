class Address {
  String? id;
  String? id_user;

  String? address;
  String? detail;
  List<Address> toList = [];

  Address({
    this.id,
    this.id_user,
    this.address,
    this.detail,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      id: json["id"] is int ? json['id'].toString() : json["id"],
      id_user:
          json["id_user"] is int ? json['id_user'].toString() : json["id_user"],
      address: json["address"],
      detail: json["detail"]);

  Address.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) => {toList.add(Address.fromJson(item))});
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": id_user,
        "address": address,
        "detail": detail,
      };
}
