import 'dart:convert';
import 'dart:io';
import 'package:guia_de_moteis/models/motel_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({this.baseUrl = 'https://jsonkeeper.com/b/1IXK'});

  //faz uma requisição HTTP GET para buscar a lista de motéis da API e retorna uma List<Motel>
  Future<List<Motel>> fetchMotels() async {
    final response = await http.get(Uri.parse(baseUrl));

     final utf8Body = utf8.decode(response.bodyBytes);


    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8Body);

      // Obtendo o total de motéis
      final totalMoteis = jsonResponse['data']['moteis'].length;


      return (jsonResponse['data']['moteis'] as List)
          .map((motel) => Motel.fromJson(motel))
          .toList();
    } else {
      throw Exception('Erro ao carregar motéis');
    }
  }
}

//essa classe usamos para ignorar erros de certificados SSL invalidos em requisições
//nunca usar isso em produção
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
