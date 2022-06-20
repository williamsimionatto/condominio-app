import 'package:condominioapp/main/builders/validation_builder.dart';
import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/validation/protocols/field_validation.dart';
import 'package:condominioapp/validation/validators/validators.dart';

Validation makeAddUserValidation() =>
    ValidationComposite(makeAddUserValidations());

List<FieldValidation> makeAddUserValidations() => [
      ...ValidationBuilder.field('name').required().min(3).build(),
      ...ValidationBuilder.field('email').required().email().build(),
      ...ValidationBuilder.field('password').required().min(6).build(),
      ...ValidationBuilder.field('passwordConfirmation')
          .required()
          .sameAs('password')
          .build(),
      ...ValidationBuilder.field('cpf').required().cpf().build(),
    ];
