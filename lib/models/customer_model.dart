
class CustomerModel {
  final String id;
  final String name;
  final String hno;
  final String mobile;
  final String street;
  final String district;
  final String region;
  final String qr_code;
  final String category;
  final String user_id;

  CustomerModel({
    required this.id,
    required this.name,
    required this.hno,
    required this.mobile,
    required this.street,
    required this.district,
    required this.region,
    required this.qr_code,
    required this.category,
    required this.user_id,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json){
    return CustomerModel(
      id: json['title'] ??"", 
      name: json['name'] ??"", 
      hno: json['hno'] ??"", 
      mobile: json['mobile']??"", 
      street: json['street'] ??"", 
      district: json['district'] ??"", 
      region: json['region'] ??"", 
      qr_code: json['qr_code'] ??"", 
      category: json['category'] ??"", 
      user_id: json['user_id']??""
    );
  }
}