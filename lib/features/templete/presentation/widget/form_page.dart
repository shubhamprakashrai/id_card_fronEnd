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
  final mobileNumberController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();

  File? selectedImage;
  String? imagePath;

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
        imagePath = image.path;
      });
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

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
      mobileNumber: mobileNumberController.text.trim(),
      bloodGroup: bloodGroupController.text.trim(),
      dob: dobController.text.trim(),
      email: emailController.text.trim(),
    );

    if ([
      employee.fullName,
      employee.designation,
      employee.idNumber,
      employee.department,
      employee.issueDate,
      employee.expiryDate,
      employee.mobileNumber,
      employee.bloodGroup,
      employee.dob,
      employee.email,
    ].any((field) => field.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PreviewPage(
          preview: _getTemplateWidget(employee),
        ),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
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
    mobileNumberController.dispose();
    bloodGroupController.dispose();
    dobController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType type = TextInputType.text, IconData? icon, VoidCallback? onTap}) {
    return TextField(
      controller: controller,
      keyboardType: type,
      readOnly: onTap != null,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  Widget buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      selectedImage!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton.icon(
            onPressed: pickImage,
            icon: const Icon(Icons.image, color: Colors.white),
            label: const Text("Choose Image", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSectionTitle(String title) {
    return Row(
      children: [
        const Icon(Icons.label_important, color: Colors.indigo),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.indigo,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: children
              .map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ID Card Information"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle("Personal Details"),
              const SizedBox(height: 12),
              _buildCard([
                buildTextField("Full Name", fullNameController, icon: Icons.person),
                buildTextField("Designation", designationController, icon: Icons.work),
                buildTextField("Department", departmentController, icon: Icons.apartment),
                buildTextField("Mobile Number", mobileNumberController,
                    type: TextInputType.phone, icon: Icons.phone),
                buildTextField("Email", emailController,
                    type: TextInputType.emailAddress, icon: Icons.email),
                buildTextField("Date of Birth (DD/MM/YYYY)", dobController,
                    icon: Icons.cake, onTap: () => _selectDate(dobController)),
                buildTextField("Blood Group", bloodGroupController, icon: Icons.bloodtype),
              ]),

              const SizedBox(height: 20),
              buildSectionTitle("ID Details"),
              const SizedBox(height: 12),
              _buildCard([
                buildTextField("ID Number", idNumberController, icon: Icons.badge),
                buildTextField("Issue Date (DD/MM/YYYY)", issueDateController,
                    icon: Icons.date_range, onTap: () => _selectDate(issueDateController)),
                buildTextField("Expiry Date (DD/MM/YYYY)", expiryDateController,
                    icon: Icons.event, onTap: () => _selectDate(expiryDateController)),
              ]),

              const SizedBox(height: 20),
              buildSectionTitle("Photo"),
              const SizedBox(height: 8),
              buildImagePicker(),

              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPreview,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Preview ID Card",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
