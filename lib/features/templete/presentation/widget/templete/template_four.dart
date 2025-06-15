import 'package:flutter/material.dart';

class TemplateFour extends StatelessWidget {
  const TemplateFour({
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
            Column(
              children: [
                Image.asset(
                  'asset/images/templete_four_top.png',
                  fit: BoxFit.cover,
                  height: 160,
                  width: double.infinity,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFF79497), Color(0xFFF7D95F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5), // Border width
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFAD4CF), // Fallback background color
                      ),
                      child: ClipOval(
                        child: imagePath.isEmpty
                            ? const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        )
                            : Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
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
              'asset/images/templete_four_bottom.png',
              fit: BoxFit.cover,
              width: double.infinity,
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
