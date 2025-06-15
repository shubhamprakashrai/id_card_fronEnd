import 'dart:io';
import 'package:flutter/material.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'preview_page.dart';
import 'templete/template_one.dart';
import 'templete/template_two.dart';
import 'templete/template_three.dart';
import 'templete/template_four.dart';
import 'templete/template_five.dart';

class FormPage extends StatefulWidget {
  final int index;
  const FormPage({super.key, required this.index});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final fullNameController = TextEditingController();
  final designationController = TextEditingController();
  final idNumberController = TextEditingController();
  final departmentController = TextEditingController();
  final issueDateController = TextEditingController();
  final expiryDateController = TextEditingController();
  File? selectedImage;
  String? imagePath;

  // Image Picker
  Future<void> pickImage() async {
    if (Platform.isAndroid) {
      if (await Permission.photos.request().isDenied &&
          await Permission.storage.request().isDenied) {
        print("Permissions denied");
        return;
      }
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        imagePath = image.path; // Store the path for preview
      });
      print("Image picked: ${image.path}");
    } else {
      print("No image selected.");
    }
  }

  // Get the appropriate template widget
  Widget _getTemplateWidget(Employee employee) {
    switch (widget.index) {
      case 0:
        return TemplateOne(employee: employee);
      case 1:
        return TemplateTwo(employee: employee);
      case 2:
        return TemplateThree(employee: employee);
      case 3:
        return TemplateFour(employee: employee);
      case 4:
        return TemplateFive(employee: employee);
      default:
        return const Text("Invalid template selected");
    }
  }

  void onPreview() {
    final employee = Employee(
      fullName: fullNameController.text.trim(),
      designation: designationController.text.trim(),
      idNumber: idNumberController.text.trim(),
      department: departmentController.text.trim(),
      issueDate: issueDateController.text.trim(),
      expiryDate: expiryDateController.text.trim(),
      photoFileName: imagePath ?? '',
    );

    if ([
      employee.fullName,
      employee.designation,
      employee.idNumber,
      employee.department,
      employee.issueDate,
      employee.expiryDate,
    ].any((field) => field.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewPage(
          preview: _getTemplateWidget(employee),
        ),
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    designationController.dispose();
    idNumberController.dispose();
    departmentController.dispose();
    issueDateController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Profile Image",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  selectedImage!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text("No image"),
              ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.image),
          label: const Text("Select Image"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fill Your ID Card Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildTextField("Full Name", fullNameController),
            buildTextField("Designation", designationController),
            buildTextField("ID Number", idNumberController),
            buildTextField("Department", departmentController),
            buildTextField("Issue Date (DD/MM/YYYY)", issueDateController),
            buildTextField("Expiry Date (DD/MM/YYYY)", expiryDateController),
            const SizedBox(height: 12),
            buildImagePicker(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPreview,
              child: const Text("Preview"),
            ),
          ],
        ),
      ),
    );
  }
}