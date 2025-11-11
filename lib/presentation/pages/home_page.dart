import 'dart:async';

import 'package:countries_app/core/router/routes.dart';
import 'package:countries_app/core/utils/responsive.dart';
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
  Timer? _debounce;
  String? _selectedSort;

  @override
  void initState() {
    super.initState();
    context.read<CountriesBloc>().add(const CountriesEvent.fetchAll());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (value.isEmpty) {
        context.read<CountriesBloc>().add(const CountriesEvent.fetchAll());
      } else {
        context.read<CountriesBloc>().add(CountriesEvent.search(value));
      }
    });
  }

  Future<void> _onRefresh() async {
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
          // Search
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchWidget(
              hintText: 'Search for a country',
              prefixIcon: Icons.search,
              kController: _searchController,
              onChanged: _onSearchChanged,
            ),
          ),

          // Sorting
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  hint: const Text("Sort by"),
                  value: _selectedSort,
                  items: const [
                    DropdownMenuItem(value: 'name', child: Text("Name")),
                    DropdownMenuItem(
                      value: 'population',
                      child: Text("Population"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedSort = value);
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<CountriesBloc, CountriesState>(
              builder: (context, state) {
                return state.when(
                  loading: () => const ShimmerLoader(),
                  loaded: (countries) {
                    List<CountrySummary> filtered = countries
                        .where(
                          (c) => c.commonName.toLowerCase().contains(
                            _searchController.text.toLowerCase(),
                          ),
                        )
                        .toList();

                    // Sorting
                    if (_selectedSort == 'name') {
                      filtered.sort(
                        (a, b) => a.commonName.compareTo(b.commonName),
                      );
                    } else if (_selectedSort == 'population') {
                      filtered.sort(
                        (a, b) => a.population.compareTo(b.population),
                      );
                    }

                    // Responsive layout
                    Widget content;
                    if (Responsive.isMobile(context)) {
                      content = ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final country = filtered[index];
                          return CountryListItem(
                            country: country,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.detail,
                                arguments: {
                                  'cca2': country.cca2,
                                  'flagUrl': country.flagUrl,
                                  'name': country.commonName,
                                },
                              );
                            },
                          );
                        },
                      );
                    } else {
                      content = GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.3,
                            ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final country = filtered[index];
                          return CountryListItem(
                            country: country,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.detail,
                                arguments: {
                                  'cca2': country.cca2,
                                  'flagUrl': country.flagUrl,
                                  'name': country.commonName,
                                },
                              );
                            },
                          );
                        },
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: content,
                    );
                  },

                  error: (message) => RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(child: Text(message)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.favorites);
          }
        },
      ),
    );
  }
}
