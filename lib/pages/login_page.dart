import 'package:flutter/material.dart';
import 'package:appdioteste/pages/main_page.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController senhaController = TextEditingController(text: "");
  bool isObscured = true;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // Permite a tela rolar se o conteúdo for grande
          child: SizedBox(
            // Ocupa a altura total disponível na tela, útil com SingleChildScrollView
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. ESPAÇO NO TOPO
                const SizedBox(height: 50),

                // 2. LOGO
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: Image(
                        image: AssetImage("assets/images/Logo.png"),
                      ),
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),

                const SizedBox(height: 0),
                const Text(
                  "Já tem cadastro?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Faça seu Login and make the change_",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),

                // 4. CAMPO DE EMAIL
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 135,
                        child: Text("Informe seu E-mail:",
                            textAlign: TextAlign.right),
                      ),
                      SizedBox(width: 0),
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          onChanged: (value) {
                            debugPrint(value);
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.email),
                            hintText: "E-mail",
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // 5. CAMPO DE SENHA (corrigido)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 135,
                        child: Text("Informe a senha:",
                            textAlign: TextAlign.right),
                      ),
                      Expanded(
                        child: TextField(
                          obscureText: isObscured,
                          controller: senhaController,
                          onChanged: (value) {
                            debugPrint(value);
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Senha",
                            isDense: true,
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                              child: Icon(
                                isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // 6. BOTÃO DE LOGIN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if(emailController.text.isEmpty || senhaController.text.isEmpty){
                            debugPrint("Por favor, preencha todos os campos.");
                            return;
                          }
                          if (emailController.text == 'emailteste@gmail.com' &&
                              senhaController.text == 'abc123456') {
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Login bem-sucedido!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            debugPrint("Login bem-sucedido!");
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(
                                builder:(context)=>const MainPage()
                                ));
                          } 
                          
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Credenciais inválidas."),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            debugPrint("Credenciais inválidas.");
                          }
                          debugPrint(emailController.text);
                          debugPrint(senhaController.text);
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.blue),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text(
                    "Esqueci minha senha",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text(
                    "Criar conta",
                    style: TextStyle(fontSize: 14),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
