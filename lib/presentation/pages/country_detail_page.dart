
import 'package:countries_app/data/models/country_details.dart';
import 'package:countries_app/data/repositories/country_repository.dart';
import 'package:countries_app/presentation/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CountryDetailPage extends StatefulWidget {
  final String countryCode;
  final String flagUrl;
  final String countryName;

  const CountryDetailPage({
    super.key,
    required this.countryCode,
    required this.flagUrl,
    required this.countryName,
  });

  @override
  State<CountryDetailPage> createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  CountryDetails? countryDetail;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchCountryDetail();
  }

  Future<void> _fetchCountryDetail() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final repository = GetIt.I<CountryRepository>();
      final detail = await repository.fetchCountryDetail(widget.countryCode);
      setState(() {
        countryDetail = detail;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const ShimmerLoader()
          : error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(error!, style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _fetchCountryDetail,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.countryCode,
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
                      const SizedBox(height: 16),
                      Text(
                        "Key Statistics",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow("Area", "${countryDetail!.area} km²"),
                      _buildDetailRow(
                          "Population",
                          "${(countryDetail!.population / 1e6).toStringAsFixed(1)}M"),
                      _buildDetailRow("Region", countryDetail!.region ?? ""),
                      _buildDetailRow("Sub Region", countryDetail!.subRegion ?? ""),
                      const SizedBox(height: 16),
                      Text(
                        "Timezone",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: countryDetail!.timezones
                            .map((tz) => Chip(label: Text(tz)))
                            .toList(),
                      ),
                    ],
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
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../logic/country_details/country_details_bloc.dart';
// import '../../../logic/country_details/country_details_event.dart';
// import '../../../logic/country_details/country_details_state.dart';

// class CountryDetailPage extends StatelessWidget {
//   final String cca2;
//   const CountryDetailPage({super.key, required this.cca2});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: context.read<CountryDetailsBloc>()..add(CountryDetailsEvent.fetchDetails(cca2)),
//       child: Scaffold(
//         appBar: AppBar(),
//         body: BlocBuilder<CountryDetailsBloc, CountryDetailsState>(
//           builder: (context, state) {
//             return state.when(
//               loading: () => const Center(child: CircularProgressIndicator()),
//               error: (msg) => Center(child: Text(msg)),
//               loaded: (country) => Column(
//                 children: [
//                   Image.network(country.flag),
//                   const SizedBox(height: 16),
//                   Text(country.name, style: const TextStyle(fontSize: 22)),
//                   Text('Region: ${country.region}'),
//                   Text('Population: ${country.population}'),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
