import 'package:flutter/material.dart';
import 'package:tutorial_management/ui/widgets/grid_item_card.dart'; // contains GridItemCard

class GenericHomeGrid<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T) getName;
  final String Function(T) getImageUrl;

  const GenericHomeGrid({
    super.key,
    required this.items,
    required this.getName,
    required this.getImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GridItemCard(name: getName(item), imageUrl: getImageUrl(item));
      },
    );
  }
}
