import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// For list/grid views (HomePage)
class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Create contrasting colors for shimmer effect
    final baseColor = theme.colorScheme.onSurface.withValues(alpha: 0.1);
    final highlightColor = theme.colorScheme.onSurface.withValues(alpha: 0.05);
    
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: ListTile(
            leading: Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: Container(
              width: 100,
              height: 10,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            subtitle: Container(
              width: 60,
              height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
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
    final theme = Theme.of(context);
    
    // Create contrasting colors for shimmer effect
    final baseColor = theme.colorScheme.onSurface.withValues(alpha: 0.1);
    final highlightColor = theme.colorScheme.onSurface.withValues(alpha: 0.05);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flag placeholder
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title placeholder
            Container(
              width: 200,
              height: 24,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 10),
            
            // Detail rows placeholders
            _buildShimmerRow(theme),
            _buildShimmerRow(theme),
            _buildShimmerRow(theme),
            _buildShimmerRow(theme),
            _buildShimmerRow(theme),
            
            const SizedBox(height: 10),
            
            // Timezone title
            Container(
              width: 100,
              height: 18,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
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
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
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

  Widget _buildShimmerRow(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            height: 14,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            width: 120,
            height: 14,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
