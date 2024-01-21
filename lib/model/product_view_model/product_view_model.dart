class ProductviewModel {
  String id;
  String prdtcatname;
  String prdtname;
  String prdtprice;
  String prdtqty = '1';
  String prdtcode;
  String prdtiamge;

  ProductviewModel({
    required this.id,
    required this.prdtcatname,
    required this.prdtname,
    required this.prdtprice,
    required this.prdtqty,
    required this.prdtcode,
    required this.prdtiamge,
  });

  factory ProductviewModel.fromJson(Map<String, dynamic> json) =>
      ProductviewModel(
        id: json["id"],
        prdtcatname: json["prdtcatname"],
        prdtname: json["prdtname"],
        prdtprice: json["prdtprice"],
        prdtqty: json["prdtqty"],
        prdtcode: json["prdtcode"],
        prdtiamge: json["prdtiamge"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prdtcatname": prdtcatname,
        "prdtname": prdtname,
        "prdtprice": prdtprice,
        "prdtqty": prdtqty,
        "prdtcode": prdtcode,
        "prdtiamge": prdtiamge,
      };
}
