import 'dart:typed_data';
import 'package:solana/solana.dart';
import '../constants.dart';
import '../../../clients/dart/generated/anchor_data_structures/lib.dart';

Future<String> modifyEnum(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair enumAcc = await Ed25519HDKeyPair.fromMnemonic(
    enumMnemonic,
  );

  try {
    final modifyEnumIx = ModifyEnumInstruction(
      enums_acc: enumAcc.publicKey,
      my_enum: VariantA(300, true), // -> Correct
      // my_enum: VariantB(x: BigInt.from(-150), y: "Updated VariantB"), // -> Correct
      // my_enum: VariantC(), // -> Correct
      // my_enum: VariantE(nested: SimpleStruct(name: "alabbala", age: 23, location: "Ruse"), flag: true) // -> Correct
      // my_enum: VariantF(Uint32List.fromList([10, 20])), // -> Correct
      // my_enum: VariantG("Hello, VariantG!"), // -> Correct
      // my_enum: VariantH(Uint8List.fromList([0, 2, 1, 2])), // -> Correct
      // my_enum: VariantI(a: 12, b: BigInt.from(120), c: true, d: "VariantI"), //  -> Correct
      enum_vec: [
        VariantA(10, false),
        VariantB(x: BigInt.from(20), y: "VariantB in vec"),
        VariantC(),
        VariantE(
          nested: SimpleStruct(name: "nested in vec", age: 30, location: "Sofia"),
          flag: false,
        ),
      ],
      optional_enum: VariantD(15, 250, "Optional VariantD"),
      optional_enum_vec: [
        VariantF(Uint32List.fromList([1, 2, 3])),
        VariantG("VariantG in optional vec"),
      ],
      enum_array: [
        VariantH(Uint8List.fromList([1, 1, 1, 1])),
        VariantC()
      ],
      struct_with_enum: StructWithEnum(
        field_enum: VariantA(123, false),
        field_enum_vec: [
          VariantB(x: BigInt.from(321), y: "In struct vec"),
          VariantC(),
        ],
      ),
      struct_with_optional_enum: StructWithOptionalEnum(field_optional_enum: VariantD(31, 555, "Optional in struct"))
    ).toInstruction();

    final message = Message(instructions: [modifyEnumIx]);
    final signature = await client.signAndSendTransaction(message, [payer]);

    return signature;              
  } catch (e) {
    throw Exception('Failed to modify enum data structure: $e');
  }
}