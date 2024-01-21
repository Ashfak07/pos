class FactureModel {
  int? id;
  String? price;
  String? date;

  FactureModel({required this.price, required this.date});

  FactureModel.fromJson(Map<String, dynamic> map) {
    id = map['id'] != null ? map['id'] : '';
    price = map['price'] != null ? map['price'].toString() : '';
    date = map['date'] != null ? map['date'].toString() : '';
  }

  toJson() {
    return {'price': price, 'facturedate': date};
  }
}
