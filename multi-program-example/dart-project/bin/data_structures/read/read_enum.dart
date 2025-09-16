import 'package:solana/solana.dart';
import '../constants.dart';
import '../../../clients/dart/generated/anchor_data_structures/lib.dart';


void printExampleEnum(ExampleEnum enumValue, String prefixMessage) {
  if (enumValue is VariantA) {
    print('${prefixMessage}: VariantA(value0: ${enumValue.value0}, value1: ${enumValue.value1})');
  } else if (enumValue is VariantB) {
    print('${prefixMessage}: VariantB(x: ${enumValue.x}, y: ${enumValue.y})');
  } else if (enumValue is VariantC) {
    print('${prefixMessage}: VariantC');
  } else if (enumValue is VariantD) {
    print('${prefixMessage}: VariantD(a: ${enumValue.value0}, b: ${enumValue.value1}, c: ${enumValue.value2})');
  } else if (enumValue is VariantE) {
    print('${prefixMessage}: VariantE(values: ${enumValue.nested}, flag: ${enumValue.flag})');
    print('Struct Values - name: ${enumValue.nested.name}, age: ${enumValue.nested.age}, location: ${enumValue.nested.location}');
  } else if (enumValue is VariantF) {
    print('${prefixMessage}: VariantF(value0: ${enumValue.value0})');
  } else if (enumValue is VariantG) {
    print('${prefixMessage}: VariantG(value0: ${enumValue.value0})');
  } else if (enumValue is VariantH) {
    print('${prefixMessage}: VariantH(value0: ${enumValue.value0})');
  } else if (enumValue is VariantI) {
    print('${prefixMessage}: VariantI(a: ${enumValue.a}, b: ${enumValue.b}, c: ${enumValue.c}, d: ${enumValue.d})');
  } else {
    print('Unknown variant');
  }
}

// Result: Reading of the array from Blockchain State works as expected for these fields -> Proof Of Deserialization 
void readEnum(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair enumAcc = await Ed25519HDKeyPair.fromMnemonic(
    enumMnemonic,
  );

  final enumAccount = await EnumAccount.fetch(client, enumAcc.publicKey);

  print('\n========================');
  printExampleEnum(enumAccount.my_enum, 'My Enum');
  printExampleEnum(enumAccount.optional_enum!, 'Optional Enum');
  for (var i = 0; i < enumAccount.enum_vec.length; i++) {
    printExampleEnum(enumAccount.enum_vec[i], 'Enum Vec[$i]');
  }
  for (var i = 0; i < enumAccount.optional_enum_vec!.length; i++) {
    printExampleEnum(enumAccount.optional_enum_vec![i], 'Optional Enum Vec[$i]');
  }
  for (var i = 0; i < enumAccount.enum_array.length; i++) {
    printExampleEnum(enumAccount.enum_array[i], 'Enum Array[$i]');
  }

  printExampleEnum(enumAccount.struct_with_enum.field_enum, 'Struct with Enum - field_enum');
  for (var i = 0; i < enumAccount.struct_with_enum.field_enum_vec.length; i++) {
    printExampleEnum(enumAccount.struct_with_enum.field_enum_vec[i], 'Struct with Enum - field_enum_vec[$i]');
  }
  printExampleEnum(enumAccount.struct_with_optional_enum.field_optional_enum!, 'Struct with Optional Enum - field_optional_enum');
  print('========================');
}