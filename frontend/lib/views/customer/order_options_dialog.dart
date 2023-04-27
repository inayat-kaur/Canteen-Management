import 'package:flutter/material.dart';

class ServiceDialog extends StatefulWidget {
  const ServiceDialog({Key? key}) : super(key: key);

  @override
  _ServiceDialogState createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _serviceType;
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Service Request'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Scheduled'),
              leading: Radio<String>(
                value: 'scheduled',
                groupValue: _serviceType,
                onChanged: (String? value) {
                  setState(() {
                    _serviceType = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Instantaneous'),
              leading: Radio<String>(
                value: 'instantaneous',
                groupValue: _serviceType,
                onChanged: (String? value) {
                  setState(() {
                    _serviceType = value;
                  });
                },
              ),
            ),
            if (_serviceType == 'scheduled')
              Column(
                children: [
                  const SizedBox(height: 8.0),
                  Text('Select a date and time after one hour from now'),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () async {
                      final now = DateTime.now();
                      final date = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: now.add(const Duration(hours: 1)),
                        lastDate: now.add(const Duration(days: 30)),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            _dateTime = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      }
                    },
                    child: const Text('Select date and time'),
                  ),
                  if (_dateTime != null) ...[
                    const SizedBox(height: 8.0),
                    Text(
                      'Selected date and time: ${_dateTime.toString()}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              List<String> serviceRequest = [];
              serviceRequest.add(_serviceType!);
              if (_dateTime != null) {
                serviceRequest.add(_dateTime.toString());
              }
              Navigator.of(context).pop(serviceRequest);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
