import 'package:date_format/date_format.dart';

class Posto {
  int id;
  String nomeDoPosto;
  double precoAlcool;
  double precoGasolina;
  String horaConsulta = formatDate(DateTime.now(),[dd,"/",M,"/",yyyy, " às ",  H,":",mm,":",ss," hs"]);

  // criando um construtor vazio
  Posto();

  // criando um construtor
  Posto.fromMap(Map map){
    id              = map ["c_id"];
    nomeDoPosto     = map ["c_nomeDoPosto"];
    precoAlcool     = map ["c_precoAlcool"];
    precoGasolina   = map ["c_precoGasolina"];
    horaConsulta    = map ["c_horaConsulta"];
   }

  // o map irá acessar uma key, como string, e depois uma chave que eu desejo
   Map toMap() {
     // agora iremos fazer o inverso do anterio, iremos colocar o conteúdo
     // dos atributos no mapa, ficará como se fosse um json
     Map<String, dynamic> map = {
       "c_nomeDoPosto": nomeDoPosto,
       "c_precoAlcool": precoAlcool,
       "c_precoGasolina": precoGasolina,
       "c_horaConsulta": horaConsulta
     };
     // verificar se o id tem alguma coisa, para não adicionar nada em branco
     if (id != null) {
       map["c_id"] = id;
     }
     return map;
   }

  @override
  String toString() {
    return "Posto[ id: $id, "
        "nomeDoPosto: $nomeDoPosto, "
        "precoAlcool: $precoAlcool, "
        "precoGasolina: $precoGasolina, "
        "horaConsulta: $horaConsulta "
    "]";
  }
}
