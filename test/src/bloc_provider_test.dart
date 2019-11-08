import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as flutter_bloc;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/counter_bloc.dart';
import 'utils/counter_bloc_gerator.dart';
import 'utils/counter_controller.dart';
import 'utils/counter_mobx.dart';
import 'utils/fake_module.dart';

main() {
  setUpAll(() {
    BlocProvider.debugMode = false;
  });

  group("BlocProvider tests", () {
    testWidgets('Bloc baseBloc Instance', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: BlocProvider(
        blocs: [
          Bloc((i) => CounterBloc()),
        ],
        child: Builder(builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                BlocProvider.getBloc<CounterBloc>().controller.add(100);
              },
              child: Icon(Icons.add),
            ),
            body: Center(
              child: StreamBuilder<int>(
                stream: BlocProvider.getBloc<CounterBloc>().controller.stream,
                builder: (context, snapshot) {
                  return Text("${snapshot.data}");
                },
              ),
            ),
          );
        }),
      )));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      final titleFinder = find.text('100');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Bloc ChangeNotifier Consumer Instance',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: BlocProvider(
        blocs: [
          Bloc((i) => CounterController()),
        ],
        child: Builder(builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                BlocProvider.getBloc<CounterController>().changeValue();
              },
              child: Icon(Icons.add),
            ),
            body: Center(
              child: Consumer<CounterController>(
                builder: (context, snapshot) {
                  return Text("${snapshot.counter}");
                },
              ),
            ),
          );
        }),
      )));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      final titleFinder = find.text('100');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Bloc ChangeNotifier ConsumerModule Instance',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: BlocProvider(
        tagText: "FakeModule",
        blocs: [
          Bloc((i) => CounterController()),
        ],
        child: Builder(builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                BlocProvider.tag("FakeModule")
                    .bloc<CounterController>()
                    .changeValue();
              },
              child: Icon(Icons.add),
            ),
            body: Center(
              child: ConsumerModule<FakeModule, CounterController>(
                builder: (context, snapshot) {
                  return Text("${snapshot.counter}");
                },
              ),
            ),
          );
        }),
      )));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      final titleFinder = find.text('100');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('flutter_bloc Instance', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: BlocProvider(
        tagText: "FakeModule",
        blocs: [
          Bloc((i) => CounterBlocGerator()),
        ],
        child: Builder(builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                BlocProvider.tag("FakeModule")
                    .bloc<CounterBlocGerator>()
                    .add(CounterEvent.increment);
              },
              child: Icon(Icons.add),
            ),
            body: Center(
              child: flutter_bloc.BlocBuilder<CounterBlocGerator, int>(
                bloc: BlocProvider.tag("FakeModule").bloc<CounterBlocGerator>(),
                builder: (context, data) {
                  return Text("$data");
                },
              ),
            ),
          );
        }),
      )));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      final titleFinder = find.text('1');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('mobx Instance', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: BlocProvider(
        tagText: "FakeModule",
        blocs: [
          Bloc((i) => Counter()),
        ],
        child: Builder(builder: (context) {

          final Counter counter = BlocProvider.tag("FakeModule").bloc<Counter>();
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                counter.increment();
              },
              child: Icon(Icons.add),
            ),
            body: Center(
              child: Observer(
                builder: (_) {
                  return Text("${counter.value}");
                },
              ),
            ),
          );
        }),
      )));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      final titleFinder = find.text('1');
      expect(titleFinder, findsOneWidget);
    });
  });
}
