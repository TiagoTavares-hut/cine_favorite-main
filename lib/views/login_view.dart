import 'package:cine_favorite/views/registro_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Atributos
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;
  bool _senhaOculta = true;

  // Método login
  void _login() async {
    try {
      await _authController.signInWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao Fazer Login $e")),
      );
    }
  }

  // Build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // fundo cinza claro
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar ícone
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[400],
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 30),

                // Campo de email
               TextField(
                 controller: _emailField,
                 style: TextStyle(
                   color: Colors.black, 
                   fontSize: 16,
                 ),
                 decoration: InputDecoration(
                   labelText: "Email",
                   labelStyle: TextStyle(color: Colors.purple), 
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8),
                     borderSide: BorderSide(color: Colors.grey), 
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8),
                     borderSide: BorderSide(color: Colors.purple, width: 2),
                   ),
                   filled: true,
                   fillColor: Colors.grey[200], // fundo do campo
                 ),
                 keyboardType: TextInputType.emailAddress,
               ),
               SizedBox(height: 16),
                // Campo de senha
                TextField(
                  style: TextStyle(
                   color: Colors.black, 
                   fontSize: 16,
                 ), 
                  controller: _senhaField,
                  obscureText: _senhaOculta,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _senhaOculta = !_senhaOculta;
                        });
                      },
                      icon: Icon(
                        _senhaOculta
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Botão Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Login"),
                  ),
                ),
                SizedBox(height: 16),

                // Botão de registrar
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistroView()),
                  ),
                  child: Text("Não tem uma conta? Registre-se"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
