import 'package:exampleinjector/app/app_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:exampleinjector/app/app_bloc.dart';

void main() {
  //init Module and Dependency Injection
  initModule(AppModule());
 late AppBloc bloc;

  setUp(() {
    bloc = AppModule.to.bloc<AppBloc>();
  });

  group('AppBloc Test', () {
    test("Counter Test", () {
      expect(bloc.counter, 1);
    });
    test("First Test", () {
      expect(bloc, isInstanceOf<AppBloc>());
    });
  });
}
