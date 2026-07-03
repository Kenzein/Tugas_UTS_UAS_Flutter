class CustomerModel {
  final String id;
  final String name;
  final String phone;

  CustomerModel({required this.id, required this.name, required this.phone});

  factory CustomerModel.fromMap(Map<String, dynamic> map, String documentId) {
    return CustomerModel(
      id: documentId,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'phone': phone};
  }
}
