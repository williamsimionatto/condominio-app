import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/validation/protocols/field_validation.dart';
import 'package:equatable/equatable.dart';

class CPFValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const CPFValidation(this.field);

  @override
  ValidationError? validate(Map input) {
    final regex = RegExp(r"^[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{2}$");

    final isValid =
        input[field]?.isNotEmpty != true || regex.hasMatch(input[field]);
    return isValid ? null : ValidationError.invalidField;
  }
}
