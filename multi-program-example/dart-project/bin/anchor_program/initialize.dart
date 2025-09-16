import 'package:solana/solana.dart';
import 'dart:convert';
import '../../clients/dart/generated/anchor_program/lib.dart';

void initialize(
  RpcClient client,
  Ed25519HDKeyPair payer,
  Ed25519HDPublicKey programId,
) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);
  final gambleCost = 1000000; // Example cost, adjust as needed

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

    final initializeIx = InitializeInstruction(
      config: config,
      reward_pool: rewardPool,
      admin: payer.publicKey,
      system_program: systemProgram,
      gamble_cost: BigInt.from(gambleCost),
    ).toInstruction();

    final message = Message(instructions: [initializeIx]);
    final signature = await client.signAndSendTransaction(message, [payer]);

    print("Transaction signature to initialize a gamble instruction: $signature");
  } catch (e) {
    print('Error signing and sending transaction: $e');
  }
}
