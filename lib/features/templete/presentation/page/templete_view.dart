import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/router/route_names.dart';
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
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.pushNamed(RouteName.formView, extra: index);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 600,
                child: templateList[index].template,
              ),
            ),
          );
        },
      ),
    );
  }
}