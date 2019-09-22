import 'package:fl_desafio_marvel/models/comic.dart';
import 'package:fl_desafio_marvel/models/heroi.dart';
import 'package:fl_desafio_marvel/screens/widgets/genericos.dart';
import 'package:fl_desafio_marvel/services/comic.service.dart';
import 'package:flutter/material.dart';

class ComicPage extends StatefulWidget {
  final Heroi _heroi;

  const ComicPage(
    this._heroi, {
    Key key,
  }) : super(key: key);

  @override
  _ComicPageState createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  @override
  Widget build(BuildContext context) {
    //print('comic ${widget._heroi.nome} - ${widget._heroi.comics.length}');
    List<Comic> lista = widget._heroi.comics;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'COMIC BOOKS',
            style: TextStyle(fontFamily: 'Marvel', fontSize: 40),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index) {
            return FutureBuilder<Map>(
              future: pegarInfoComic(widget._heroi.comics[index].url),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new WidgetLoading(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return new WidgetErroCarregar();
                    } else {
                      Comic comic = filtrarInformacoesComic(snapshot.data);
                      return Stack(
                        children: <Widget>[
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              children: <Widget>[
                                Image.network(
                                  comic.imagem,
                                  fit: BoxFit.fill,
                                ),
                                InkWell(
                                  splashColor: Colors.blue.withAlpha(30),
                                  child: Container(
                                    child: Text(
                                      comic.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Comic',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                          ),
                        ],
                      );
                    }
                }
              },
            );
          },
        ));
  }

  Comic filtrarInformacoesComic(Map resposta) {
    var conteudo = resposta["data"]["results"][0];
    var caminhoImagem = conteudo["thumbnail"];
    Comic _comic = new Comic(
      id: conteudo["id"],
      title: conteudo["title"],
      description: conteudo["description"],
      pageCount: conteudo["pageCount"].toString(),
      imagem: caminhoImagem["path"] + '.' + caminhoImagem["extension"],
    );

    return _comic;
  }
}
