class Amount {
  final double? value;
  final String? unit;

  Amount({
    required this.value,
    required this.unit
  });

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
        value: double.parse('${json['value']}'),
        unit: json['unit']
    );
  }
}