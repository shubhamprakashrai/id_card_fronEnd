import 'package:flutter/material.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';

class TemplateTwo extends StatelessWidget {

  const TemplateTwo({
    super.key,
    required this.employee
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
                  image:employee.photoFileName.isNotEmpty? DecorationImage(
                    image: AssetImage(employee.photoFileName),
                    fit: BoxFit.cover,
                  ): null,
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
