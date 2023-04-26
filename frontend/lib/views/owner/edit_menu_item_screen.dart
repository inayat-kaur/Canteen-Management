import 'package:flutter/material.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/controllers/owner/edit_menu_item_controller.dart';

class EditMenuItem extends StatefulWidget {
  final Menu menu;

  const EditMenuItem({Key? key, required this.menu}) : super(key: key);

  @override
  State<EditMenuItem> createState() => _EditMenuItemState();
}

class _EditMenuItemState extends State<EditMenuItem> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Menu Item'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Item Name"),
              initialValue: widget.menu.item,
              validator: (value) {
                EditMenuItemController().validateItemName(value);
              },
              onChanged: (value) {
                widget.menu.item = value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Price",
                prefixText: "₹",
              ),
              initialValue: widget.menu.price.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                EditMenuItemController().validatePrice(value);
              },
              onChanged: (value) {
                widget.menu.price = int.parse(value);
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Availability: "),
                DropdownButton<String>(
                  value: widget.menu.availability,
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.menu.availability = newValue!;
                    });
                  },
                  items: <String>['A', 'U']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value == 'A' ? "Available" : "Unavailable"),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Type: "),
                DropdownButton<int>(
                  value: widget.menu.type,
                  onChanged: (int? newValue) {
                    setState(() {
                      widget.menu.type = newValue!;
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
                    EditMenuItemController().editMenuItem(widget.menu);
                  }
                },
                child: const Text("Edit item in the Menu"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
