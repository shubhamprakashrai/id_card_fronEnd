
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:id_card_front_end/features/data_scrapper/data/models/employee.dart';

class TemplateOne extends StatelessWidget {
  const TemplateOne({
    super.key,
    required this.employee
  });

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 5, // similar to the ID card ratio
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          // border: Border.all(color: Colors.grey.shade300),
        ),
        child: Stack(
          children: [
            // Top Curve
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'asset/images/topheader.svg',
                fit: BoxFit.cover,
                height: 220,
              ),
            ),
            // Bottom Image
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Image.asset(
                'asset/images/bottom_id _card_image.png',
                fit: BoxFit.cover,
                height: 100,
              ),
            ),

            Positioned(
              top: 160, // adjust this value to fine-tune position
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.teal,
                  child: (employee.photoFileName.isNotEmpty)? CircleAvatar(
                    radius: 42,
                    backgroundImage: AssetImage(employee.photoFileName),
                  ): null,
                ),
              ),
            ),
            // Main Content
            Positioned(
              top: 260,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Center(
                  child: SizedBox(
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
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
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
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