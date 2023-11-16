class Login{

  Login({required this.usuario, required this.senha});

  String usuario;
  String senha;

  Login.fromJson(Map<String, dynamic> json)
      : usuario = json['usuario'],
        senha = json['senha'];

  // criando o MAP
  Map<String, dynamic> toJson(){
    return {
      'usuario' : usuario,
      'senha': senha,
    };
  }
}