import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/controllers/customer/order_history_controller.dart';

void main() {
  test('orderStatus returns correct string based on input', () {
    expect(orderStatus('C'), equals('Collected'));
    expect(orderStatus('U'), equals('UnderPreparation'));
    expect(orderStatus('R'), equals('Ready'));
    expect(orderStatus('X'), equals('Not Accepted'));
  });
}
