import 'package:flutter/material.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';

class TemplateThree extends StatelessWidget {

  const TemplateThree({
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
            Image.asset(
              'asset/images/templete_three_head.png',
              fit: BoxFit.cover,
              height: 140,
              width: double.infinity,
            ),
            Column(
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color:  Color(0xff557eb0),width: 4),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    image: employee.photoFileName.isNotEmpty?DecorationImage(
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
                  ],
                ),
              ],
            ),
            Image.asset(
              'asset/images/templete_three_bottom.png',
              fit: BoxFit.fill,
              height: 50,
            ),
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
                color: Colors.teal,
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
