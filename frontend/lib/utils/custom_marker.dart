import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker {
  static Future<BitmapDescriptor> createCircularMarker({
    required Color backgroundColor,
    required String imagePath,
    double size = 80,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = backgroundColor;
    
    // Draw circle background
    canvas.drawCircle(
      Offset(size / 2, size / 2),
      size / 2,
      paint,
    );
    
    // Draw white border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(
      Offset(size / 2, size / 2),
      size / 2 - 1.5,
      borderPaint,
    );
    
    // Try to load and draw image
    try {
      final ByteData data = await rootBundle.load(imagePath);
      final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final ui.FrameInfo fi = await codec.getNextFrame();
      
      // Calculate image size to fit inside circle
      final imageSize = size * 0.6; // 60% of circle size
      final imageRect = Rect.fromCenter(
        center: Offset(size / 2, size / 2),
        width: imageSize,
        height: imageSize,
      );
      
      canvas.drawImageRect(
        fi.image,
        Rect.fromLTWH(0, 0, fi.image.width.toDouble(), fi.image.height.toDouble()),
        imageRect,
        Paint(),
      );
    } catch (e) {
      // If image fails to load, draw a placeholder icon
      final textPainter = TextPainter(
        text: TextSpan(
          text: '🚒',
          style: TextStyle(fontSize: size * 0.4, color: Colors.white),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (size - textPainter.width) / 2,
          (size - textPainter.height) / 2,
        ),
      );
    }
    
    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();
    
    return BitmapDescriptor.bytes(bytes);
  }
  
  static Future<BitmapDescriptor> createSimpleCircularMarker({
    required Color backgroundColor,
    required String label,
    double size = 80,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = backgroundColor;
    
    // Draw circle background
    canvas.drawCircle(
      Offset(size / 2, size / 2),
      size / 2,
      paint,
    );
    
    // Draw white border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(
      Offset(size / 2, size / 2),
      size / 2 - 1.5,
      borderPaint,
    );
    
    // Draw label text
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: size * 0.3,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size - textPainter.width) / 2,
        (size - textPainter.height) / 2,
      ),
    );
    
    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();
    
    return BitmapDescriptor.bytes(bytes);
  }
} 