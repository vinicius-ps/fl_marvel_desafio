import 'package:fl_desafio_marvel/utils/hash.dart';
import 'package:fl_desafio_marvel/utils/keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> pegarInfoHeroi(String heroi) async {
  //print(heroi);
  Map informacoes = pegarHashTimeStamp(privateKey, publicKey);

  final String request =
      'http://gateway.marvel.com:80/v1/public/characters?ts=${informacoes['timestamp']}&apikey=${informacoes['public']}&hash=${informacoes['hash']}&name=$heroi&limit=100';

  http.Response response = await http.get(request);

  //print(response.body);
  Map resposta = json.decode(response.body);

  return resposta;
}
