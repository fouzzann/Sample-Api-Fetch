class User{
  final int id;
  final String name;
  final String email;
  final String department;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.department
  });
  factory User.formJson(Map<String,dynamic> json){
    return User(id: json['id'], name: json['name'], email: json['email'], department: json['department']);
  }
}