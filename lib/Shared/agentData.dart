class AgentInfo {
  late final String uid;
  late final String fullname;
  late final String gender;
  late final String phone;
  late final String companyname;
  late final String companyaddress;

  AgentInfo({
    required this.uid,
    required this.fullname,
    required this.gender,
    required this.phone,
    required this.companyname,
    required this.companyaddress,
  });

  factory AgentInfo.froJson(Map<String, dynamic> json) {
    return AgentInfo(
        uid: json['uid'],
        fullname: json['fullname'],
        gender: json['gender'],
        phone: json['phone'],
        companyname: json['companyname'],
        companyaddress: json['companyaddress']);
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'gender': gender,
      'phone': phone,
      'companyname': companyname,
      'companyaddress': companyaddress,
    };
  }
}

//Rentdata
class RentData {
  late final String uid;
  late final String hostelname;
  late final String location;
  late final String typehouse;
  late final String amount;
  late final String description;
  late final String status;

  RentData({
    required this.uid,
    required this.hostelname,
    required this.location,
    required this.typehouse,
    required this.amount,
    required this.description,
    required this.status,
  });

  factory RentData.froJson(Map<String, dynamic> json) {
    return RentData(
      uid: json['uid'],
      hostelname: json['hostelname'],
      location: json['location'],
      typehouse: json['typehouse'],
      amount: json[' amount'],
      description: json['description'],
      status: json[' status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'hostelname': hostelname,
      'location': location,
      'typhouse': typehouse,
      'amount': amount,
      'description': description,
      'status': status,
    };
  }
}

//Land Data

class LandData {
  late final String uid;
  late final String ownerName;
  late final String location;
  late final String Nacres;
  late final String price;
  late final String agentName;

  LandData({
    required this.uid,
    required this.ownerName,
    required this.location,
    required this.agentName,
    required this.Nacres,
    required this.price,
  });

  factory LandData.froJson(Map<String, dynamic> json) {
    return LandData(
      uid: json['uid'],
      ownerName: json['ownerName'],
      location: json['location'],
      agentName: json['agentName'],
      Nacres: json['Nacres'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'ownerName': ownerName,
      'location': location,
      'agentName': agentName,
      'Nacres': Nacres,
      'price': price,
    };
  }
}

//client data
class ClientData {
  late final String uid;
  late final String fullName;
  late final String gender;
  late final String phone;
  late final String address;
  late final String email;

  ClientData({
    required this.uid,
    required this.fullName,
    required this.gender,
    required this.phone,
    required this.address,
    required this.email,
  });

  factory ClientData.froJson(Map<String, dynamic> json) {
    return ClientData(
      uid: json['uid'],
      fullName: json['fullName'],
      gender: json['gender'],
      phone: json['phone'],
      address: json['address'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'gender': gender,
      'phone': gender,
      'address': address,
      'email': email,
    };
  }
}
