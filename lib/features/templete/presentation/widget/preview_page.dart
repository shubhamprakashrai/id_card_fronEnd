import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PreviewPage extends StatefulWidget {
  final Widget preview;
  const PreviewPage({super.key, required this.preview});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final GlobalKey _previewKey = GlobalKey();
  bool _isGeneratingPdf = false;

  Future<bool> _checkStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    // iOS permission handling can go here if needed
    return true;
  }

  Future<void> _downloadAsPdf() async {
    final hasPermission = await _checkStoragePermission();
    if (!hasPermission) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission is required')),
      );
      return;
    }

    setState(() => _isGeneratingPdf = true);

    try {
      final boundary = _previewKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) throw Exception("Unable to find render object");

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(pngBytes);

      pdf.addPage(pw.Page(
        build: (context) => pw.Center(child: pw.Image(pdfImage)),
      ));

      final dir = await getExternalStorageDirectory();
      if (dir == null) throw Exception("Unable to get storage directory");

      final file = File('${dir.path}/id_preview_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Download Complete"),
          content: const Text("PDF has been saved."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Printing.layoutPdf(onLayout: (_) => file.readAsBytes());
              },
              child: const Text("Open PDF"),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error generating PDF: $e")),
      );
    } finally {
      if (mounted) {
    setState(() => _isGeneratingPdf = false);
  }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ID Card Preview"),
        actions: [
          IconButton(
            icon: _isGeneratingPdf
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.download),
            onPressed: _isGeneratingPdf ? null : _downloadAsPdf,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: RepaintBoundary(
            key: _previewKey,
            child: SizedBox(
              height: 700,
              width: 550,
              child: widget.preview,
            ),
          ),
        ),
      ),
    );
  }
}
