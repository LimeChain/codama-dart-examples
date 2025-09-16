import 'package:solana/solana.dart';
import '../../clients/dart/generated/anchor_data_structures/lib.dart';
import 'constants.dart';


void initArray(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair arrayAcc = await Ed25519HDKeyPair.fromMnemonic(
    arrayMnemonic,
  );

  final InitArrayInstructionIx = InitArrayInstruction(
    array_acc: arrayAcc.publicKey,
    payer: payer.publicKey,
    system_program: systemProgram,
  ).toInstruction();

  final message = Message(instructions: [InitArrayInstructionIx]);
  final signature = await client.signAndSendTransaction(message, [payer, arrayAcc]);

  print('Init Array Txn Signature: $signature');

  try {} catch (e) {
    print('Error initializing array data structure: $e');
  }
}
