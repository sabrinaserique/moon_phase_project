import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moon_phase_project/repositories/login_repository.dart';
import 'package:moon_phase_project/views/homePage.dart';
import 'package:moon_phase_project/views/registerPage.dart';

import '../models/Login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginRepository loginRepository = LoginRepository();

  List<Login> todos = [];

  @override
  void initState() {
    super.initState(); // Essa linha é obrigatória
    loginRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sky.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Bem-vindo',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  cursorColor: Colors.blue,
                  style: TextStyle(color: Colors.blue),
                  controller: nameController,
                  decoration: const InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 0.0),
                    ),
                    labelText: 'Usuario',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.blue),
                  cursorColor: Colors.blue,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 0.0),
                    ),
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  //Esqueci a senha
                  nameController.clear();
                  passwordController.clear();
                  loginRepository.cleanShared();
                  todos.clear();
                },
                child: const Text(
                  'Esquece a senha?',
                ),
              ),
              const SizedBox(height: 16),
              Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      //pushReplacement

                      if (checkLogin(nameController.text,
                          passwordController.text, todos)) {
                        nameController.clear();
                        passwordController.clear();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      } else {
                        nameController.clear();
                        passwordController.clear();

                        Fluttertoast.showToast(
                            msg: "Usuário ou senha inválido.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  )),
              const SizedBox(height: 16),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Não tem conta?',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextButton(
                      child: const Text(
                        'Cadastre-se',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                    )
                  ]),
            ]),
          ),
        ),
      ),
    );
  }
}

bool checkLogin(String usuario, String senha, List<Login> lista) {
  if (usuario.isNotEmpty && senha.isNotEmpty) {
    for (Login login in lista) {
      if (login.usuario == usuario && login.senha == senha) {
        return true;
      }
    }
  }

  return false;
}
