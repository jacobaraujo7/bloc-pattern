import 'package:slidy/slidy.dart';
import 'package:slidy/src/init.dart';

main(List<String> args) {
  if(args[0] == "generate" || args[0] == "g"){
    print("Gerador iniciado....");
    Generate(args);
  } else if(args[0] == "init" || args[0] == "i"){
    Init(args);
  } else {
    print("Comando inválido");
  }

}
