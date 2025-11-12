import 'package:flutter/material.dart';
import '../../../data/models/country_summary.dart';

class CountryListItem extends StatelessWidget {
  final CountrySummary country;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const CountryListItem({
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
        country.commonName,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        "Population: ${country.population.toStringAsFixed(0)}",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).hintColor,
      ),
      ),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.redAccent : Theme.of(context).iconTheme.color,
        ),
        onPressed: onFavoriteToggle,
      ),
      onTap: onTap,
    );
  }
}
