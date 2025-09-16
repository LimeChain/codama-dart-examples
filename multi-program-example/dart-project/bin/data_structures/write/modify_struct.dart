import 'dart:typed_data';
import 'package:solana/solana.dart';
import '../constants.dart';
import '../../../clients/dart/generated/anchor_data_structures/lib.dart';

void modifyStruct(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair structAcc = await Ed25519HDKeyPair.fromMnemonic(
    structMnemonic,
  );

  try {
    final modifyStructIx = ModifyStructInstruction(
      struct_acc: structAcc.publicKey,
      simple_struct: SimpleStruct(
        name: "Yordan",
        age: 21,
        location: "Sofia",
      ),
      primitive_account: PrimitiveAccount(
        u8_field: 1,
        i8_field: -1,
        u16_field: 100,
        i16_field: -100,
        u32_field: 1000,
        i32_field: -1000,
        u64_field: BigInt.from(10000),
        i64_field: BigInt.from(-10000),
        bool_field: true,
        pubkey_field: (await Ed25519HDKeyPair.random()).publicKey,
        string_field: "abc",
      ),
      string_account: StringAccount(
        simple_string: "hello",
        optional_string: "random",
      ),
      vector_account: VectorAccount(
        u8_vec: Uint8List.fromList([1, 2]),
        i64_vec: Int64List.fromList([-12349, 9871]),
        string_vec: ["hey"],
        pubkey_vec: [Ed25519HDPublicKey(Uint8List.fromList(List.filled(32, 1)))],
      ),
      optional_account: OptionalAccount(
        optional_u32: 12,
        optional_vec: Int64List.fromList([2, 1]),
        optional_struct: SimpleStruct(
          name: "hey",
          age: 23,
          location: "Ruse",
        ),
      ),
      nested_structs: StructAcc(
        simple_struct: NestedStruct(a: 25, b: false),
        nested_vec_struct: [
          NestedStruct(a: 30, b: false),
          NestedStruct(a: 20, b: true),
        ],
        optional_nested: NestedStruct(a: 25, b: true), // If optional, use null if absent
      ),
      fixed_array_account: FixedArrayAccount(
        u8_array: Uint8List.fromList([54, 120, 200, 45]),
        i32_array: Int32List.fromList([-100, -50, 12]),
        pubkey_array: [
          Ed25519HDPublicKey.fromBase58("4vJ9JU1bJJE96FWSJKvHsmmFADCg4gpZQff4P3bkLKi"),
          Ed25519HDPublicKey.fromBase58("4vJ9JU1bJJE96FWSJKvHsmmFADCg4gpZQff4P3bkLKi"),
        ],
      ),
      simple_enum: VariantI(a: 32, b: BigInt.from(64), c: true, d: 'helloworld')
    ).toInstruction();

    final message = Message(instructions: [modifyStructIx]);
    final signature = await client.signAndSendTransaction(message, [payer]);
    print('Modify Struct Txn Signature: $signature');
              
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