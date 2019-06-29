import 'package:combustivel_ideal/helper/posto_helper.dart';
import 'package:combustivel_ideal/model/posto.dart';
import 'package:flutter/material.dart';

class PostoPage extends StatefulWidget {

  @override
  _PostoPageState createState() => _PostoPageState();
}

class _PostoPageState extends State<PostoPage> {

  PostoHelper helper = PostoHelper();

  // para podermos pegar os postos criados
  List<Posto> lsPostos = List();

  void showPostoPage({Posto posto}) async {
    final regPosto = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostoPage()),
    );
    if (regPosto != null) {
      if (posto != null) {
        await helper.update(regPosto);
      } else {
        await helper.insert(regPosto);
      }
      loadAllPostos();
    }
  }

  void loadAllPostos() {
    helper.selectAll().then((list) {
      setState(() {
        lsPostos = list;

      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllPostos();
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("Postos"),
      backgroundColor: Colors.green,
      centerTitle: true,
    );
  }


  Widget buildCardPosto(BuildContext context, int index) {
    return GestureDetector(
      child: Card(color: Colors.green,
        child: Padding(
          padding: EdgeInsets.all(08.0),

          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Posto: " + lsPostos[index].nomeDoPosto,
                      style: TextStyle(color: Colors.white,
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text("Preço do Àlcool: R\$ " + lsPostos[index].precoAlcool.toStringAsFixed(2),
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text("Preço da Gasolina: R\$ " + lsPostos[index].precoGasolina.toStringAsFixed(2),
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text("Consulta realizada em " + lsPostos[index].horaConsulta,
                      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                color: Colors.green,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Editar",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        //showPostoPage(posto: lsPostos[index]);
                      },
                    ),
                    FlatButton(
                      child: Text("Excluir",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      onPressed: () {
                        helper.delete(lsPostos[index].id);
                        setState(() {
                          lsPostos.removeAt(index);
                          Navigator.pop(context);
                        });
                      },
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  Widget buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: lsPostos.length,
      itemBuilder: (context, index) {
        return buildCardPosto(context, index);
      },
    );
  }

  Widget buildScaffold() {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.green[100],
      body: buildListView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }
}
