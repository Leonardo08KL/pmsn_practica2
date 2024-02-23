class UserModel {
  int? idUser;
  String? Name;
  String? Correo;
  String? contrasena;

  UserModel({this.idUser, this.Name, this.Correo, this.contrasena});

  factory UserModel.fromMap(Map<String, dynamic> user) {
    return UserModel(
      idUser: user['idUser'],
      Name: user['Name'],
      Correo: user['Correo'],
      contrasena: user['contrasena'],
    );
  }
}
