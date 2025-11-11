import 'package:countries_app/core/utils/responsive.dart';
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

   Future<void> _onRefresh() async {
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

              final content = Responsive.isMobile(context)
                  ? ListView.builder(
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final country = favorites[index];
                        return ListTile(
                          leading: Image.network(country.flagUrl, width: 40, height: 25, fit: BoxFit.cover),
                          title: Text(country.name, style: const TextStyle(fontWeight: FontWeight.bold),),
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
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(country.flagUrl, height: 40, fit: BoxFit.cover),
                                  const SizedBox(height: 8),
                                  Text(
                                    country.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    country.capital,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.favorite, color: Colors.red),
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

              return RefreshIndicator(onRefresh: _onRefresh, child: content);
            },
            empty: () => RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200, child: Center(child: Text("No favorites yet."))),
                ],
              ),
            ),
            error: (msg) => RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(child: Text("Error: $msg")),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
