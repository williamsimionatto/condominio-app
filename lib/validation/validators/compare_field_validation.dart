import 'package:condominioapp/presentation/protocols/validation.dart';

import '../../validation/protocols/field_validation.dart';

class CompareFieldsValidation implements FieldValidation {
  @override
  final String field;
  final String fieldToCompare;

  const CompareFieldsValidation({
    required this.field,
    required this.fieldToCompare,
  });

  @override
  ValidationError? validate(Map input) => input[field] != null &&
          input[fieldToCompare] != null &&
          input[field] != input[fieldToCompare]
      ? ValidationError.invalidField
      : null;
}
