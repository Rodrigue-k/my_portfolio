
import 'dart:math';

import 'package:flutter/material.dart';

class ChristmasTree extends StatelessWidget {
  const ChristmasTree({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black12,
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Christmas Tree'),
      ),*/
      body: CustomPaint(
        size: Size(width,height),
        painter: TreePainter(),
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = 0.5;

    // Position centrale de l'arbre
    final double centerX = size.width / 2;
    final double centerY = size.height - size.height / 4;

    // Paramètres de la spirale
    const double turns = 15;         // Nombre de tours de la spirale
    const double height = 500;       // Hauteur totale de la spirale
    const double baseRadius = 120;   // Rayon initial à la base de l'arbre

    // Dessin de la spirale de bas en haut
    for (double t = 0; t < turns * 2 * pi; t += 0.1) {
      // Calcul du rayon à chaque étape (réduction progressive pour créer la forme conique)
      final double radius = baseRadius * (1 - t / (turns * 2 * pi));

      // Calcul des coordonnées de la spirale
      final double x = centerX + radius * cos(t);  // Coordonnée x (horizontale)
      final double y = centerY - (height * t / (turns * 2 * pi)); // Coordonnée y (verticale)

      // Dessin d'un petit cercle à chaque point de la spirale
      canvas.drawCircle(Offset(x, y), 5, paint);
    }
  }

  // Optimisation : Ne pas repeindre si les paramètres du dessin n'ont pas changé
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
