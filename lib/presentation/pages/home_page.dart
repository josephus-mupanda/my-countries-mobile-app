import 'package:countries_app/data/models/country_summary.dart';
import 'package:countries_app/logic/countries/countries_bloc.dart';
import 'package:countries_app/logic/countries/countries_event.dart';
import 'package:countries_app/logic/countries/countries_state.dart';
import 'package:countries_app/presentation/widgets/country_list_item.dart';
import 'package:countries_app/presentation/widgets/search_widget.dart';
import 'package:countries_app/presentation/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:countries_app/logic/theme/theme_bloc.dart';
import 'package:countries_app/logic/theme/theme_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CountriesBloc>().add(const CountriesEvent.fetchAll());
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeBloc>().state.isDarkTheme
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => themeBloc.add(ToggleThemeEvent()),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchWidget(
              hintText: 'Search for a country',
              prefixIcon: Icons.search,
              kController: _searchController,
              onChanged: (value) {
                 if (value.isEmpty) {
                  context.read<CountriesBloc>().add(const CountriesEvent.fetchAll());
                } else {
                  context.read<CountriesBloc>().add(CountriesEvent.search(value));
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<CountriesBloc, CountriesState>(
              builder: (context, state) {
                return state.when(
                  loading: () => const ShimmerLoader(),
                  loaded: (countries) {
                    final filtered = countries
                        .where((c) => c.commonName
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()))
                        .toList();
                   
                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final country = filtered[index];
                        return CountryListItem(
                          country: country,
                          onTap: () {
                            // Navigate to detail
                          },
                        );
                      },
                    );
                  },
                  error: (message) => Center(child: Text(message)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
