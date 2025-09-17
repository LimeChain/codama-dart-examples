import 'package:solana/solana.dart';
import '../constants.dart';
import '../../../clients/dart/generated/anchor_data_structures/lib.dart';

// This example demonstrates how to access enum variants generated as sealed classes in Dart.
// You can use `is` checks and direct property access to work with the data.

Future<EnumAccount> readEnum(RpcClient client, Ed25519HDKeyPair payer) async {
  final Ed25519HDKeyPair enumAcc = await Ed25519HDKeyPair.fromMnemonic(enumMnemonic);
  final enumAccount = await EnumAccount.fetch(client, enumAcc.publicKey);

  // Accessing a simple enum field
  final ExampleEnum myEnum = enumAccount.my_enum;
  if (myEnum is VariantA) {
    // Access fields specific to VariantA
    print('VariantA: value0=${myEnum.value0}, value1=${myEnum.value1}');
  } else if (myEnum is VariantB) {
    print('VariantB: x=${myEnum.x}, y=${myEnum.y}');
  }

  // Accessing an optional enum
  final ExampleEnum? optionalEnum = enumAccount.optional_enum;
  if (optionalEnum != null && optionalEnum is VariantC) {
    print('OptionalEnum is VariantC');
  }

  // Accessing enums in a vector
  for (final e in enumAccount.enum_vec) {
    if (e is VariantD) {
      print('EnumVec element is VariantD: a=${e.value0}, b=${e.value1}, c=${e.value2}');
    }
  }

  // Accessing enums in an array
  for (final e in enumAccount.enum_array) {
    if (e is VariantE) {
      print('EnumArray element is VariantE: flag=${e.flag}');
    }
  }

  // Accessing enums inside a struct
  final ExampleEnum structEnum = enumAccount.struct_with_enum.field_enum;
  if (structEnum is VariantF) {
    print('Struct field_enum is VariantF: value0=${structEnum.value0}');
  }

  return enumAccount;
}