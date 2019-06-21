
import 'package:slidy/slidy.dart';
import 'package:slidy/src/init.dart';
import 'package:slidy/src/package_manager.dart';

import 'package:slidy/src/utils/utils.dart';

main(List<String> args) async {
  if(args[0] == "generate" || args[0] == "g"){
    print("Gerador iniciado....");
    Generate(args);
  } else if(args[0] == "start" || args[0] == "s"){
    Init(args);
  } else if(args[0] == "install" || args[0] == "i"){
    PackageManager().install(args, checkParam(args, "--dev") );
  } else if(args[0] == "uninstall"){
    PackageManager().uninstall(args, checkParam(args, "--dev"));
  } else if(args[0] == "update"){
    PackageManager().update(args, checkParam(args, "--dev"));
  } else if(args[0] == "--version" || args[0] == "-v"){
    print("Slidy version:${await getVersion()}");
  } else {
    print("Comando inválido");

  }

}
