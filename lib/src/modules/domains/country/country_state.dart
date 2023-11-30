part of 'country_cubit.dart';

abstract class CountryState {}

class InitCountryState extends CountryState {}

class OkCountryState extends CountryState {
  final String country;
  OkCountryState(this.country);
}

class ErrorCountryState extends CountryState {
  final String message;
  ErrorCountryState(this.message);
}
