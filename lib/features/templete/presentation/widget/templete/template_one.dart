// import 'package:flutter/material.dart';

// class TemplateOne extends StatelessWidget {
//   const TemplateOne({super.key, required this.name, required this.role});
//    final String name;
//   final String role;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(color: Colors.blue.shade50),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children:  [
//           Icon(Icons.person, size: 40, color: Colors.blue),
//           SizedBox(height: 8),
//             Text("Name: $name", style: const TextStyle(fontSize: 16)),
//             Text("Role: $role", style: const TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TemplateOne extends StatelessWidget {
  const TemplateOne({
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
                          child: CircleAvatar(
                            radius: 42,
                            backgroundImage: AssetImage(imagePath),
                          ),
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

