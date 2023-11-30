import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamhealth_interview/src/modules/components/univerity_tile.dart';
import 'package:streamhealth_interview/src/repositories/universities/university_model.dart';

import '../../repositories/universities/university_repo.dart';
import '../blocs/fetch/fetch_universities_bloc.dart';
import '../domains/country/country_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController searchTxtController =
      TextEditingController(text: "Uganda");
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CountryCubit>(
          create: (context) => CountryCubit()..emit(OkCountryState("Uganda")),
        ),
        BlocProvider<FetchUniversitiesBloc>(
          create: (context) => FetchUniversitiesBloc(
            UniversityRepository(),
          )..add(FetchUniversities(country: "Uganda")),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.school,
            color: Color(0xFF373138),
          ),
          title: Row(
            children: [
              RichText(
                text: const TextSpan(
                  text: "University",
                  style: TextStyle(
                    color: Color(0xFF373138),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: "  Hub",
                      style: TextStyle(
                        color: Color(0xFFA49FA4),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xFF373138),
                  ),
                ))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<CountryCubit, CountryState>(
                builder: (context, state) {
                  if (state is OkCountryState && state.country.length > 3) {
                    context
                        .read<FetchUniversitiesBloc>()
                        .add(InitiateUniversityFetching());
                    context
                        .read<FetchUniversitiesBloc>()
                        .add(FetchUniversities(country: state.country));
                  }
                  return TextField(
                    controller: searchTxtController,
                    style: const TextStyle(
                      color: Color(0xFFA49FA4),
                    ),
                    onChanged: (value) {
                      context
                          .read<CountryCubit>()
                          .validateCountry(country: value);
                    },
                    decoration: InputDecoration(
                        errorText:
                            state is ErrorCountryState ? state.message : null,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFA49FA4),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                            color: Color(0xFFA49FA4),
                            width: 0.0,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 216, 210, 217),
                            width: 0.0,
                          ),
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xFFA49FA4),
                        ),
                        hintText: "Search Univerities By Country"),
                  );
                },
              ),
            ),
            Expanded(
              child:
                  BlocConsumer<FetchUniversitiesBloc, FetchUniversitiesState>(
                listener: (context, state) {
                  //
                  if (state is FetchingUniversitiesError) {
                    print(state.error);
                  }
                },
                builder: (context, state) {
                  if (state is UniversitiesFetched) {
                    return ListView.builder(
                      itemCount: state.universities.length,
                      itemBuilder: (context, index) {
                        University university = state.universities[index];
                        return UniversityTile(
                          name: university.name,
                          country: university.country,
                          url: university.webPages.first,
                        );
                      },
                    );
                  } else if (state is FetchingUniversities) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FetchingUniversities404Error) {
                    return Center(
                      child: Text(
                          "No Universites Found For Filter ${searchTxtController.text}"),
                    );
                  } else {
                    return const Center(
                      child: Text("An error occured"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
