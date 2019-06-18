import 'dart:io';

import 'package:slidy/src/models/modulo_model.dart';
import 'package:ansicolor/ansicolor.dart';

class Generate {
  AnsiPen pen = new AnsiPen()..red(bold: true);

  Generate(args) {
    if (args[1] == 'module' || args[1] == 'm') {
      module(args[2]);

    } else if (args[1] == 'component' || args[1] == 'c') {
      component(args[2]);
    }
  }

  module(String path) async {
    print("Criando módulo....");
    try {
      print("Criando pastas...");
      Directory directory = await Directory("src");
      if (directory.existsSync()) {
        throw Exception("O caminho especificado já existe");
      }else{
        await directory.create();
      }

       print("Criando arquivos...");

      File page = new File("${directory.path}/$path\_module.dart");
      if (page.existsSync()) {
        throw Exception("O arquivo especificado já existe");
      }
      
      String values = ModuloModel.model(path);
      File f = await page.writeAsString(values, mode: FileMode.write);

      print("Arquivos criado: ${page.path}");

      Process.runSync("flutter", ["format", f.absolute.path], runInShell: true);

      print("Processos terminados !");
    } catch (e) {
      print(pen("${e.message}"));
    }
  }

  component(String path) {
    print("Criando componente....");
    print("$path");
  }
}
