import 'dart:io';

void main() {
  stdout.write('Enter your name: ');
  String name = stdin.readLineSync()!;

  stdout.write('Enter account number: ');
  String accountNumber = stdin.readLineSync()!;

  String accountType = '';
  while (accountType != 'savings' && accountType != 'checking') {
    stdout.write('Enter account type (savings/checking): ');
    accountType = stdin.readLineSync()!;
    if (accountType != 'savings' && accountType != 'checking') {
      print('Invalid account type. Please enter "savings" or "checking".');
    }
  }

  stdout.write('Enter initial balance: ');
  double balance = double.tryParse(stdin.readLineSync()!) ?? 0;

  int option = 0;
  do {
    showMenu();
    stdout.write('Choose an option: ');
    option = int.tryParse(stdin.readLineSync()!) ?? 0;

    if (option == 1) {
      stdout.write('Enter amount to deposit: ');
      double amount = double.tryParse(stdin.readLineSync()!) ?? 0;
      balance = deposit(balance, amount);
    } else if (option == 2) {
      stdout.write('Enter amount to withdraw: ');
      double amount = double.tryParse(stdin.readLineSync()!) ?? 0;
      balance = withdraw(balance, amount);
    } else if (option == 3) {
      stdout.write('Enter number of years: ');
      int years = int.tryParse(stdin.readLineSync()!) ?? 0;

      stdout.write('Enter annual profit rate (%): ');
      double profitRate = double.tryParse(stdin.readLineSync()!) ?? 0;

      calculateProfit(balance, years, profitRate);
    } else if (option == 4) {
      showSummary(name, accountNumber, accountType, balance);
    } else if (option == 5) {
      print('Thank you for using the banking system. Goodbye!');
    } else {
      print('Invalid option. Please choose between 1 to 5.');
    }
  } while (option != 5);
}

void showMenu() {
  print('\n------ Menu ------');
  print('1. Deposit');
  print('2. Withdraw');
  print('3. Predict Future Balance (Profit Model)');
  print('4. View Account Summary');
  print('5. Exit');
}

double deposit(double balance, double amount) {
  if (amount > 0) {
    balance += amount;
    print('Deposit successful. New balance: \$${balance.toStringAsFixed(2)}');
  } else {
    print('Invalid amount. Deposit failed.');
  }
  return balance;
}

double withdraw(double balance, double amount) {
  if (amount <= 0) {
    print('Invalid amount. Withdrawal failed.');
  } else if (amount > balance) {
    print('Insufficient balance. Withdrawal denied.');
  } else {
    balance -= amount;
    print(
        'Withdrawal successful. New balance: \$${balance.toStringAsFixed(2)}');
  }
  return balance;
}

void calculateProfit(double balance, int years, double profitRate) {
  if (years < 0 || profitRate < 0) {
    print('Invalid input for years or profit rate.');
    return;
  }
  double futureBalance = balance * (1 + (profitRate / 100) * years);
  print(
      'Predicted future balance after $years years: \$${futureBalance.toStringAsFixed(2)}');
  print('Rounded balance: \$${futureBalance.round()}');
}

void showSummary(
    String name, String accountNumber, String accountType, double balance) {
  print('\nAccount Summary:');
  print('Name: $name');
  print('Account Number: $accountNumber');
  print('Account Type: $accountType');
  print('Current Balance: \$${balance.toStringAsFixed(2)}');
  print('Rounded Balance: \$${balance.round()}');
}
