import 'dart:io';
import 'package:flutter/material.dart';
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
  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final idController = TextEditingController();
  final dobController = TextEditingController();
  final bloodController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  File? selectedImage;

  // Image Picker with setState
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
      });
      print("Image picked: ${image.path}");
    } else {
      print("No image selected.");
    }
  }

  Widget selectedWidget({
    required String name,
    required String role,
    required String id,
    required String dob,
    required String blood,
    required String phone,
    required String email,
    required String imagePath,
  }) {
    switch (widget.index) {
      case 0:
        return TemplateOne(
          name: name,
          role: role,
          id: id,
          dob: dob,
          blood: blood,
          phone: phone,
          email: email,
          imagePath: imagePath,
        );
      case 1:
        return TemplateTwo(
          name: name,
          role: role,
          id: id,
          dob: dob,
          blood: blood,
          phone: phone,
          email: email,
          imagePath: imagePath,
        );
      case 2:
        return TemplateThree(
          name: name,
          role: role,
          id: id,
          dob: dob,
          blood: blood,
          phone: phone,
          email: email,
          imagePath: imagePath,
        );
      case 3:
        return TemplateFour(
          name: name,
          role: role,
          id: id,
          dob: dob,
          blood: blood,
          phone: phone,
          email: email,
          imagePath: imagePath,
        );
      case 4:
        return TemplateFive(
          name: name,
          role: role,
          id: id,
          dob: dob,
          blood: blood,
          phone: phone,
          email: email,
          imagePath: imagePath,
        );
      default:
        return const Text("Invalid template selected");
    }
  }

  void onPreview() {
    final name = nameController.text.trim();
    final role = roleController.text.trim();
    final id = idController.text.trim();
    final dob = dobController.text.trim();
    final blood = bloodController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final imagePath = selectedImage?.path ?? "assets/images/profile.jpg";

    if ([name, role, id, dob, blood, phone, email].any((field) => field.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewPage(
          preview: selectedWidget(
            name: name,
            role: role,
            id: id,
            dob: dob,
            blood: blood,
            phone: phone,
            email: email,
            imagePath: imagePath,
          ),
        ),
      ),
    );
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
            buildTextField("Name", nameController),
            buildTextField("Role", roleController),
            buildTextField("ID", idController),
            buildTextField("Date of Birth (DD/MM/YYYY)", dobController),
            buildTextField("Blood Group", bloodController),
            buildTextField("Phone Number", phoneController, type: TextInputType.phone),
            buildTextField("Email", emailController, type: TextInputType.emailAddress),
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
