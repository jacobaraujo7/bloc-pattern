String formatName(String name){

  name = name.replaceAll("_", " ").split(" ").map((t) => t[0].toUpperCase() + t.substring(1) ).join();
  return name;
}