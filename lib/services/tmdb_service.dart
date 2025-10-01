//meu serviço de conexão com API TMDB

import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbService {
  //colocar os dados da API
  static const String _apiKey = "1fa5c2d59029fd1c438cc35713720604";
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _idioma = "pt-BR";
  //static -> atributo é da classe e nao do objeto

  // metodo Static => medotos da Classe -> nao precisa instanciar Objeto
  // para chamar o metodo

  //buscar filme na API pelo Termo
  //buscar filme na API pelo Termo
  static Future<List<Map<String,dynamic>>> searchMovie(String termo) async{
    //converter String em URL
    final apiURI = Uri.parse(
      "$_baseUrl/search/movie?api_key=$_apiKey&language=$_idioma&query=$termo",
      );
    //http request -> get
    final response = await http.get(apiURI);

    //verificar a resposta
    if(response.statusCode==200){
      //converter a resposta de json para dart
      final data = json.decode(response.body);
      //transformar data(string) em List<Map>
      return List<Map<String,dynamic>>.from(data["results"]);
    }else{//caso contrario
      //criar uma exception
      throw Exception("Erro ao buscar filmes");
    }
  }
}
