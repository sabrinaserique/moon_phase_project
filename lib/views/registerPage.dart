import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moon_phase_project/models/Login.dart';
import 'package:moon_phase_project/repositories/login_repository.dart';
import 'package:moon_phase_project/views/loginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginRepository loginRepository = LoginRepository();

  List<Login> registros = [];

  @override
  void initState() {
    super.initState(); // Essa linha é obrigatória
    loginRepository.getTodoList().then((value) {
      setState(() {
        registros = value;
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
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
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Cadastrar'),
                    onPressed: () {
                      String usuario = nameController.text;
                      String senha = passwordController.text;
                      if(checkCadastro(usuario, senha)) {
                        Login newRegistro = Login(
                            usuario: usuario,
                            senha: senha);
                        registros.add(newRegistro);
                        nameController.clear();
                        passwordController.clear();

                        loginRepository.saveLoginList(registros);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      }else{
                        Fluttertoast.showToast(
                            msg: "Todos os campos são obrigatórios.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

bool checkCadastro(String usuario, String senha) {
  if (usuario.isNotEmpty && senha.isNotEmpty) {
    return true;
  }
  return false;
}
