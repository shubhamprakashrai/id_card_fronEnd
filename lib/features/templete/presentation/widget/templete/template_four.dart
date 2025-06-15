import 'package:flutter/material.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';

class TemplateFour extends StatelessWidget {
  const TemplateFour({
    super.key,
    required this.employee,
  });
  final Employee employee;



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
                        child: employee.photoFileName.isEmpty
                            ? const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        )
                            : Image.asset(
                          employee.photoFileName,
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
                      employee.fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      employee.designation,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.teal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    infoRow("ID NO", employee.idNumber),
                    infoRow("DOB", employee.dob),
                    infoRow("Blood", employee.bloodGroup),
                    infoRow("Phone", employee.mobileNumber),
                    infoRow("E-mail", employee.email),
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
