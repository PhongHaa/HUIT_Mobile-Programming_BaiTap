class Expense {
  final int? id;
  final String title;
  final double amount;
  final String note;
  final DateTime date;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'note': note,
      'date': date.toIso8601String(),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      note: map['note'],
      date: DateTime.parse(map['date']),
    );
  }
}