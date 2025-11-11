import 'package:countries_app/logic/favorites.dart/favorites_bloc.dart';
import 'package:countries_app/logic/favorites.dart/favorites_event.dart';
import 'package:countries_app/logic/favorites.dart/favorites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(const FavoritesEvent.loadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          return state.when(
            loaded: (favorites) {
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final country = favorites[index];
                  return ListTile(
                    leading: Image.network(country.flagUrl, width: 40),
                    title: Text(country.name),
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
              );
            },
            empty: () => const Center(child: Text("No favorites yet.")),
            error: (msg) => Center(child: Text("Error: $msg")),
          );
        },
      ),
    );
  }
}
