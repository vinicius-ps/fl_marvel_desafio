import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

Map pegarHashTimeStamp(String private, String public) {
  final String timeStamp = new DateTime.now().millisecondsSinceEpoch.toString();

  final String keys = '$private$public';

  final String hashear = timeStamp + keys;

  var content = new Utf8Encoder().convert(hashear);
  var md5 = crypto.md5;
  var digest = md5.convert(content);

  final String hasheado = hex.encode(digest.bytes);

  Map map = new Map();
  map['public'] = public;
  map['hash'] = hasheado;
  map['timestamp'] = timeStamp;

  return map;
}
