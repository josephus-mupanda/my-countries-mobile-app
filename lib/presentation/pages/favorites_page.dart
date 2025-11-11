import 'package:countries_app/data/models/country_summary.dart';
import 'package:countries_app/core/utils/preferences.dart';
import 'package:countries_app/presentation/widgets/country_list_item.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<CountrySummary> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final saved = await Preferences.getFavoriteCountries();
    setState(() => favorites = saved);
  }

  void _removeFavorite(CountrySummary country) async {
    await Preferences.toggleFavorite(country);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorite countries yet."))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final country = favorites[index];
                return CountryListItem(
                  country: country,
                  onTap: () {
                    // Navigate to detail
                  },
                  isFavorite: true,
                  onFavoriteToggle: () => _removeFavorite(country),
                );
              },
            ),
    );
  }
}

// class FavoritesPage extends StatelessWidget {
//   const FavoritesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Favorites')),
//       body: BlocBuilder<FavoritesBloc, FavoritesState>(
//         builder: (context, state) {
//           return state.when(
//             empty: () => const Center(child: Text('No favorites yet')),
//             error: (msg) => Center(child: Text(msg)),
//             loaded: (favorites) => ListView.builder(
//               itemCount: favorites.length,
//               itemBuilder: (context, index) {
//                 final fav = favorites[index];
//                 return ListTile(
//                   leading: Image.network(fav.flag),
//                   title: Text(fav.name),
//                   subtitle: Text('Capital: ${fav.capital}'),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
