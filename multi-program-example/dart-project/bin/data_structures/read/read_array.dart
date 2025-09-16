import 'package:solana/solana.dart';
import '../../../clients/dart/generated/anchor_data_structures/lib.dart';
import '../constants.dart';

// Result: Reading of the array from Blockchain State works as expected for these fields -> Proof Of Deserialization 
void readArray(RpcClient client, Ed25519HDKeyPair payer) async {
  final Ed25519HDKeyPair arrayAcc = await Ed25519HDKeyPair.fromMnemonic(
    arrayMnemonic,
  );
  final arrayAccount = await ArrayAccount.fetch(client, arrayAcc.publicKey);
  print('u8_array: ${arrayAccount.u8_array}');
  print('i8_array: ${arrayAccount.i8_array}');
  print('u16_array: ${arrayAccount.u16_array}');
  print('u8_array: ${arrayAccount.u8_array}');
  print('i8_array: ${arrayAccount.i8_array}');
  print('i16_array: ${arrayAccount.i16_array}');
  print('u32_array: ${arrayAccount.u32_array}');
  print('i32_array: ${arrayAccount.i32_array}');
  print('u64_array: ${arrayAccount.u64_array}');
  print('i64_array: ${arrayAccount.i64_array}');
  print('fixed_i8: ${arrayAccount.fixed_i8}');
  print('fixed_u16: ${arrayAccount.fixed_u16}');
  print('fixed_i16: ${arrayAccount.fixed_i16}');
  print('fixed_u32: ${arrayAccount.fixed_u32}');
  print('fixed_i32: ${arrayAccount.fixed_i32}');
  print('fixed_u64: ${arrayAccount.fixed_u64}');
  print('fixed_i64: ${arrayAccount.fixed_i64}');
  print('string_vector: ${arrayAccount.string_vector}'); 
  print('bool_vector: ${arrayAccount.boolean_vector}');
  print('pubkey_vector: ${arrayAccount.pubkey_vector}');
  print('struct_vector: ${arrayAccount.struct_vector}');
  print('nested_u32: ${arrayAccount.nested_u32}');
  print('optional_str: ${arrayAccount.optional_str}');
  print('option_u32: ${arrayAccount.option_u32}');
  print('optional_vec_struct: ${arrayAccount.optional_vec_struct}');
  print('optional_fix_array: ${arrayAccount.optional_fix_arr}');

  // Inspect SimpleStruct
  print('\n ========= Struct Vector Details: ========');
  for (var struct in arrayAccount.struct_vector) {
    print('Name: ${struct.name}, Age: ${struct.age}, Location: ${struct.location}');
  }

  print('\n ========= Optional Struct Vector Details: ========');
  if (arrayAccount.optional_vec_struct != null) {
    for (var struct in arrayAccount.optional_vec_struct!) {
      print('Name: ${struct.name}, Age: ${struct.age}, Location: ${struct.location}');
    }
  }
}