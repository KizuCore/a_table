import 'package:flutter/material.dart';
import '../../features/inventory/domain/food_item.dart';
import '../utils/date_utils.dart';

class FoodCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const FoodCard({super.key, required this.item, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final status = computeStatus(item.expiryDate);
    Color badgeColor;
    String badgeText;
    switch (status) {
      case ExpiryStatus.expired:
        badgeColor = cs.errorContainer;
        badgeText = 'Expiré';
        break;
      case ExpiryStatus.soon:
        badgeColor = cs.tertiaryContainer;
        badgeText = 'Bientôt';
        break;
      case ExpiryStatus.ok:
        badgeColor = cs.secondaryContainer;
        badgeText = 'OK';
        break;
    }

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Pastille statut
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Qté: ${item.quantity} ${item.unit} · ${item.location.value}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('DLUO: ${formatDate(item.expiryDate)}'),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Supprimer',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}