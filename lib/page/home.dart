import 'package:combustivel_ideal/page/posto.dart';
import 'package:flutter/material.dart';
import 'package:combustivel_ideal/helper/posto_helper.dart';
import 'package:combustivel_ideal/model/posto.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Home extends StatefulWidget {

  final Posto posto;

  Home({this.posto});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PostoHelper helper = PostoHelper();

//  List<Posto> lsPostos = List();

  TextEditingController _nomeDoPostoController = TextEditingController();
  TextEditingController _precoAlcoolController = TextEditingController();
  TextEditingController _precoGasolinaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameFocus = FocusNode();

  bool _postoEdited = false;

  Posto _postoTemp;

  String combustivel = " ";

  @override
  void initState() {
    super.initState();
    if (widget.posto == null) {
      _postoTemp = Posto();
    } else {
      _postoTemp = Posto.fromMap(widget.posto.toMap());

      _nomeDoPostoController.text = _postoTemp.nomeDoPosto;
      _precoAlcoolController.text =_postoTemp.precoAlcool as String;
      _precoGasolinaController.text = _postoTemp.precoGasolina as String;

    }
  }

  void _resetFields() {
    _nomeDoPostoController.text = " ";
    _precoAlcoolController.text = " ";
    _precoGasolinaController.text = " ";
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("EDMM - COMBUSTÍVEIS"),
      backgroundColor: Colors.green,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostoPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildContainerImagem() {
    return GestureDetector(
      child: Container(
        child: Image.asset("assets/images/logo_splash.png"),
      ),
    );
  }

  void calcularCombustivel() {
    double alcool = double.parse(_precoAlcoolController.text);
    double gasolina = double.parse(_precoGasolinaController.text);

    double calculo = alcool / gasolina;

    if (calculo < 0.70) {
      combustivel = "o álcool";
    } else {
      combustivel = "a gasolina";
    }

    mensagemUsuario();
  }

  mensagemUsuario() {
    AlertDialog result = AlertDialog(
      title: Text("Atenção!"),
      content: Text("Para o abastecimento $combustivel é mais vantajoso!"),
      actions: <Widget>[
        FlatButton(
          child: Center(
              child: Text(
                "OK",
                style: TextStyle(fontSize: 18.0),
              )),
          onPressed: () {
            salvarPosto(_postoTemp);
            Navigator.pop(context);
            _resetFields();
          },
        ),
      ],
    );
    showDialog(context: context, child: result);
  }

  void salvarPosto(Posto _postoTemp){
    if(_postoTemp.id != null){
      helper.update(_postoTemp);
    }else{
      helper.insert(_postoTemp);
    }
  }

  Future<bool> _requestPop() {
    if (_postoEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se continuar as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);

                  },
                ),
                FlatButton(
                  child: Text("Continuar"),
                  onPressed: () {
                    Navigator.pop(context);
                    _resetFields();

                  },
                ),
              ],
            );
          });
      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }

  Widget buildScaffold() {
    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildContainerImagem(),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nome do Posto",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center,
                  controller: _nomeDoPostoController,
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Obrigatório";
                    }
                  },
                  onSaved: (text) {
                    _postoEdited = true;
                    setState(() {
                    _postoTemp.nomeDoPosto = text;
                    });
                  },

                  focusNode: _nameFocus,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Obrigatório";
                    }
                  },
                  onSaved: (text) {
                    _postoEdited = true;
                    //double.parse(_postoTemp.precoAlcool.toString());
                    _postoTemp.precoAlcool = double.parse(text);
                  },
                  decoration: InputDecoration(
                    labelText: "Preço do Álcool",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  controller: _precoAlcoolController =
                    new MaskedTextController(mask: '0.00'),
                ),

              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Obrigatório";
                    }
                  },
                  onSaved: (text) {
                    _postoEdited = true;
                    //double.parse(_postoTemp.precoGasolina.toString());
                    _postoTemp.precoGasolina = double.parse(text);
                  },
                  decoration: InputDecoration(
                    labelText: "Preço da Gasolina",
                    labelStyle: TextStyle(color: Colors.red, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
               controller: _precoGasolinaController =
               new MaskedTextController(mask: '0.00'),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                width: 150.0,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      calcularCombustivel();
                    }
                  },
                  child: Text(
                    "Verificar",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: Colors.green,
                  elevation: 5.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }
}
