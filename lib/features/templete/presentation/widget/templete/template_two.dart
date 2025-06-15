import 'package:flutter/material.dart';

class TemplateTwo extends StatelessWidget {

  const TemplateTwo({
    super.key,
    required this.name,
    required this.role,
    required this.id,
    required this.dob,
    required this.blood,
    required this.phone,
    required this.email,
    required this.imagePath,
  });

  final String name;
  final String role;
  final String id;
  final String dob;
  final String blood;
  final String phone;
  final String email;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return
      Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(color: Colors.green.shade50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'asset/images/templete_two_head.png',
            fit: BoxFit.cover,
            height: 100,
            width: double.infinity,
          ),
          Column(
            children: [
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffaaf66e),width: 4),
                  // 0xff66BB6A
                  // color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  infoRow("ID NO", id),
                  infoRow("DOB", dob),
                  infoRow("Blood", blood),
                  infoRow("Phone", phone),
                  infoRow("E-mail", email),
                  //  const Spacer(),
                  // Image.asset(
                  //   'assets/images/barcode.png', // placeholder for barcode
                  //   height: 40,
                  // ),
                  //  const SizedBox(height: 8),
                ],
              ),
            ],
          ),
          Image.asset(
            'asset/images/templete_two_botton.png',
            fit: BoxFit.cover,
            height: 100,
          ),
          // SizedBox(height: 8),
           // Text("Name: $name", style: const TextStyle(fontSize: 16)),
           //  Text("Role: $role", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }


  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 35),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
