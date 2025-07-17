import 'dart:io';

void main() {
  while (true) {
    double subtotal = 0;

    int qtyKeyboard = 0,
        qtyMouse = 0,
        qtyMonitor = 0,
        qtyUsbCable = 0,
        qtyHeadphones = 0;

    showMenu();

    while (true) {
      stdout.write('\nEnter product number to add to cart (0 to finish): ');
      int productNum = int.tryParse(stdin.readLineSync()!) ?? -1;

      if (productNum == 0) break;

      stdout.write('Enter quantity: ');
      int quantity = int.tryParse(stdin.readLineSync()!) ?? 0;

      if (productNum == 1) {
        qtyKeyboard += quantity;
        subtotal += quantity * 100;
      } else if (productNum == 2) {
        qtyMouse += quantity;
        subtotal += quantity * 50;
      } else if (productNum == 3) {
        qtyMonitor += quantity;
        subtotal += quantity * 300;
      } else if (productNum == 4) {
        qtyUsbCable += quantity;
        subtotal += quantity * 20;
      } else if (productNum == 5) {
        qtyHeadphones += quantity;
        subtotal += quantity * 150;
      } else {
        print('Invalid product number.');
      }
    }

    if (subtotal == 0.0) {
      print('No items selected.');
      continue;
    }

    stdout.write('\nPlease enter your name: ');
    String name = stdin.readLineSync()!;

    stdout.write('Please enter your phone number: ');
    String phone = stdin.readLineSync()!;

    double tax = calculateTax(subtotal);
    double discount = calculateDiscount(subtotal);
    double deliveryFee = 0.0;

    stdout.write('Do you want delivery? (yes/no): ');
    String deliveryChoice = stdin.readLineSync()!.toLowerCase();

    if (deliveryChoice == 'yes') {
      stdout.write('Enter delivery distance in km: ');
      double distance = double.tryParse(stdin.readLineSync()!) ?? 0;
      deliveryFee = calculateDeliveryFee(distance);
    }

    double total = subtotal + tax + deliveryFee - discount;

    print('\n----------------------');
    if (qtyKeyboard > 0) {
      print('Keyboard x $qtyKeyboard = \$${qtyKeyboard * 100}');
    }
    if (qtyMouse > 0) print('Mouse x $qtyMouse = \$${qtyMouse * 50}');
    if (qtyMonitor > 0) print('Monitor x $qtyMonitor = \$${qtyMonitor * 300}');
    if (qtyUsbCable > 0) {
      print('USB Cable x $qtyUsbCable = \$${qtyUsbCable * 20}');
    }
    if (qtyHeadphones > 0) {
      print('Headphones x $qtyHeadphones = \$${qtyHeadphones * 150}');
    }

    print('\nSubtotal: \$${subtotal.toStringAsFixed(2)}');
    print('Tax (13%): \$${tax.toStringAsFixed(2)}');
    print('Discount: \$${discount.toStringAsFixed(2)}');
    print('Delivery Fee: \$${deliveryFee.toStringAsFixed(2)}');
    print('Total Amount to Pay: \$${total.toStringAsFixed(2)}');

    print(' \n Thank you for shopping with us, $name!');
    print('-----------------------------------------\n');
  }
}

void showMenu() {
  print('\nWelcome to the store!');
  print('\nAvailable Products:');
  print('1. Keyboard - \$100');
  print('2. Mouse - \$50');
  print('3. Monitor - \$300');
  print('4. USB Cable - \$20');
  print('5. Headphones - \$150');
}

double calculateTax(double amount) {
  return amount * 0.13;
}

double calculateDiscount(double amount) {
  if (amount > 1000) {
    return amount * 0.10;
  }
  return 0.0;
}

double calculateDeliveryFee(double distance) {
  return ((distance / 10).ceil()) * 15.0;
}
