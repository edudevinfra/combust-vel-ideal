import 'package:combustivel_ideal/model/posto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PostoHelper {

  // criando uma variável static, pois nunca irá mudar
  static final PostoHelper _instance = PostoHelper.internal();

  // internal é um construtor então toda vez que precisamos é só instanciá-lo
  PostoHelper.internal();

  // criando uma classe factory porque não será recriada sempre que chamarmos a classe BD (POO)
  factory PostoHelper() => _instance;

  //Database é a classe do SQFlite que iremos usar, por isso iremos usa-la
  Database _db;

  // sempre que formos acessar alguma coisa utilizar o future, pois ele é uma transação alheia
  Future<Database> get db async {
    if (_db != null) {
      //caso exista, retorna este _bd existente
      return _db;
    }
    // chamamos agora o initDb que irá iniciar o nosso banco de dados
    _db = await initDb();
    return _db;
  }

  // iniciando nosso banco de dados em async pois ele é uma transição
  // o join() junta duas coisas, no caso iremos juntar o diretorio juntamente com o nosso banco de dados
  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDB = join(path, "posto.db");

    // aqui iremos criar o SQL que é outra linguagem, por isso, colocaremos
    // dentro de aspas, pois é string
    final String sql = "CREATE TABLE posto ("
        "c_id INTEGER PRIMARY KEY,"
        "c_nomeDoPosto TEXT,"
        "c_precoAlcool REAL,"
        "c_precoGasolina REAL"
        "c_horaConsulta TEXT"
        ")";

    // após ter acesso ao local do nosso BD, iremos abri-lo
    //criando o método openDatabase que irá criar o nosso BD
    return await openDatabase(
        pathDB,
        version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(sql);
    }
    );
  }

  // create
  Future<Posto> insert(Posto posto) async {
    Database dbPosto = await db;
    posto.id = await dbPosto.insert("posto", posto.toMap());
    return posto;
  }

  //Read
  Future<Posto> selectById(int id) async {
    Database dbPosto = await db;
    List<Map> maps = await dbPosto.query(
        "posto",
        columns: [
          "c_id",
          "c_nomeDoPosto",
          "c_precoAlcool",
          "c_precoGasolina",
          "c_horaConsulta"
        ],
        where: "c_id = ?",
        whereArgs: [id]
    );
    if (maps.length > 0) {
      return Posto.fromMap(maps.first);
    } else {
      return null;
    }
  }

  //Read
  Future<List> selectAll() async {
    Database dbPosto = await db;
    List list = await dbPosto.rawQuery("SELECT * FROM posto");
    List<Posto> lsPosto = List();
    for (Map p in list) {
      lsPosto.add(Posto.fromMap(p));
    }
    return lsPosto;
  }

  //Update
  Future<int> update(Posto posto) async {
    Database dbPosto = await db;
    return await dbPosto.update("posto", posto.toMap(),
        where: "c_id = ?", whereArgs: [posto.id]);
  }

  //Delete
  Future<int> delete(int id) async {
    Database dbPosto = await db;
    return await dbPosto.delete("posto", where: "c_id = ?", whereArgs: [id]);
  }

  Future close() async {
    Database dbPosto = await db;
    dbPosto.close();
  }
}
