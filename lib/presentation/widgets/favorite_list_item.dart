import 'package:countries_app/data/models/favorites_model.dart';
import 'package:flutter/material.dart';

class FavoriteListItem extends StatelessWidget {
  final FavoriteCountry country;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const FavoriteListItem({
    super.key,
    required this.country,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          country.flagUrl,
          width: 50,
          height: 35,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        country.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        country.capital,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).hintColor,
      ),
      ),
      trailing: GestureDetector(
        onTap: onFavoriteToggle,
        child:Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.redAccent : Theme.of(context).iconTheme.color,
          ),
      ),
      onTap: onTap,
    );
  }
}
