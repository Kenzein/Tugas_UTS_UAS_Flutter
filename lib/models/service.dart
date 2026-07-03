class Service {
  final String? id;
  final String name;
  final int price;

  Service({this.id, required this.name, required this.price});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(id: json['id'], name: json['name'], price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price};
  }
}
