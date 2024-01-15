class Field<T> {
  final T value;
  final String? errorMessage;
  final bool isValid;

  const Field({
    required this.value,
    this.errorMessage,
    this.isValid = false,
  });

  Field<T> copyWith({T? value, String? errorMessage, bool? isValid}) {
    return Field(
      value: value ?? this.value,
      errorMessage: errorMessage ?? this.errorMessage,
      isValid: isValid ?? this.isValid,
    );
  }
}
