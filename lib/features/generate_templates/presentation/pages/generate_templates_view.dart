import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
import 'package:id_card_front_end/features/generate_templates/presentation/widgets/template_wrapper.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/template_manager/template_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class GenerateTemplatesView extends StatefulWidget {
  const GenerateTemplatesView({
    super.key,
    required this.employees,
    required this.templateID,
  });

  final List<Employee> employees;
  final int templateID;

  @override
  State<GenerateTemplatesView> createState() => _GenerateTemplatesViewState();
}

class _GenerateTemplatesViewState extends State<GenerateTemplatesView> {
  bool _isGeneratingPdf = false;

  @override
  void initState() {
    super.initState();
    // print("Received length is ${widget.employees.length}, Template ID is ${widget.templateID}");
  }

  Future<bool> _checkStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt < 33) {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    return true;
  }

  Future<void> _generateAndSavePdf() async {
    final hasPermission = await _checkStoragePermission();
    if (!hasPermission) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission is required to save PDF')),
      );
      return;
    }

    if (widget.employees.isEmpty) return;

    setState(() => _isGeneratingPdf = true);

    try {
      final pdf = pw.Document();

      for (final employee in widget.employees) {
        final widgetToCapture = TemplateWrapper(
          child: _buildTemplate(employee, widget.templateID),
        );

        final image = await _captureWidgetToImage(widgetToCapture);
        if (image == null) continue;

        pdf.addPage(
          pw.Page(
            build: (context) => pw.Center(
              child: pw.Image(pw.MemoryImage(image), fit: pw.BoxFit.contain),
            ),
          ),
        );
      }

      final output = await getTemporaryDirectory();
      final file = File('${output.path}/id_cards_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());

      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('PDF Generated'),
            content: const Text('The ID cards have been saved as a PDF file.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await Printing.layoutPdf(
                    onLayout: (format) => file.readAsBytes(),
                  );
                },
                child: const Text('Open PDF'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating PDF: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGeneratingPdf = false);
      }
    }
  }

  Future<Uint8List?> _captureWidgetToImage(Widget widget) async {
    try {
      final repaintKey = GlobalKey();
      final boundary = await _renderToImage(widget, repaintKey);
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Capture error: $e');
      return null;
    }
  }

  Future<RenderRepaintBoundary> _renderToImage(Widget widget, GlobalKey key) async {
    final completer = Completer<RenderRepaintBoundary>();

    final overlay = OverlayEntry(
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: RepaintBoundary(
            key: key,
            child: SizedBox(
              width: 400,
              height: 600,
              child: widget,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlay);
    await Future.delayed(const Duration(milliseconds: 300));

    final renderObject = key.currentContext?.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      completer.complete(renderObject);
    } else {
      completer.completeError('RenderObject not found or not a RepaintBoundary');
    }

    overlay.remove();
    return completer.future;
  }

  Widget _buildTemplate(Employee employee, int templateID) {
    if (templateID < 0 || templateID >= TemplateManager.templateNames.length) {
      return const Center(child: Text('Invalid Template ID'));
    }
    return TemplateManager.getTemplateById(templateID, employee).template;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Templates'),
        actions: [
          if (widget.employees.isNotEmpty)
            IconButton(
              icon: _isGeneratingPdf
                  ? const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.picture_as_pdf),
              onPressed: _isGeneratingPdf ? null : _generateAndSavePdf,
            ),
        ],
      ),
      body: widget.employees.isEmpty
          ? const Center(child: Text('No employees found. Please import data first.'))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: widget.employees.length,
        itemBuilder: (context, index) {
          final employee = widget.employees[index];
          return TemplateWrapper(
            child: _buildTemplate(employee, widget.templateID),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
    );
  }
}
