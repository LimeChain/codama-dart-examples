import 'package:solana/solana.dart';
import '../../clients/dart/generated/anchor_data_structures/lib.dart';
import './constants.dart';

void initStructs(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair structAcc = await Ed25519HDKeyPair.fromMnemonic(
    structMnemonic,
  );

  try {
    final InitStructsInstructionIx = InitStructsInstruction(
      struct_acc: structAcc.publicKey,
      payer: payer.publicKey,
      system_program: systemProgram,
    ).toInstruction();

    final message = Message(instructions: [InitStructsInstructionIx]);
    final signature =
        await client.signAndSendTransaction(message, [payer, structAcc]);

    print('Init Structs s Txn Signature: $signature');
  } catch (e) {
    print('Error initializing structs data accounts: $e');
  }
}