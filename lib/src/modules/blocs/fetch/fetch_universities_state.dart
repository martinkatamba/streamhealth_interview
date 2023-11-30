part of 'fetch_universities_bloc.dart';

@immutable
abstract class FetchUniversitiesState {}

class FetchUniversitiesInitial extends FetchUniversitiesState {}

class FetchingUniversities extends FetchUniversitiesState {}

class UniversitiesFetched extends FetchUniversitiesState {
  final List<University> universities;
  UniversitiesFetched({
    required this.universities,
  });
}

class FetchingUniversities404Error extends FetchUniversitiesState {
  final String error;

  FetchingUniversities404Error({required this.error});
}

class FetchingUniversitiesError extends FetchUniversitiesState {
  final String error;

  FetchingUniversitiesError({required this.error});
}
