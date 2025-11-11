import 'package:countries_app/data/models/country_details.dart';
import 'package:countries_app/logic/country_details/country_details_bloc.dart';
import 'package:countries_app/logic/country_details/country_details_event.dart';
import 'package:countries_app/logic/country_details/country_details_state.dart';
import 'package:countries_app/presentation/widgets/shimmer_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CountryDetailPage extends StatefulWidget {
  final String cca2;
  final String flagUrl;
  final String name;

  const CountryDetailPage({
    super.key,
    required this.cca2,
    required this.flagUrl,
    required this.name,
  });

  @override
  State<CountryDetailPage> createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<CountryDetailsBloc>().add(
      CountryDetailsEvent.fetchDetails(widget.cca2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: BlocBuilder<CountryDetailsBloc, CountryDetailsState>(
        builder: (context, state) {
          return state.when(
            loading: () => const ShimmerLoader(),
            loaded: (details) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: widget.cca2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.flagUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      details.commonName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    _buildDetailRow(
                      "Capital",
                      details.capitalName ,
                    ),
                    _buildDetailRow("Region", details.region ),
                    _buildDetailRow("Subregion", details.region ),
                    _buildDetailRow("Area", "${details.area} km²"),
                    _buildDetailRow(
                      "Population",
                      details.population.toString(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Timezones",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      children: details.timezones
                          .map((tz) => Chip(label: Text(tz)))
                          .toList(),
                    ),
                  ],
                ),
              );
            },
            error: (message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Failed to load details: $message"),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.read<CountryDetailsBloc>().add(
                      CountryDetailsEvent.fetchDetails(widget.cca2),
                    ),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}
