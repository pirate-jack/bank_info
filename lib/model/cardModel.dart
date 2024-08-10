class Cardmodel {
  String name;
  int cardNumber;
  int cvv;
  int mm;
  int yy;

  Cardmodel(
      {required this.name,
      required this.cardNumber,
      required this.cvv,
      required this.mm,
      required this.yy});

  Map<String, dynamic> toMap() {
    return {
      'cardHolderName': name,
      'cardNumber': cardNumber,
      'cvv': cvv,
      'mm': mm,
      'yy': yy,
    };
  }

  factory Cardmodel.fromMap(Map<String, dynamic> data) {
    return Cardmodel(
      name: data['cardHolderName'] ?? '',
      cardNumber: data['cardNumber'] ?? 0,
      cvv: data['cvv'] ?? 0,
      mm: data['mm'] ?? 0,
      yy: data['yy'] ?? 0,
    );
  }
}
