import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(InitCountryState());

  Future<void> validateCountry({
    required String country,
  }) async {
    if (country.isEmpty) {
      emit(ErrorCountryState("Fill in country"));
    } else {
      emit(OkCountryState(country));
      
    }
  }
}
