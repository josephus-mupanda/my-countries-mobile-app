import 'package:countries_app/core/constants/constants.dart';
import 'package:countries_app/core/utils/responsive.dart';
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
            loading: () => const DetailShimmerLoader(),
            loaded: (details) {
              return Responsive(
                mobile: _buildContent(context, details, crossAxisCount: 1),
                tablet: _buildContent(context, details, crossAxisCount: 2),
                desktop: _buildContent(context, details, crossAxisCount: 3),
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


  Widget _buildContent(
    BuildContext context,
    CountryDetails details, {
    required int crossAxisCount,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Constants.kMaxWidth),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.cca2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.flagUrl,
                    height: Responsive.isMobile(context) ? 180 : 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: Constants.kDefaultPadding),
              Text(
                "Key Statistics",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: Constants.kDefaultPadding),
              _buildDetailRow("Capital", details.capitalName),
              _buildDetailRow("Region", details.region),
              _buildDetailRow("Subregion", details.subregion!),
              _buildDetailRow("Area", "${details.area} km²"),
              _buildDetailRow("Population", details.population.toString()),
              const SizedBox(height: Constants.kDefaultPadding),
              Text("Timezones", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
      
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: details.timezones
                    .map(
                      (tz) => Chip(
                        label: Text(
                          tz,
                          style: textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: .1),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Theme.of(context).hintColor)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
