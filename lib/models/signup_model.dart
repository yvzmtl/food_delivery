
class SignUpModel{
  String? name;
  String? phone;
  String? email;
  String? password;

SignUpModel({
   required this.name,
  required this.phone,
  required this.email,
  required this.password
});
  

   SignUpModel.fromJson(Map<String, dynamic> json) {
    name = json['f_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

 
  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String,dynamic>();
    data["f_name"] = this.name;
    data["phone"] = this.phone;
    data["email"] = this.email;
    data["password"] = this.password;
    return data;
  }
  
}