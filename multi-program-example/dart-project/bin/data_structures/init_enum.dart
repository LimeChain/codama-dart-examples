import 'package:solana/solana.dart';
import '../../clients/dart/generated/anchor_data_structures/lib.dart';
import 'constants.dart';

Future<String> initEnum(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair enumAcc = await Ed25519HDKeyPair.fromMnemonic(
    enumMnemonic,
  );

  final InitArrayInstructionIx = InitEnumsInstruction(
    enums_acc: enumAcc.publicKey,
    payer: payer.publicKey,
    system_program: systemProgram,
  ).toInstruction();

  try {
    final message = Message(instructions: [InitArrayInstructionIx]);
    final signature = await client.signAndSendTransaction(message, [payer, enumAcc]);

  return signature;
  } catch (e) {
    throw Exception('Failed to initialize enum data structure: $e');
  }
}
