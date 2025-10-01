import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frigo_app/features/inventory/presentation/inventory_page.dart';
import 'package:go_router/go_router.dart';
import '../domain/food_item.dart';

class AddFoodPage extends ConsumerStatefulWidget {
  const AddFoodPage({super.key});
  @override
  ConsumerState<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends ConsumerState<AddFoodPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController(text: '1');
  DateTime? _expiry;
  String _unit = 'piece';
  String _location = 'fridge';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un aliment')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Nom de l\'aliment'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _qtyCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Quantité'),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Champ requis';
                      final x = double.tryParse(v);
                      if (x == null) return 'Nombre invalide';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _unit,
                    items: const [
                      DropdownMenuItem(value: 'piece', child: Text('pièce')),
                      DropdownMenuItem(value: 'g', child: Text('g')),
                      DropdownMenuItem(value: 'ml', child: Text('ml')),
                    ],
                    onChanged: (v) => setState(() => _unit = v ?? 'piece'),
                    decoration: const InputDecoration(labelText: 'Unité'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'fridge', label: Text('Frigo'), icon: Icon(Icons.kitchen_outlined)),
                ButtonSegment(value: 'freezer', label: Text('Congél.'), icon: Icon(Icons.ac_unit_outlined)),
                ButtonSegment(value: 'pantry', label: Text('Placard'), icon: Icon(Icons.inventory_2_outlined)),
              ],
              selected: {_location},
              onSelectionChanged: (s) => setState(() => _location = s.first),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Date de péremption'),
              subtitle: Text(_expiry == null ? 'Non définie' : '${_expiry!.day.toString().padLeft(2,'0')}/${_expiry!.month.toString().padLeft(2,'0')}/${_expiry!.year}'),
              trailing: IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(now.year - 1),
                    lastDate: DateTime(now.year + 3),
                    initialDate: _expiry ?? now,
                  );
                  if (picked != null) setState(() => _expiry = picked);
                },
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                final it = FoodItem()
                  ..name = _nameCtrl.text.trim()
                  ..quantity = double.parse(_qtyCtrl.text)
                  ..unit = _unit
                  ..location.value = _location
                  ..expiryDate = _expiry;
                await ref.read(foodRepoProvider).insert(it);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Aliment ajouté')));
                  context.go('/');
                }
              },
              icon: const Icon(Icons.save_outlined),
              label: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}