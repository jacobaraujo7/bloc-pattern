import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec/pubspec.dart';
import 'package:slidy/src/utils/utils.dart';

class PackageManager {
  install(String pack, bool isDev) async {
    PubSpec spec = await getPubSpec();
    var dependencies = isDev ? spec.devDependencies : spec.dependencies;

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
      exit(1);
    }

    try {
      version = await consumeApi(packName, version);
      dependencies[packName] =
          HostedReference(VersionConstraint.parse("^$version"));
      spec = isDev ? spec.copy(devDependencies: dependencies) : spec.copy(dependencies: dependencies);
      await spec.save(Directory(""));
      print("Add $packName:$version in pubspec");
    } catch (e) {
      print(e);
      print("Versão ou package não encontrado");
    }
  }

  update(String pack, bool isDev) async {
    PubSpec spec = await getPubSpec();
        var dependencies = isDev ? spec.devDependencies : spec.dependencies;

    if (!dependencies.containsKey(pack)) {
      print("Package não está instalado");
      exit(1);
    }

    String version = await consumeApi(pack, "");
    dependencies[pack] = HostedReference(VersionConstraint.parse("^$version"));
    spec = isDev ? spec.copy(devDependencies: dependencies) : spec.copy(dependencies: dependencies);
    await spec.save(Directory(""));
    print("Update $pack in pubspec");
  }

  uninstall(String pack, bool isDev) async {
    PubSpec spec = await getPubSpec();
        var dependencies = isDev ? spec.devDependencies : spec.dependencies;

    if (!dependencies.containsKey(pack)) {
      print("Package não está instalado");
      exit(1);
    }
    dependencies.remove(pack);
    spec = isDev ? spec.copy(devDependencies: dependencies) : spec.copy(dependencies: dependencies);
    await spec.save(Directory(""));
    print("Remove $pack from pubspec");
  }
}
