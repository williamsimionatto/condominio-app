import 'package:condominioapp/presentation/protocols/validation.dart';

import '../../validation/protocols/field_validation.dart';

class CompareFieldsValidation implements FieldValidation {
  @override
  final String field;
  final String valueToCompare;

  const CompareFieldsValidation({
    required this.field,
    required this.valueToCompare,
  });

  @override
  ValidationError? validate(String value) {
    return value == valueToCompare ? null : ValidationError.invalidField;
  }
}
