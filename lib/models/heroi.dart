import 'package:fl_desafio_marvel/models/comic.dart';

class Heroi {
  String nome;
  String imagem;
  String copyright;
  String id;
  String descricao;
  List<Comic> comics;

  Heroi({this.nome, this.imagem, this.copyright, this.id, this.descricao, this.comics});
}
