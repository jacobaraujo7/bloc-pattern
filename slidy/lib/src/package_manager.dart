import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec/pubspec.dart';
import 'package:slidy/src/utils/utils.dart';

class PackageManager {
  install(List<String> packs, bool isDev) async {
    packs.removeAt(0);
    packs.removeWhere((t) => t == "--dev");
    PubSpec spec = await getPubSpec();
    var dependencies = isDev ? spec.devDependencies : spec.dependencies;

    for (String pack in packs) {
      String packName = "";
      String version = "";

      if (pack.contains(":")) {
        packName = pack.split(":")[0];
        version = pack.split(":")[1];
      } else {
        packName = pack;
      }

      if (dependencies.containsKey(packName)) {
        print("Package já está instalado");
        continue;
      }

      try {
        version = await consumeApi(packName, version);
        dependencies[packName] =
            HostedReference(VersionConstraint.parse("^$version"));
        print("Add $packName:$version in pubspec");
      } catch (e) {
        print(e);
        print("Versão ou package não encontrado");
      }

      spec = isDev
            ? spec.copy(devDependencies: dependencies)
            : spec.copy(dependencies: dependencies);
        await spec.save(Directory(""));

    }
  }

  update(List<String> packs, bool isDev) async {
    packs.removeAt(0);
    packs.removeWhere((t) => t == "--dev");
    PubSpec spec = await getPubSpec();
    var dependencies = isDev ? spec.devDependencies : spec.dependencies;

    for (String pack in packs) {
      
    

    if (!dependencies.containsKey(pack)) {
      print("Package não está instalado");
      continue;
    }

    String version = await consumeApi(pack, "");
    dependencies[pack] = HostedReference(VersionConstraint.parse("^$version"));
    
    print("Update $pack in pubspec");
    }

    spec = isDev
        ? spec.copy(devDependencies: dependencies)
        : spec.copy(dependencies: dependencies);
    await spec.save(Directory(""));

  }

  uninstall(List<String> packs, bool isDev) async {
    packs.removeAt(0);
    packs.removeWhere((t) => t == "--dev");
     PubSpec spec = await getPubSpec();
    var dependencies = isDev ? spec.devDependencies : spec.dependencies;

    for(String pack in packs){

   

    if (!dependencies.containsKey(pack)) {
      print("Package não está instalado");
      continue;
    }
    dependencies.remove(pack);
    
    print("Remove $pack from pubspec");
  }

  spec = isDev
        ? spec.copy(devDependencies: dependencies)
        : spec.copy(dependencies: dependencies);
    await spec.save(Directory(""));
  }
}
