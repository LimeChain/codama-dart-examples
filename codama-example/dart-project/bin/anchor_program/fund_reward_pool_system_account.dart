import 'package:solana/solana.dart';
import 'dart:convert';

import '../constants.dart';

Future<String> fundRewardPoolSystemAccount(
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

    return signature;
  } catch (e) {
    throw Exception('Failed to fund reward pool system account: $e');
  }
}
