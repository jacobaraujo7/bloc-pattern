import 'package:flutter_test/flutter_test.dart';

import 'package:exampleinjector/app/pages/home/home_bloc.dart';

void main() {
 late HomeBloc bloc;

  setUp(() {
    bloc = HomeBloc();
  });

  group('HomeBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<HomeBloc>());
    });
  });
}
