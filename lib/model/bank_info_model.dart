class BankInfoModel {
  String name;
  String accountNumber;
  String accountType;
  String ifscCode;

  BankInfoModel({
    required this.name,
    required this.accountNumber,
    required this.accountType,
    required this.ifscCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'accountHolderName': name,
      'accountNumber': accountNumber,
      'accountType': accountType,
      'accountIFSC': ifscCode,
    };
  }

  factory BankInfoModel.fromMap(Map<String, dynamic> map) {
    return BankInfoModel(
      name: map['accountHolderName'],
      accountNumber: map['accountNumber'],
      accountType: map['accountType'],
      ifscCode: map['accountIFSC'],
    );
  }
}
