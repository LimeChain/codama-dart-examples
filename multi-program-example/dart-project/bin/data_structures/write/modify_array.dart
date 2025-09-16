import 'dart:typed_data';
import 'package:solana/solana.dart';
import '../constants.dart';
import '../../../clients/dart/generated/anchor_data_structures/lib.dart';

void modifyArray(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair arrayAcc = await Ed25519HDKeyPair.fromMnemonic(
    arrayMnemonic,
  );

  // Result: Modification of the array works as expected for these fields -> Proof Of Serialization 
  try {
    final ModifyArrayInstructionIx = ModifyArrayInstruction(
      array_acc: arrayAcc.publicKey,
      u8_array: Uint8List.fromList([1, 2]),
      i8_array: Int8List.fromList([-1, -2]),
      u16_array: Uint16List.fromList([1000, 2000]),
      i16_array: Int16List.fromList([-1000, -2000]),
      u32_array: Uint32List.fromList([100000, 200000]),
      i32_array: Int32List.fromList([-100000, -200000]),
      u64_array: Uint64List.fromList([10000000000, 20000000000]),
      i64_array: Int64List.fromList([-10000000000, -20000000000]),
      string_vector: ['emil', 'roydev'],
      boolean_vector: [false], // Till here everything works 
      pubkey_vector: [
        (await Ed25519HDKeyPair.random()).publicKey,
        (await Ed25519HDKeyPair.random()).publicKey,
      ],
      struct_vector: [ // This is set correct too
        SimpleStruct(name: 'emil', age: 22, location: 'belgium'),
        SimpleStruct(name: 'roy', age: 25, location: 'france'),
      ],
      // Optional fields works when i provide them all or i pass 'null' to all of them since they are optional
      optional_str: "now I am d",
      option_u32: Uint32List.fromList([42]),
      optional_vec_struct: [SimpleStruct(name: 'optional', age: 30, location: 'nowhere'), SimpleStruct(name: 'another', age: 18, location: 'office')],
      optional_fix_arr: Uint32List.fromList([7, 10, 9]),  // So this works even if i have fixed-sized it just cuts the last element
    ).toInstruction();


    final message = Message(instructions: [ModifyArrayInstructionIx]);
    final signature = await client.signAndSendTransaction(message, [payer]);

    print('Modification of Array Txn Signature: $signature');

  } catch (e) {
    final dsError = DataStructuresError.fromSolanaErrorString(e);
    if (dsError != null) {
      print('Custom program error: $dsError');
      // You can also check the type:
      if (dsError is StringTooLongError) {
        print('String was too long!');
      }
    } else {
      print('Other error: $e');
    }
  }
}
