import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/router/route_names.dart';
import 'package:id_card_front_end/features/generate_templates/presentation/widgets/template_wrapper.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/template_manager/template_manager.dart';

class TemplateView extends StatefulWidget {
  const TemplateView({super.key});

  @override
  State<TemplateView> createState() => _TemplateViewState();
}

class _TemplateViewState extends State<TemplateView> {

  @override
  Widget build(BuildContext context) {

    var templateList = TemplateManager.templatesWithDummy;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your ID Card Template'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(RouteName.importExcelPage);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: templateList.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (ctx, int index) {
          return GestureDetector(
            onTap: () {
              context.pushNamed(RouteName.formView, extra: index);
            },
            child: TemplateWrapper(
              child: templateList[index].template,
            ),
          );
        },
      ),
    );
  }
}