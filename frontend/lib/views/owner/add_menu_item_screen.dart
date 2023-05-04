import 'package:flutter/material.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/controllers/owner/add_menu_item_controller.dart';

class AddMenuItem extends StatefulWidget {
  final String category;

  const AddMenuItem({Key? key, required this.category}) : super(key: key);

  @override
  State<AddMenuItem> createState() => _AddMenuItemState();
}

class _AddMenuItemState extends State<AddMenuItem> {
  final _formKey = GlobalKey<FormState>();

  final Menu menu = Menu(
      item: "",
      price: 0,
      availability: "U",
      rating: 0,
      category: "",
      type: 0,
      image: '');

  @override
  Widget build(BuildContext context) {
    setState(() {
      menu.category = widget.category;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Menu Item'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Item Name"),
              validator: (value) {
                AddMenuItemController().validateItemName(value);
              },
              onChanged: (value) {
                setState(() {
                  menu.item = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: "Item Image Link"),
              validator: (value) {
                AddMenuItemController().validateItemName(value);
              },
              onChanged: (value) {
                setState(() {
                  menu.image = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Price",
                prefixText: "₹",
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                AddMenuItemController().validatePrice(value);
              },
              onChanged: (value) {
                setState(() {
                  menu.price = int.parse(value);
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Availability: "),
                DropdownButton<String>(
                  value: menu.availability,
                  onChanged: (String? newValue) {
                    setState(() {
                      menu.availability = newValue!;
                    });
                  },
                  items: <String>['A', 'U']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value == 'A' ? "Available" : "Unavailable"),
                    );
                  }).toList(),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Type: "),
                DropdownButton<int>(
                  value: menu.type,
                  onChanged: (int? newValue) {
                    setState(() {
                      menu.type = newValue!;
                    });
                  },
                  items: <int>[0, 1].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value == 0 ? "Veg" : "Non-Veg"),
                    );
                  }).toList(),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // validate the form inputs
                  if (_formKey.currentState!.validate()) {
                    // save the menu item data
                    AddMenuItemController().addNewMenuItem(menu, context);
                  }
                },
                child: const Text("Add item in the Menu"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
