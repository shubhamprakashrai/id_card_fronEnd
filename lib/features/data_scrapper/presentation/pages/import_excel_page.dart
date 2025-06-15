import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_front_end/core/router/route_names.dart';
import 'package:id_card_front_end/features/templete/presentation/widget/template_manager/template_manager.dart';
import '../../data/models/employee.dart';
import '../manager/importer_bloc/importer_bloc.dart';

class ImportExcelPage extends StatelessWidget {
  const ImportExcelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ImportExcelView();
  }
}

class _ImportExcelView extends StatefulWidget {
  const _ImportExcelView();

  @override
  State<_ImportExcelView> createState() => _ImportExcelViewState();
}

class _ImportExcelViewState extends State<_ImportExcelView> {
  @override
  void dispose() {
    context.read<ImporterBloc>().add(const ClearImportedDataEvent());
    super.dispose();
  }

  Future<void> _importExcel() async {
    if (mounted) {
      context.read<ImporterBloc>().add(ImportExcelEvent());
    }
  }

  void _generateIds(List<Employee> employees) {
    context.pushNamed(RouteName.generateIds, queryParameters: {
      "templateID": _selectedTemplate?.toString() ?? "0"
    }, extra: employees);
  }

  int? _selectedTemplate;


  void _clearImportedData() {
    context.read<ImporterBloc>().add(const ClearImportedDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Employee Data')
      ),
      body: BlocConsumer<ImporterBloc, ImporterState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: state.isLoading ? null : _importExcel,
                  child: const Text('Import Excel File'),
                ),
                const SizedBox(height: 16),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (state.data?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Imported Employees (${state.data!.length}):',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.data!.length,
                      itemBuilder: (context, index) {
                        final employee = state.data![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                            title: Text(employee.fullName),
                            subtitle: Text(employee.designation),
                            trailing: Text(employee.department),
                            onTap: () => _showEmployeeDetails(employee),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select Template:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: _selectedTemplate ?? 0,
                    hint: const Text("Choose a template"),
                    onChanged: (int? value) {
                      setState(() {
                        _selectedTemplate = value;
                      });
                    },
                    items: List.generate(TemplateManager.templateNames.length, (index) {
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Text(TemplateManager.templateNames[index]),
                      );
                    }),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 16),


                  const SizedBox(height: 8),
                  // Row with two buttons: Clear and Save All Employees
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _clearImportedData(),
                          child: const Text('Clear'),
                        )
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state.isLoading || state.data!.isEmpty
                              ? null
                              : () => _generateIds(state.data!),
                          child: const Text('Generate IDs'),
                        ),
                      ),
                    ],
                  )
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEmployeeDetails(Employee employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(employee.fullName),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Designation', employee.designation),
              _buildDetailRow('Department', employee.department),
              _buildDetailRow('ID Number', employee.idNumber),
              _buildDetailRow('Issue Date', employee.issueDate),
              _buildDetailRow('Expiry Date', employee.expiryDate),
              _buildDetailRow('Photo File', employee.photoFileName),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
