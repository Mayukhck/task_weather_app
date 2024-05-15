// Mocks generated by Mockito 5.4.4 from annotations
// in task_weather_app/test/features/weather/presentation/home_view_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:http/http.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:task_weather_app/src/features/weather/domain/weather_data.dart'
    as _i2;
import 'package:task_weather_app/src/features/weather/repository/weather_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWeatherModel_0 extends _i1.SmartFake implements _i2.WeatherModel {
  _FakeWeatherModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i3.WeatherRepository {
  MockWeatherRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseURL => (super.noSuchMethod(
        Invocation.getter(#baseURL),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#baseURL),
        ),
      ) as String);

  @override
  _i5.Future<_i2.WeatherModel> fetchWeatherData(
    String? cityName,
    _i6.Client? client,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchWeatherData,
          [
            cityName,
            client,
          ],
        ),
        returnValue: _i5.Future<_i2.WeatherModel>.value(_FakeWeatherModel_0(
          this,
          Invocation.method(
            #fetchWeatherData,
            [
              cityName,
              client,
            ],
          ),
        )),
      ) as _i5.Future<_i2.WeatherModel>);
}
