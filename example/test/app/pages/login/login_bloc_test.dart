import 'package:flutter_test/flutter_test.dart';

import 'package:exampleinjector/app/pages/login/login_bloc.dart';

void main() {
 late LoginBloc bloc;

  setUp(() {
    bloc = LoginBloc();
  });

  group('LoginBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<LoginBloc>());
    });
  });
}
