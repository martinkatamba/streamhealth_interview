part of 'fetch_universities_bloc.dart';

@immutable
abstract class FetchUniversitiesEvent {}

class InitiateUniversityFetching extends FetchUniversitiesEvent {}

class FetchUniversities extends FetchUniversitiesEvent {
  final String country;

  FetchUniversities({
    required this.country,
  });
}
