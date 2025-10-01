import 'package:cine_favorite/views/favoritos_view.dart';
import 'package:cine_favorite/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{ //o async serve para estabelecer uma conexao com o firebase 
  //antes de executar o app
  //garantir o carregamento dos widgets primeiro
  WidgetsFlutterBinding.ensureInitialized();

  //conectar com o firebase
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "Cine Favorite",
    theme: ThemeData(
      primarySwatch: Colors.orange,
      brightness: Brightness.dark
    ),
    home: AuthStream(), // permite a navegação de tela de acordo com alguma decisão
  ));
}

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    //ouvinte da mudança de status (listener)
    return StreamBuilder<User?>(//permitir retorno null para usuario?
      // StreamBuilder ele consegue monitorar o status da autenticacao
      // Stream ele espera alguma mudanca
      //ouvinte da mudança de status do usuário
      stream: FirebaseAuth.instance.authStateChanges(),
      //identific a mudanca de status do usuario(logodo ou nao) 
      builder: (context, snapshot){ //analisa o instantâneo da aplicação
        //se tiver logado, vai para a tela de favoritos
        if(snapshot.hasData){
          return FavoriteView();
        }//caso contrario => tela de login
        return LoginView();
      });
  }
}