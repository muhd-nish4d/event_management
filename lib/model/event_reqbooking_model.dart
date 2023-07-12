class EventBookingReq {
  final String? partyType;
  final String? location;
  final String? amount;
  final String? aboutParty;
  String? date;
  String? senderId;
  final String? recipientId;
  final String? status;

  EventBookingReq(
      {required this.partyType,
      required this.location,
      required this.amount,
      required this.aboutParty,
      required this.date,
      required this.senderId,
      required this.recipientId,
      required this.status});

  factory EventBookingReq.fromMap(Map<String, dynamic> map) {
    return EventBookingReq(
        partyType: map['partyType'],
        location: map['place'],
        amount: map['amount'],
        aboutParty: map['about'],
        date: map['date'],
        senderId: map['senderId'],
        recipientId: map['recipientId'],
        status: map['status']);
  }

  Map<String, dynamic> toMap() {
    return {
      'partyType': partyType,
      'place': location,
      'amount': amount,
      'about' : aboutParty,
      'date': date,
      'senderId': senderId,
      'recipientId': recipientId,
      'status': status
    };
  }
}
