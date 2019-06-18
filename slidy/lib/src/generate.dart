import 'dart:io';
import 'package:path/path.dart';
import 'package:slidy/src/utils/utils.dart';

import 'models/bloc_model.dart';
import 'models/component_model.dart';
import 'package:ansicolor/ansicolor.dart';

class Generate {

  Generate(args){
    if(args[1] == 'module' || args[1] == 'm'){
       module(args[2]);
    } else if(args[1] == 'component' || args[1] == 'c'){
       component(args[2]);
    } 
  }

  module(String path){
    print("$path");
  }

  component(String path){
    AnsiPen error = new AnsiPen()..red(bold: true);
    AnsiPen green = new AnsiPen()..green(bold: true);
    AnsiPen white = new AnsiPen()..white(bold: true);
    var dir = Directory(path);
    String name = basename(dir.path);
    if(dir.existsSync()){
      print(error("Já existe um component $name"));
      exit(1);
    }
    dir.createSync();
    var fileview = File(path+"/"+"${name}_page.dart");
    var filebloc = File(path+"/"+"${name}_bloc.dart");

    print(white("Criando arquivos..."));
    String nameCap = formatName(name);
    fileview.createSync();
    fileview.writeAsStringSync(ComponentModel().model(nameCap));
    Process.runSync("flutter", ["format", fileview.path], runInShell: true);
    print("Criado arquivos ${white(basename(fileview.path))}");
    filebloc.createSync();
    filebloc.writeAsStringSync(BlocModel().model(nameCap));
    Process.runSync("flutter", ["format", filebloc.path], runInShell: true);
    print("Criado arquivos ${white(basename(filebloc.path))}");
    print(green("Completed!"));
  }
  
}