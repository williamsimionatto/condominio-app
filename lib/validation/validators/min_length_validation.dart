import 'package:equatable/equatable.dart';

import '../../presentation/protocols/validation.dart';
import '../../validation/protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final int size;
  @override
  final String field;

  @override
  List get props => [size, field];

  const MinLengthValidation({required this.size, required this.field});

  @override
  ValidationError validate(String value) {
    return value != null as String && value.length >= size
        ? null as ValidationError
        : ValidationError.invalidField;
  }
}
