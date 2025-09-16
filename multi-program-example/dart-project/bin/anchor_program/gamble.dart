import 'package:solana/solana.dart';
import 'dart:convert';
import '../../clients/dart/generated/anchor_program/lib.dart';

void gamble(
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
    print("Transaction signature to gamble: $signature");

    final txDetails = await client.getTransaction(signature, commitment: Commitment.confirmed);
    final logs = txDetails?.meta?.logMessages ?? [];
    final anchorError = AnchorProgramError.fromSolanaErrorString(logs.join('\n'));
    if (anchorError != null) {
      print(anchorError);
    } else if (txDetails?.meta?.err != null) {
      print('Transaction failed, but no custom error found in logs.');
    } else {
      print('Transaction succeeded or no error info available.');
    }

    } catch (e) {
    final anchorError = AnchorProgramError.fromSolanaErrorString(e);
    if (anchorError != null) {
      print(anchorError);
    } else {
      print('Error in Gamble Program: $e');
    }
  }
}
