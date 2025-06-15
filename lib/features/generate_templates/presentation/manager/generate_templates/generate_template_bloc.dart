
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_card_front_end/core/base/base_exception/base_exception.dart';
import 'package:id_card_front_end/core/base/bloc_base/bloc_event.dart';
import 'package:id_card_front_end/core/base/bloc_base/bloc_event_state.dart';
import 'package:id_card_front_end/core/router/app_router.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
import 'package:id_card_front_end/features/generate_templates/domain/exceptions/permission_not_found_exception.dart';
import 'package:id_card_front_end/features/generate_templates/domain/use_cases/check_storage_permission_use_case.dart';
import 'package:id_card_front_end/features/generate_templates/presentation/widgets/template_wrapper.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/template_manager/template_manager.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

part 'generate_template_event.dart';
part 'generate_template_state.dart';

@injectable
class GenerateTemplateBloc extends Bloc<GenerateTemplateEvent, GenerateTemplateState> {

  final CheckStoragePermissionUseCase _checkStoragePermissionUseCase;

  GenerateTemplateBloc(this._checkStoragePermissionUseCase) : super(GenerateTemplateState()) {
    on<GenerateTemplateEvent>((event, emit) {});
    on<GeneratePdfEvent>(_generatePdf);
  }


  FutureOr<void> _generatePdf(GeneratePdfEvent event, Emitter<GenerateTemplateState> emit) async {
    try{
      emit(state.copyWith(state: state.loading));
      var isPermission = (await _checkStoragePermissionUseCase(params: true) ?? false);
      // if (!isPermission) {
      //   emit(state.copyWith(state: state.failed, error: "Storage permission is required to save PDF", exception: PermissionNotFoundException()));
      //   return;
      // }
      // else{

        final pdf = pw.Document();
        for (final employee in event.employees) {
          final widgetToCapture = TemplateWrapper(
            child: TemplateManager.getTemplateById(event.templateID, employee).template,
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
        emit(state.copyWith(
          state: state.success,
          file: file,
        ));
      // }
    }
    catch(e){
      print("Error generating PDF: $e");
      emit(state.copyWith(state: state.failed, error: e.toString()));
    }
  }



  Future<Uint8List?> _captureWidgetToImage(Widget widget) async {
    try {
      final boundary = await _renderToImage(widget, AppRouter.navigatorKey);
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('Capture error: $e');
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

    Overlay.of(AppRouter.navigatorKey.currentContext!).insert(overlay);
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
}
