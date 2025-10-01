import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigo_app/app/app.dart';

void main() {
  testWidgets('FrigoApp démarre et affiche la page Inventaire', (WidgetTester tester) async {
    // 🏗️ Monte l'application dans l'environnement de test
    await tester.pumpWidget(const FrigoApp());

    // ⏸️ Laisse Flutter construire la frame initiale
    await tester.pumpAndSettle();

    // ✅ Vérifie que le titre de la page Inventaire est présent
    expect(find.text('Inventaire'), findsOneWidget);

    // ✅ Vérifie que le bouton "Ajouter" est présent
    expect(find.widgetWithText(FloatingActionButton, 'Ajouter'), findsOneWidget);
  });

  testWidgets('Navigation vers la page d\'ajout fonctionne', (WidgetTester tester) async {
    await tester.pumpWidget(const FrigoApp());
    await tester.pumpAndSettle();

    // 🟡 Appuie sur le bouton "Ajouter"
    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();

    // ✅ Vérifie que la page d'ajout s'affiche
    expect(find.text('Ajouter un aliment'), findsOneWidget);

    // ✅ Vérifie la présence d'un champ texte pour le nom
    expect(find.byType(TextFormField), findsWidgets);
  });
}
