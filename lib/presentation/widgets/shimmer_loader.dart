import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: Container(
              width: 50,
              height: 30,
              color: Colors.white,
            ),
            title: Container(
              width: 100,
              height: 10,
              color: Colors.white,
            ),
            subtitle: Container(
              width: 60,
              height: 8,
              color: Colors.white,
              margin: const EdgeInsets.only(top: 4),
            ),
          ),
        );
      },
    );
  }
}

// For detail page (CountryDetailPage)
class DetailShimmerLoader extends StatelessWidget {
  const DetailShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flag placeholder
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title placeholder
            Container(
              width: 200,
              height: 24,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            
            // Detail rows placeholders
            _buildShimmerRow(),
            _buildShimmerRow(),
            _buildShimmerRow(),
            _buildShimmerRow(),
            _buildShimmerRow(),
            
            const SizedBox(height: 10),
            
            // Timezone title
            Container(
              width: 100,
              height: 18,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            
            // Timezone chips
            Wrap(
              spacing: 6,
              children: List.generate(
                3,
                (index) => Container(
                  width: 80,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 80, height: 14, color: Colors.white),
          Container(width: 120, height: 14, color: Colors.white),
        ],
      ),
    );
  }
}
