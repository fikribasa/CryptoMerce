class UserModel {
  String? id;
  String? fullName;
  String? imageUrl;
  String? email;
  String? ktpNumber;
  String? phoneNumber;
  String? dob;
  String? pin;

  UserModel(
      {this.id,
      this.fullName,
      this.imageUrl,
      this.email,
      this.ktpNumber,
      this.phoneNumber,
      this.dob,
      this.pin});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    imageUrl = json['image_url'];
    email = json['email'];
    ktpNumber = json['ktp_number'];
    phoneNumber = json['phone_number'];
    dob = json['dob'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['image_url'] = this.imageUrl;
    data['email'] = this.email;
    data['ktp_number'] = this.ktpNumber;
    data['phone_number'] = this.phoneNumber;
    data['dob'] = this.dob;
    data['pin'] = this.pin;
    return data;
  }
}
