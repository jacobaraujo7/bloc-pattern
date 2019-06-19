import 'dart:io';
import 'package:path/path.dart';
import 'package:slidy/src/utils/utils.dart';

import 'models/bloc_model.dart';
import 'models/component_model.dart';

import 'package:slidy/src/models/modulo_model.dart';
import 'package:ansicolor/ansicolor.dart';

class Generate {
  AnsiPen error = new AnsiPen()..red(bold: true);
  AnsiPen green = new AnsiPen()..green(bold: true);
  AnsiPen white = new AnsiPen()..white(bold: true);

  Generate(args) {
    if (args[1] == 'module' || args[1] == 'm') {
      module(args[2]);
    } else if (args[1] == 'component' || args[1] == 'c') {
      component(args[2]);
    } else {
      addModule("Edit", args[1]);
    }
  }

  module(String path) async {
    path = validPath(path);

    print("Criando módulo....");
    try {
      print("Criando pastas...");
      Directory directory = Directory(path);
      String name = basename(directory.path);
      String nameCap = formatName(name);
      if (directory.existsSync()) {
        throw Exception("O caminho especificado já existe");
      } else {
        await directory.create(recursive: true);
      }

      print("Criando arquivos...");
      
      File page = new File("${directory.path}/$name\_module.dart");
      if (page.existsSync()) {
        throw Exception("O arquivo especificado já existe");
      }

      String values = ModuloModel.model(nameCap);
      File f = await page.writeAsString(values, mode: FileMode.write);

      print("Arquivos criado: ${page.path}");

      Process.runSync("flutter", ["format", f.absolute.path], runInShell: true);

      print("Processos terminados !");
    } catch (e) {
      print(error("${e.message}"));
    }
  }

  component(String path) async {
    path = validPath(path);
    var dir = Directory(path);
    String name = basename(dir.path);
    if (dir.existsSync()) {
      print(error("Já existe um component $name"));
      exit(1);
    }
    dir.createSync(recursive: true);
    var fileview = File(path + "/" + "${name}_page.dart");
    var filebloc = File(path + "/" + "${name}_bloc.dart");

    print(white("Criando arquivos..."));
    String nameCap = formatName(name);
    fileview.createSync();
    fileview.writeAsStringSync(ComponentModel().model(nameCap));
    Process.runSync("flutter", ["format", fileview.path], runInShell: true);
    print("Criado arquivos ${white(fileview.path)}");
    filebloc.createSync();
    filebloc.writeAsStringSync(BlocModel().model(nameCap));
    Process.runSync("flutter", ["format", filebloc.path], runInShell: true);
    print("Criado arquivos ${white(filebloc.path)}");
    await addModule(nameCap, filebloc.path);
    print(green("Completed!"));
  }

  addModule(String nameCap, String path) async {

    File module = findModule(path);
    if(module == null){
      print(error("Nenhum módulo encontrado"));
      exit(1);
    }
    
    var node = module.readAsStringSync().split("\n");
    node.insert(0, "import 'package:${await getNamePackage()}/${path.replaceFirst("lib/", "")}';");
    int index = node.indexWhere((t) => t.contains("blocs => ["));
    node[index] = node[index]
        .replaceFirst("blocs => [", "blocs => [Bloc((i) => ${nameCap}Bloc()),");
    module.writeAsStringSync(node.join("\n"));
    Process.runSync("flutter", ["format", module.path], runInShell: true);
    print("Modificado ${white(module.path)}");
  }

  File findModule(String path) {
    var dir = Directory(path);
    bool loop = true;
    int count = 0;
    File module;
    do {
      module = search(dir);
      dir = dir.parent;
      loop = module == null && basename(dir.path) != 'lib' && count < 10;
      count++;
    } while (loop);

    return module;
  }

  File search(Directory dir) {
    try {
      return dir
          .listSync()
          .firstWhere((f) => f is File && f.path.contains("_module.dart"));
    } catch (e) {
      return null;
    }
  }

  String validPath(String path) {
    return "lib/app/$path";
  }
}
