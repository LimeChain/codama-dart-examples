import 'package:solana/solana.dart';
import '../../../clients/dart/generated/anchor_data_structures/lib.dart';
import '../constants.dart';

// Result: Reading of the array from Blockchain State works as expected for these fields -> Proof Of Deserialization 
void readStruct(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair structAcc = await Ed25519HDKeyPair.fromMnemonic(
    structMnemonic,
  );

  final structAccount = await StructAccount.fetch(client, structAcc.publicKey);
  print('Simple Struct Account - \n'
    'name: ${structAccount.simple_struct.name}, \n'
    'age: ${structAccount.simple_struct.age}, \n'
    'location: ${structAccount.simple_struct.location}, \n'
  );

  print('Primitive Account - \n'
    'u8_field: ${structAccount.primitive_account.u8_field}, \n'
    'i8_field: ${structAccount.primitive_account.i8_field}, \n'
    'u16_field: ${structAccount.primitive_account.u16_field}, \n'
    'i16_field: ${structAccount.primitive_account.i16_field}, \n'
    'u32_field: ${structAccount.primitive_account.u32_field}, \n'
    'i32_field: ${structAccount.primitive_account.i32_field}, \n'
    'u64_field: ${structAccount.primitive_account.u64_field}, \n'
    'i64_field: ${structAccount.primitive_account.i64_field}, \n'
    'bool_field: ${structAccount.primitive_account.bool_field}, \n'
    'pubkey_field: ${structAccount.primitive_account.pubkey_field} \n'
    'string_field: ${structAccount.primitive_account.string_field} \n'
  );

  print('String Account - \n'
    'simple_string: ${structAccount.string_account.simple_string}, \n'
    'optional_string: ${structAccount.string_account.optional_string}, \n'
  );

  print('Vectors Account - \n'
    'u8_vec: ${structAccount.vector_account.u8_vec}, \n'
    'i16_vec: ${structAccount.vector_account.i64_vec}, \n'
    'string_vec: ${structAccount.vector_account.string_vec}, \n'
    'pubkey_vec: ${structAccount.vector_account.pubkey_vec}, \n'
  );

  print('Optional Account - \n'
    'optional_u32: ${structAccount.optional_account.optional_u32}, \n'
    'optional_vec: ${structAccount.optional_account.optional_vec}, \n'
    'optional_struct: ${structAccount.optional_account.optional_struct != null ? structAccount.optional_account.optional_struct!.name : null}, \n'
  );

  print('Struct Acc - \n'
    'simple_struct: ${structAccount.nested_structs.simple_struct}, \n'
    '   Simple Struct - a: ${structAccount.nested_structs.simple_struct.a}, b: ${structAccount.nested_structs.simple_struct.b} \n'
    'nested_vec_struct: ${structAccount.nested_structs.nested_vec_struct}, \n'
    '   Nested Vec Struct - ${structAccount.nested_structs.nested_vec_struct.map((e) => 'a: ${e.a}, b: ${e.b}').join(' | ')} \n'
    'optional_nested: ${structAccount.nested_structs.optional_nested} \n'
    '   Optional Nested - a: ${structAccount.nested_structs.optional_nested!.a}, b: ${structAccount.nested_structs.optional_nested!.b} \n'
  );

  print('Fixed Array Account - \n'
    'u8_array: ${structAccount.fixed_array_account.u8_array}, \n'
    'i32_array: ${structAccount.fixed_array_account.i32_array}, \n'
    'pubkey_array: ${structAccount.fixed_array_account.pubkey_array}, \n'
  );


  if (structAccount.simple_enum is VariantA) {
    final v = structAccount.simple_enum as VariantA;
    print('simple_enum: VariantA(value0: ${v.value0}, value1: ${v.value1})');
  } else if (structAccount.simple_enum is VariantB) {
    final v = structAccount.simple_enum as VariantB;
    print('simple_enum: VariantB(x: ${v.x}, y: ${v.y})');
  } else if (structAccount.simple_enum is VariantD) {
    final v = structAccount.simple_enum as VariantD;
    print('simple_enum: VariantD(value0: ${v.value0}, value1: ${v.value1}, value2: ${v.value2})');
  } else if (structAccount.simple_enum is VariantE) {
    final v = structAccount.simple_enum as VariantE;
    print('simple_enum: VariantE(nested: (name: ${v.nested.name}, age: ${v.nested.age}, location: ${v.nested.location}), flag: ${v.flag})');
  } else if (structAccount.simple_enum is VariantF) {
    final v = structAccount.simple_enum as VariantF;
    print('simple_enum: VariantF(value0: ${v.value0})');
  } else if (structAccount.simple_enum is VariantG) {
    final v = structAccount.simple_enum as VariantG;
    print('simple_enum: VariantG(value0: ${v.value0})');
  } else if (structAccount.simple_enum is VariantH) {
    final v = structAccount.simple_enum as VariantH;
    print('simple_enum: VariantH(value0: ${v.value0})');
  } else if (structAccount.simple_enum is VariantI) {
    final v = structAccount.simple_enum as VariantI;
    print('simple_enum: VariantI(a: ${v.a}, b: ${v.b} c: ${v.c}, d: ${v.d})');
  } else if (structAccount.simple_enum is VariantC) {
    print('simple_enum: VariantC()');
  } else {
    print('Unknown enum variant');
  }
}