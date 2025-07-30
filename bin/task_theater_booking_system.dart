import 'dart:io';

class Booking {
  final String name;
  final String phone;

  Booking(this.name, this.phone);

  @override
  String toString() {
    return ' your name is $name and your phone is $phone';
  }
}

void main() {
  List<List<String>> theater = List.generate(5, (_) => List.filled(5, 'E'));

  Map<String, Booking> bookings = {};

  while (true) {
    print("\nWelcome To Our Theater\n");
    print("press 1 to book new seat");
    print("press 2 to show the theater seats");
    print("press 3 to show users data");
    print("press 4 to exit");

    stdout.write("input==-> ");
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      bookSeat(theater, bookings);
    } else if (choice == '2') {
      showTheater(theater);
    } else if (choice == '3') {
      showBookings(bookings);
    } else if (choice == '4') {
      print("\nSee You Back Soon in Our Theater Diamond\n");
      break;
    } else {
      print("Invalid input. Try again.");
    }
  }
}

void bookSeat(List<List<String>> theater, Map<String, Booking> bookings) {
  try {
    stdout.write("Enter row (1-5): ");
    int row = int.parse(stdin.readLineSync()!);
    stdout.write("Enter column (1-5): ");
    int col = int.parse(stdin.readLineSync()!);

    int r = row - 1;
    int c = col - 1;

    if (r < 0 || r >= 5 || c < 0 || c >= 5) {
      print("Invalid seat position.");
      return;
    }

    if (theater[r][c] == 'B') {
      print("Seat already booked.");
      return;
    }

    stdout.write("Enter your name: ");
    String name = stdin.readLineSync()!;
    stdout.write("Enter your phone number: ");
    String phone = stdin.readLineSync()!;

    theater[r][c] = 'B';
    String seatKey = "$row,$col";
    bookings[seatKey] = Booking(name, phone);

    print("Seat booked successfully!");
  } catch (e) {
    print("Invalid input. Please enter numbers.");
  }
}

void showTheater(List<List<String>> theater) {
  print("\nTheater Seats:");
  for (var row in theater) {
    print(row.join(" "));
  }
}

void showBookings(Map<String, Booking> bookings) {
  print("\nUsers Booking Details:");
  if (bookings.isEmpty) {
    print("No bookings yet.");
  } else {
    bookings.forEach((seat, booking) {
      print("Seat $seat: ${booking.toString()}");
    });
  }
}
