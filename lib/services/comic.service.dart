import 'package:fl_desafio_marvel/utils/hash.dart';
import 'package:fl_desafio_marvel/utils/keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> pegarInfoComic(String link) async {
  Map informacoes = pegarHashTimeStamp(
      privateKey,
      publicKey);

  final String request =
      '$link?ts=${informacoes['timestamp']}&apikey=${informacoes['public']}&hash=${informacoes['hash']}';

  http.Response response = await http.get(request);
  //print(request);
  Map resposta = json.decode(response.body);

  return resposta;
}
