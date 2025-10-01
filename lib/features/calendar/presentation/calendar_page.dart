import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frigo_app/features/inventory/presentation/inventory_page.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../inventory/domain/food_item.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});
  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _focused = DateTime.now();
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendrier')),
      body: FutureBuilder<List<FoodItem>>(
        future: ref.read(foodRepoProvider).getAll(),
        builder: (ctx, snap) {
          final items = snap.data ?? [];
          // Index par jour simple
          final map = <DateTime, List<FoodItem>>{};
          for (final it in items) {
            if (it.expiryDate == null) continue;
            final d = DateTime(it.expiryDate!.year, it.expiryDate!.month, it.expiryDate!.day);
            map.putIfAbsent(d, () => []).add(it);
          }

          List<FoodItem> eventsFor(DateTime day) {
            final key = DateTime(day.year, day.month, day.day);
            return map[key] ?? [];
          }

          return Column(
            children: [
              TableCalendar<FoodItem>(
                locale: 'fr_FR',
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2035, 12, 31),
                focusedDay: _focused,
                selectedDayPredicate: (d) => isSameDay(_selected, d),
                onDaySelected: (sel, foc) => setState(() {
                  _selected = sel; _focused = foc;
                }),
                eventLoader: eventsFor,
                calendarStyle: const CalendarStyle(outsideDaysVisible: false),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _selected == null
                            ? 'Sélectionnez un jour'
                            : 'Échéances le ${_selected!.day.toString().padLeft(2,'0')}/${_selected!.month.toString().padLeft(2,'0')}/${_selected!.year}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...eventsFor(_selected ?? DateTime.now()).map((e) => ListTile(
                      title: Text(e.name),
                      subtitle: Text('Qté: ${e.quantity} ${e.unit}'),
                      leading: const Icon(Icons.event_available),
                    )),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}