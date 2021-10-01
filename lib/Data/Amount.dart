class Amount {
  final double? value;
  final String? unit;

  Amount({
    required this.value,
    required this.unit
  });

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
        value: json['value'].toDouble(),
        unit: json['unit']
    );
  }
}