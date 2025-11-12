import 'dart:async';

import 'package:countries_app/core/router/routes.dart';
import 'package:countries_app/core/utils/responsive.dart';
import 'package:countries_app/data/models/country_summary.dart';
import 'package:countries_app/logic/countries/countries_bloc.dart';
import 'package:countries_app/logic/countries/countries_event.dart';
import 'package:countries_app/logic/countries/countries_state.dart';
import 'package:countries_app/logic/favorites.dart/favorites_bloc.dart';
import 'package:countries_app/logic/favorites.dart/favorites_event.dart';
import 'package:countries_app/logic/favorites.dart/favorites_state.dart';
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
  int _selectedIndex = 0; // 0 = Home, 1 = Favorites

  @override
  void initState() {
    super.initState();
    context.read<CountriesBloc>().add(const CountriesEvent.fetchAll());
    context.read<FavoritesBloc>().add(const FavoritesEvent.loadFavorites());
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

  Future<void> _onRefreshCountries() async {
    context.read<CountriesBloc>().add(const CountriesEvent.fetchAll());
  }

  Future<void> _onRefreshFavorites() async {
    context.read<FavoritesBloc>().add(const FavoritesEvent.loadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Countries' : 'Favorites'),
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

      body: _selectedIndex == 0 ? _buildCountriesTab() : _buildFavoritesTab(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  //HOME
  Widget _buildCountriesTab() {
    return Column(
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
                onChanged: (value) => setState(() => _selectedSort = value),
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

                  if (_selectedSort == 'name') {
                    filtered.sort(
                      (a, b) => a.commonName.compareTo(b.commonName),
                    );
                  } else if (_selectedSort == 'population') {
                    filtered.sort(
                      (a, b) => a.population.compareTo(b.population),
                    );
                  }

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
                    final int crossAxisCount = Responsive.isTablet(context)
                        ? 2
                        : 3;

                    content = GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 4.0,
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
                    onRefresh: _onRefreshCountries,
                    child: content,
                  );
                },
                error: (msg) => _buildError(msg, _onRefreshCountries),
              );
            },
          ),
        ),
      ],
    );
  }

  // FAVORITES
  Widget _buildFavoritesTab() {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return state.when(
          loaded: (favorites) {
            if (favorites.isEmpty) {
              return _buildEmpty("No favorites yet.", _onRefreshFavorites);
            }

            Widget content = Responsive.isMobile(context)
                ? ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final country = favorites[index];
                      return ListTile(
                        leading: Image.network(
                          country.flagUrl,
                          width: 40,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          country.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(country.capital),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            context.read<FavoritesBloc>().add(
                              FavoritesEvent.toggleFavorite(country),
                            );
                          },
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final country = favorites[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  country.flagUrl,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  country.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  country.capital,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    context.read<FavoritesBloc>().add(
                                      FavoritesEvent.toggleFavorite(country),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );

            return RefreshIndicator(
              onRefresh: _onRefreshFavorites,
              child: content,
            );
          },
          empty: () => _buildEmpty("No favorites yet.", _onRefreshFavorites),
          error: (msg) => _buildError(msg, _onRefreshFavorites),
        );
      },
    );
  }

  Widget _buildEmpty(String message, Future<void> Function() onRefresh) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [SizedBox(height: 200, child: Center(child: Text(message)))],
      ),
    );
  }

  Widget _buildError(String msg, Future<void> Function() onRefresh) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(child: Text("Error: $msg")),
          ),
        ],
      ),
    );
  }
}
