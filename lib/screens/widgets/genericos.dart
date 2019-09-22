
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WidgetLoading extends StatelessWidget {
  const WidgetLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCubeGrid(color: Colors.red),
    );
  }
}

class WidgetErroCarregar extends StatelessWidget {
  const WidgetErroCarregar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Erro ao carregar dados',
        style: TextStyle(color: Colors.red, fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }
}

