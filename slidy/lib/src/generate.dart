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
    print("$path");
  }
  
}