import 'package:slidy/slidy.dart';

main(List<String> args) {
  if(args[0] == "generate" || args[0] == "g"){
    Generate(args[1]).module();
  }

}
