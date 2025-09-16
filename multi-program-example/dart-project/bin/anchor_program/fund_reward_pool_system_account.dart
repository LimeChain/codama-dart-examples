import 'package:solana/solana.dart';
import 'dart:convert';
import '../../clients/dart/generated/anchor_program/lib.dart';
import '../data_structures/constants.dart'; 

void fundRewardPoolSystemAccount(
  RpcClient client,
  Ed25519HDKeyPair payer,
  Ed25519HDPublicKey programId,
) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);
  final lamportsToFund = oneSolInLamports * 10; // Fund with 10 SOL

  try {
    final rewardPoolSeeds = [utf8.encode('reward_pool')];

    final rewardPool = await Ed25519HDPublicKey.findProgramAddress(
      seeds: rewardPoolSeeds,
      programId: programId,
    );

    final instruction = SystemInstruction.transfer(
      fundingAccount: payer.publicKey,
      recipientAccount: rewardPool,
      lamports: lamportsToFund,
    );

    final message = Message(instructions: [instruction]);
    final signature = await client.signAndSendTransaction(message, [payer]);

    print('Funded reward pool. Transaction signature: $signature');
  } catch (e) {
    print('Error creating reward pool account: $e');
  }
}
