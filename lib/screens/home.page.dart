import 'package:fl_desafio_marvel/models/comic.dart';
import 'package:fl_desafio_marvel/models/heroi.dart';
import 'package:fl_desafio_marvel/screens/details.page.dart';
import 'package:fl_desafio_marvel/screens/widgets/genericos.dart';
import 'package:fl_desafio_marvel/screens/widgets/page.view.dart';
import 'package:fl_desafio_marvel/services/heroi.service.dart';
import 'package:fl_desafio_marvel/utils/numeros.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'Marvel', fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: MyPageView(),
    );
  }
}

class WidgetHeroi extends StatefulWidget {
  final String _heroi;
  const WidgetHeroi(this._heroi, {Key key}) : super(key: key);

  @override
  _WidgetHeroiState createState() => _WidgetHeroiState();
}

class _WidgetHeroiState extends State<WidgetHeroi> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: pegarInfoHeroi(widget._heroi),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: new WidgetLoading(),
            );
          default:
            if (snapshot.hasError) {
              return new WidgetErroCarregar();
            } else {
              Heroi _heroi = filtrarInformacoesHeroi(snapshot.data);

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: new WidgetLoading(),
                        ),
                        FittedBox(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: _heroi.imagem,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          child: Text(
                            _heroi.nome.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Avengence',
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            navigateToComicPage(context, _heroi);
                          },
                          height: 55,
                        ),
                      ),
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                      child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          //onTap: () { },
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  _heroi.descricao,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Comic',
                                  ),
                                ),
                              ),
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              );
            }
        }
      },
    );
  }

  Future navigateToComicPage(context, _heroi) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ComicPage(_heroi)));
  }

  Heroi filtrarInformacoesHeroi(Map resposta) {
    var items = resposta['data']['results'][0]['comics']['items'];
    var caminhoImagem = resposta["data"]["results"][0]["thumbnail"];
    List<Comic> comicsHeroi = List();
    List<int> numeros = pegarNumerosAleatorios(0, 20, 5);
    numeros.forEach((n) {
      comicsHeroi
          .add(new Comic(nome: items[n]['name'], url: items[n]['resourceURI']));
    });

    var description = resposta["data"]["results"][0]["description"];

    if (resposta["data"]["results"][0]["name"] == 'Deadpool') {
      description =
          'Was born on October 23, 1976 in Vancouver, British Columbia, Canada, the youngest of four children. His father, James Chester Reynolds, was a food wholesaler, and his mother, Tamara Lee "Tammy" (Stewart), worked as a retail-store saleswoman. He has Irish and Scottish ancestry.';
    }

    //print(resposta["data"]["results"][0]);

    Heroi _heroi = new Heroi(
      id: resposta["data"]["results"][0]["od"],
      nome: resposta["data"]["results"][0]["name"],
      imagem: caminhoImagem["path"] + '.' + caminhoImagem['extension'],
      copyright: resposta['copyright'],
      descricao: description,
      comics: comicsHeroi,
    );

    return _heroi;
  }
}
