import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moon_phase_project/repositories/login_repository.dart';
import 'package:moon_phase_project/views/homePage.dart';
import 'package:moon_phase_project/views/registerPage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:styled_text/styled_text.dart';

import '../models/Login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginRepository loginRepository = LoginRepository();


  List<Login> todos = [];
  late FToast fToast;


  @override
  void initState() {
    super.initState(); // Essa linha é obrigatório
    loginRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: HexColor('#263238')
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                //Titulo
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: StyledText(
                      text: 'Bem-vindo ao <italic>Fases da Lua</italic>',
                      tags: {
                        'italic': StyledTextTag(
                          style: const TextStyle(
                            fontStyle: FontStyle.italic
                          )
                        )
                      },
                      style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                      ),
                    )
                ),

                //Imagem
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Image(
                    image:  AssetImage('../assets/images/background/earth_and_moon.png'),
                    fit: BoxFit.cover,
                    width: 580,
                  ),
                ),

                //Usuario
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: Colors.blue,
                    style: const TextStyle(color: Colors.blue),
                    controller: nameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue),
                      ),
                      labelText: 'Usuário',
                      hintText: 'Insira seu usuário',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 16
                      ),
                      hintStyle: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 12
                      ),
                    ),
                  ),
                ),

                //Senha
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.blue),
                    cursorColor: Colors.blue,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue),
                      ),
                      labelText: 'Senha',
                      hintText: 'Insira sua senha',
                      labelStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 16
                      ),
                      hintStyle: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 12
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //Esqueceu a Senha
                TextButton(
                  onPressed: () {
                    //Esqueci a senha
                    nameController.clear();
                    passwordController.clear();
                    loginRepository.cleanShared();
                    todos.clear();
                  },
                  child: Text(
                    'Esqueceu a senha?',
                    style: TextStyle(
                      color: Colors.purple.shade100
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //Login
                Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        //pushReplacement

                          if (checkLogin(nameController.text,
                              passwordController.text, todos)) {

                            _showToastSucess();

                            nameController.clear();
                            passwordController.clear();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          } else if (empty == false){
                              nameController.clear();
                              passwordController.clear();
                              _showToastError();

                          } else if (empty == true){
                              nameController.clear();
                              passwordController.clear();
                              _showToastEmpty();
                          }
                        },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.blue.withOpacity(0.2);
                              }
                              return Colors.white;
                            },
                          ),
                      ),
                      child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16
                          ),
                      ),
                    )
                ),
                const SizedBox(height: 16),
                //Cadastre-se
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Não tem conta?',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        TextButton(
                          child: const Text(
                            'Cadastre-se',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                        )
                      ]
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  void _showToastError() {
    Widget toast = Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration:
      BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red[600],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
              Icons.error,
              color: Colors.white
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Usuário ou Senha inválidos",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
  void _showToastSucess() {
    Widget toast = Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration:
      BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.green[900],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
              Icons.error,
              color: Colors.white
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Login realizado com Sucesso",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
  void _showToastEmpty() {
    Widget toast = Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration:
      BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red[600],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
              Icons.error,
              color: Colors.white
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Campos obrigatórios não preenchido",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }


}

bool empty = false, missing = false;
bool checkLogin(String usuario, String senha, List<Login> lista) {
  if (usuario.isNotEmpty && senha.isNotEmpty) {
    for (Login login in lista) {
      if (login.usuario == usuario && login.senha == senha) {
        return true;
      }
    }
  } else {
    empty = true;
  }
  return false;
}

