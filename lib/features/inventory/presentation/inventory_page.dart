import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/food_card.dart';
import '../../inventory/data/food_repository.dart';
import '../domain/food_item.dart';

final foodRepoProvider = Provider<FoodRepository>((ref) => FoodRepository());

// ✅ RENOMMÉ pour éviter les collisions avec l’ancienne version FutureProvider
final inventoryStreamProvider = StreamProvider<List<FoodItem>>((ref) {
  final repo = ref.read(foodRepoProvider);
  return repo.watchAll();
});

class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(inventoryStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Inventaire')),
      body: asyncItems.when(
        data: (items) => items.isEmpty
            ? const _EmptyState()
            : ListView.builder(
          padding: const EdgeInsets.only(bottom: 96),
          itemCount: items.length,
          itemBuilder: (ctx, i) {
            final it = items[i];
            return FoodCard(
              item: it,
              onDelete: () async {
                await ref.read(foodRepoProvider).delete(it.id);
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur: $e')),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          if (i == 1) context.go('/calendar');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.kitchen_outlined), label: 'Inventaire'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), label: 'Calendrier'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/add'),
        label: const Text('Ajouter'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.kitchen, size: 64),
            const SizedBox(height: 12),
            Text(
              'Aucun aliment pour le moment',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text('Ajoutez vos produits pour suivre les dates de péremption.'),
          ],
        ),
      ),
    );
  }
}
