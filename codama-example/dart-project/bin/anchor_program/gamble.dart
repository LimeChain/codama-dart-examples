import 'package:solana/solana.dart';
import 'dart:convert';

import '../../clients/dart/generated/lib.dart';

Future<String> gamble(
  RpcClient client,
  Ed25519HDKeyPair payer,
  Ed25519HDPublicKey programId,
) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  try {
    final configSeeds = [utf8.encode('config')];

    final config = await Ed25519HDPublicKey.findProgramAddress(
      seeds: configSeeds,
      programId: programId,
    );

    final rewardPoolSeeds = [utf8.encode('reward_pool')];

    final rewardPool = await Ed25519HDPublicKey.findProgramAddress(
      seeds: rewardPoolSeeds,
      programId: programId,
    );

    final gambelIx = GambleInstruction(
      config: config,
      user: payer.publicKey,
      reward_pool: rewardPool,
      system_program: systemProgram,
    ).toInstruction();

    final message = Message(instructions: [gambelIx]);
    final signature = await client.signAndSendTransaction(message, [payer]);

    return signature;
    } catch (e) {
    final anchorError = AnchorProgramError.fromSolanaErrorString(e);
    if (anchorError != null) {
      print(anchorError);
      throw Exception('Gamble Program Error: $anchorError');
    } else {
      print('Error in Gamble Program: $e');
      throw Exception('Failed to execute gamble: $e');
    }
  }
}
