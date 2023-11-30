import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../repositories/universities/university_model.dart';
import '../../../repositories/universities/university_repo.dart';

part 'fetch_universities_event.dart';
part 'fetch_universities_state.dart';

class FetchUniversitiesBloc
    extends Bloc<FetchUniversitiesEvent, FetchUniversitiesState> {
  final UniversityRepository _universityRepository;
  FetchUniversitiesBloc(this._universityRepository)
      : super(FetchUniversitiesInitial()) {
    on<InitiateUniversityFetching>(initiateUniversityFetching);
    on<FetchUniversities>(fetchUniversities);
  }

  FutureOr<void> initiateUniversityFetching(
      InitiateUniversityFetching event, Emitter<FetchUniversitiesState> emit) {
    emit(FetchUniversitiesInitial());
  }

  Future<void> fetchUniversities(
      FetchUniversities event, Emitter<FetchUniversitiesState> emit) async {
    if (state is FetchUniversitiesInitial) {
      emit(FetchingUniversities());

      try {
        final response = await _universityRepository.getUnivesities(
          country: event.country,
        );
        emit(UniversitiesFetched(universities: response));
      } catch (e) {
        String status = e.toString();

        if (status == "404") {
          emit(FetchingUniversities404Error(error: "No Universities found"));
        } else {
          emit(FetchingUniversitiesError(
              error: "Something went wrong: $status"));
        }
      }
    }
  }
}
