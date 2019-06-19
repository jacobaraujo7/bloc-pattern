import 'dart:io';

import 'package:yaml/yaml.dart';

String formatName(String name) {
  name = name
      .replaceAll("_", " ")
      .split(" ")
      .map((t) => t[0].toUpperCase() + t.substring(1))
      .join();
  return name;
}

Future<String> getNamePackage() async {
  File f = new File("pubspec.yaml");
  String node = await f.readAsString();
  Map yaml = loadYaml(node);
  return yaml['name'];
}
