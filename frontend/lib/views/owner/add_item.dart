// import 'package:flutter/material.dart';
// import 'package:frontend/models/menu.dart';
// import 'package:frontend/urls.dart';
// import '../utils/colors.dart';
// import '../utils/helper.dart';
// import 'package:http/http.dart';

// class AddItem extends StatefulWidget {
//   // const SignUpScreen({super.key});
//   static const routeName = '/signupScreen';

//   @override
//   State<AddItem> createState() => _AddItemState();
// }

// class _AddItemState extends State<AddItem> {
//   // item VARCHAR(50) PRIMARY KEY,
//   //   price INT,
//   //   availability CHAR,
//   //   rating INT,
//   //   category CHAR,
//   //   type INT

//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _priceController = TextEditingController();
//   TextEditingController _ratingController = TextEditingController();

//   Client client = Client();

//   String _item = '';
//   double _price = 0.0;
//   String _availability = 'In Stock';
//   double _rating = 0.0;
//   String? _type = 'Veg';

//   List<String> _availabilityOptions = ['In Stock', 'Out of Stock'];
//   List<String> _typeOptions = ['Veg', 'Non-Veg'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       width: Helper.getScreenWidth(context),
//       height: Helper.getScreenHeight(context),
//       child: SafeArea(
//         child: Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 40,
//               vertical: 30,
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   "Add Menu Item",
//                   style: Helper.getTheme(context).titleLarge,
//                 ),
//                 Spacer(),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Name",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     fillColor: AppColor.placeholderBg,
//                     hintStyle: TextStyle(
//                       color: AppColor.placeholder,
//                     ),
//                   ),
//                   controller: _nameController,
//                 ),
//                 Spacer(),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Price",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     fillColor: AppColor.placeholderBg,
//                     hintStyle: TextStyle(
//                       color: AppColor.placeholder,
//                     ),
//                   ),
//                   controller: _priceController,
//                 ),
//                 Spacer(),
//                 DropdownButton(
//                     items: _availabilityOptions.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _availability = value!;
//                       });
//                     }),
//                 Spacer(),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Rating",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     fillColor: AppColor.placeholderBg,
//                     hintStyle: TextStyle(
//                       color: AppColor.placeholder,
//                     ),
//                   ),
//                   controller: _ratingController,
//                 ),
//                 Spacer(),
//                 Row(
//                   children: <Widget>[
//                     Text('Veg'),
//                     Radio(
//                       value: 'Veg',
//                       groupValue: _type,
//                       onChanged: (value) {
//                         setState(() {
//                           _type = value!;
//                         });
//                       },
//                     ),
//                     Text('Non-Veg'),
//                     Radio(
//                       value: 'Non-Veg',
//                       groupValue: _type,
//                       onChanged: (value) {
//                         setState(() {
//                           _type = value!;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () async {
                      
//                         Response response =
//                             await client.post(signUp, body: user.toJson());
//                         if (response.statusCode == 201) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text("Sign Up Successful"),
//                             ),
//                           );
//                           Navigator.of(context)
//                               .pushReplacementNamed(LoginScreen.routeName);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text("Sign Up Failed"),
//                             ),
//                           );
//                         }
//                       }
//                     },
//                     child: Text("Sign Up"),
//                   ),
//                 ),
//                 Spacer(),
//                 GestureDetector(
//                     onTap: () {
//                       Navigator.of(context)
//                           .pushReplacementNamed(LoginScreen.routeName);
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Already have an account?"),
//                         Text(
//                           "Login",
//                           style: TextStyle(
//                             color: AppColor.orange,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ))
//               ],
//             )),
//       ),
//     ));
//   }
// }
