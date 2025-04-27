import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  // Initialiser Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Chemin du fichier SVG source
  final String svgPath = '../tiktok icons/tiktok.svg';
  
  // Chemin du fichier PNG de sortie
  final String pngPath = '../tiktok icons/tiktok_hd.png';
  
  // Taille de l'icône (1024x1024 pour une haute résolution)
  const double size = 1024;

  try {
    // Lire le contenu du fichier SVG
    final String svgString = await File(svgPath).readAsString();
    
    // Créer un widget SVG
    final Widget svg = SvgPicture.string(
      svgString,
      width: size,
      height: size,
    );
    
    // Convertir le widget SVG en image
    final ui.Image image = await _widgetToImage(svg, size, size);
    
    // Convertir l'image en bytes
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      print('Échec de la conversion en bytes');
      return;
    }
    
    // Écrire les bytes dans un fichier PNG
    await File(pngPath).writeAsBytes(byteData.buffer.asUint8List());
    
    print('Icône PNG générée avec succès : $pngPath');
  } catch (e) {
    print('Erreur lors de la génération de l\'icône : $e');
  }
}

Future<ui.Image> _widgetToImage(Widget widget, double width, double height) async {
  // Créer un RenderObject pour le widget
  final RenderRepaintBoundary boundary = RenderRepaintBoundary();
  
  // Créer un pipeline de rendu
  final BuildOwner buildOwner = BuildOwner();
  final RenderView renderView = RenderView(
    view: ui.PlatformDispatcher.instance.views.first,
    child: RenderPositionedBox(
      alignment: Alignment.center,
      child: boundary,
    ),
    configuration: ViewConfiguration(
      size: Size(width, height),
      devicePixelRatio: 1.0,
    ),
  );
  
  // Attacher le pipeline de rendu
  buildOwner.rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    container: boundary,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: widget,
    ),
  ).attachToRenderTree(buildOwner);
  
  // Forcer le rendu
  buildOwner.buildScope(buildOwner.rootElement!);
  renderView.prepareInitialFrame();
  buildOwner.buildScope(buildOwner.rootElement!);
  buildOwner.finalizeTree();
  
  // Attendre que le rendu soit terminé
  await boundary.toImage(pixelRatio: 1.0);
  
  // Capturer l'image
  final ui.Image image = await boundary.toImage(pixelRatio: 1.0);
  return image;
}
