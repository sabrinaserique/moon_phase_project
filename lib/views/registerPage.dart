import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon_phase_project/models/Login.dart';
import 'package:moon_phase_project/repositories/login_repository.dart';
import 'package:moon_phase_project/views/loginPage.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

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
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          leading: const BackButton(
            color: Colors.white,
          ),
      ),
      body: Container(
        decoration: BoxDecoration(
              color: HexColor('#263238')
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[

              //Titulo
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Cadastro de Usuários',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 20
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Realize o seu cadastro para acessar a aplicação',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14
                            ),
                          ),
                        ],
                      )
                    ],
                  )
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  cursorColor: Colors.blue,
                  style: TextStyle(color: Colors.blue),
                  controller: nameController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blue, width: 0.0),
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
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.blue, width: 0.0),
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
                  height: 80,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top:14, bottom: 14),
                  child: ElevatedButton(
                    onPressed: () {
                      String usuario = nameController.text;
                      String senha = passwordController.text;
                      if (checkCadastro(usuario, senha)) {
                        Login newRegistro =
                            Login(usuario: usuario, senha: senha);
                        registros.add(newRegistro);
                        nameController.clear();
                        passwordController.clear();

                        loginRepository.saveLoginList(registros);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      } else {
                        /*Fluttertoast.showToast(
                            msg: "Todos os campos são obrigatórios.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);*/
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
                        'Cadastrar',
                        style: TextStyle(
                          color: Colors.blue
                        ),
                    ),
                  )
              ),
              //Imagem
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Image(
                  image:  AssetImage('../assets/images/background/solar_system.png'),
                  fit: BoxFit.cover,
                  width: 450,
                ),
              ),
            ]),
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
