## 2.4.2+1 (Out 25, 2019)
- Added bloc_pattern_test from tests.

## 2.4.1+1 (Out 21, 2019)
- Fix Module Not Found error

## 2.4.0+2 (Out 06, 2019)
- Added distinct parameter in Consumer Widget and condition to call builder.
   Consumer<HomeBloc>(
       distinct: (oldValue, newValue) => oldValue.variable != newValue.variable,
       ...
   )
- Added specific Consumer for Modules Pattern
   ConsumerModule<HomeModule, HomeBloc>(...);

## 2.3.4 (Out 03, 2019)
- Fix error singleton blocs module
- Added debugMode false to print texts

## 2.3.3 (Sep 26, 2019)
- Fix error in segments bloc

## 2.3.2 (Sep 13, 2019)
- Fix multiple tags error

## 2.3.1 (Aug 24, 2019)
- Mapped Errors in Custom Exception

## 2.3.0 (Aug 23, 2019)
- Mapped Errors in Custom Exception

## 2.2.3 (Jul 11, 2019)
- Fix error dispose unique bloc

## 2.2.2+3 (Jun 28, 2019)
- Add ConsumerModule

## 2.2.1 (Jun 22, 2019)
- Prepare to Slidy
- Fix error inject module.

## 2.2.0+5 (Jun 21, 2019)
- Fix error consumer module.

## 2.2.0+4 (Jun 19, 2019)
- Fix error dispose bloc.

## 2.2.0+1 (Jun 14, 2019)
- Introduced project modules.
- Tag for each BlocProvider. You can use multiple BlocProvider independently.

## 2.1.9+2
- Fix dispose error

## 2.1.9
- Add Consumer pattern.

## 2.1.7
- Corrections in the parameters.

## 2.0.1 (May 1, 2019)
- BlocProvider and BlocProviderList are now one.
- Added Injection of BLoC dependencies.
- Added Injection Dependencies.

## 1.1.2 (December 8, 2018)
- removed context injection

## 1.1.1 (December 8, 2018)
- removed context injection

## 1.1.0 (November 19, 2018)
- Injected the context (BuildContext) into the controller.

## 1.0.0 (November 19, 2018)
- Support for Dart 2.1
- Enhanced Bloc lifecycle with fast access anywhere in the application.

## 0.1.0 (November 8, 2018)
- Provider with StatefulWidget.