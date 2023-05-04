import 'package:flutter/material.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/controllers/owner/edit_menu_item_controller.dart';

import '../utils/colors.dart';
import '../utils/helper.dart';

class EditMenuItem extends StatefulWidget {
  final Menu menu;

  const EditMenuItem({Key? key, required this.menu}) : super(key: key);

  @override
  State<EditMenuItem> createState() => _EditMenuItemState();
}

class _EditMenuItemState extends State<EditMenuItem> {
  bool editPrice = false;
  bool editAvailability = false;
  TextEditingController _priceController = TextEditingController();
  String _availability = 'A';

  @override
  Widget build(BuildContext context) {
    _availability = widget.menu.availability;
    EditMenuItemController editMenuItemController = EditMenuItemController();
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Menu Item'),
        ),
        body: Container(
            width: Helper.getScreenWidth(context),
            height: Helper.getScreenHeight(context),
            child: SafeArea(
                child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 30,
              ),
              child: Column(children: [
                Text(
                  widget.menu.item,
                  style: Helper.getTheme(context).titleLarge,
                ),
                Expanded(
                  child: ListView(padding: EdgeInsets.all(20), children: [
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.currency_rupee),
                      title: editPrice
                          ? TextField(
                              decoration: InputDecoration(
                                hintText: "Price",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                fillColor: AppColor.placeholderBg,
                                hintStyle: TextStyle(
                                  color: AppColor.placeholder,
                                ),
                              ),
                              controller: _priceController,
                            )
                          : Text(widget.menu.price.toString()),
                      trailing: editPrice
                          ? IconButton(
                              icon: Icon(Icons.save),
                              onPressed: () async {
                                String newPrice =
                                    await editMenuItemController.updatePrice(
                                        _priceController.text.trim(),
                                        widget.menu.item);
                                setState(() {
                                  widget.menu.price = int.parse(newPrice);
                                  editPrice = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  editPrice = true;
                                });
                              },
                            ),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.food_bank),
                      title: editAvailability
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Availability: "),
                                DropdownButton<String>(
                                  value: _availability,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _availability = newValue!;
                                      widget.menu.availability = newValue;
                                    });
                                  },
                                  items: <String>['A', 'U']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value == 'A' ? "A" : "U"),
                                    );
                                  }).toList(),
                                ),
                              ],
                            )
                          : Text(widget.menu.availability == 'A' ? "A" : "U"),
                      trailing: editAvailability
                          ? IconButton(
                              icon: Icon(Icons.save),
                              onPressed: () async {
                                String newAvailability =
                                    await editMenuItemController
                                        .updateAvailability(
                                            _availability, widget.menu.item);
                                setState(() {
                                  widget.menu.availability = newAvailability;
                                  editAvailability = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  editAvailability = true;
                                });
                              },
                            ),
                    ),
                    SizedBox(height: 20),
                  ]),
                )
              ]),
            ))));
  }
}

// class _EditMenuItemState extends State<EditMenuItem> {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Menu Item'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               decoration: const InputDecoration(labelText: "Item Name"),
//               initialValue: widget.menu.item,
//               validator: (value) {
//                 EditMenuItemController().validateItemName(value);
//               },
//               onChanged: (value) {
//                 widget.menu.item = value;
//               },
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: "Price",
//                 prefixText: "₹",
//               ),
//               initialValue: widget.menu.price.toString(),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 EditMenuItemController().validatePrice(value);
//               },
//               onChanged: (value) {
//                 widget.menu.price = int.parse(value);
//               },
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const Text("Availability: "),
//                 DropdownButton<String>(
//                   value: widget.menu.availability,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       widget.menu.availability = newValue!;
//                     });
//                   },
//                   items: <String>['A', 'U']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value == 'A' ? "Available" : "Unavailable"),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const Text("Type: "),
//                 DropdownButton<int>(
//                   value: widget.menu.type,
//                   onChanged: (int? newValue) {
//                     setState(() {
//                       widget.menu.type = newValue!;
//                     });
//                   },
//                   items: <int>[0, 1].map<DropdownMenuItem<int>>((int value) {
//                     return DropdownMenuItem<int>(
//                       value: value,
//                       child: Text(value == 0 ? "Veg" : "Non-Veg"),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // validate the form inputs
//                   if (_formKey.currentState!.validate()) {
//                     // save the menu item data
//                     EditMenuItemController().editMenuItem(widget.menu);
//                   }
//                 },
//                 child: const Text("Edit item in the Menu"),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
