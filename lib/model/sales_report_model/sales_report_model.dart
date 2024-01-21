class SalesReportModel {
  String id;
  String checkoutid;
  String prdtname;
  String prdtprice;
  String prdtqty = '1';
  String prdtcode;
  String date;

  SalesReportModel({
    required this.id,
    required this.checkoutid,
    required this.prdtname,
    required this.prdtprice,
    required this.prdtqty,
    required this.prdtcode,
    required this.date,
  });

  factory SalesReportModel.fromJson(Map<String, dynamic> json) =>
      SalesReportModel(
        id: json["id"],
        checkoutid: json['checkoutid'],
        prdtname: json["prdtname"],
        prdtprice: json["prdtprice"],
        prdtqty: json["prdtqty"],
        prdtcode: json["prdtcode"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "checkoutid": checkoutid,
        "prdtname": prdtname,
        "prdtprice": prdtprice,
        "prdtqty": prdtqty,
        "prdtcode": prdtcode,
        "date": date,
      };
}
