import 'package:solana/solana.dart';
import '../../clients/dart/generated/anchor_data_structures/lib.dart';
import 'constants.dart';

void initEnum(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair enumAcc = await Ed25519HDKeyPair.fromMnemonic(
    enumMnemonic,
  );

  final InitArrayInstructionIx = InitEnumsInstruction(
    enums_acc: enumAcc.publicKey,
    payer: payer.publicKey,
    system_program: systemProgram,
  ).toInstruction();

  final message = Message(instructions: [InitArrayInstructionIx]);
  final signature = await client.signAndSendTransaction(message, [payer, enumAcc]);

  print('Init Enum Account Txn Signature: $signature');

  try {} catch (e) {
    print('Error initializing the enum account data structure: $e');
  }
}
