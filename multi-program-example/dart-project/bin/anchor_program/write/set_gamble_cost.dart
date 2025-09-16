import 'package:solana/solana.dart';
import 'dart:convert';
import '../../../clients/dart/generated/anchor_program/lib.dart';

void setGambleCost(
  RpcClient client,
  Ed25519HDKeyPair payer,
  Ed25519HDPublicKey programId,
) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);
  final newGamleCost = 2000; // Example cost, adjust as needed

  try {
    final configSeeds = [utf8.encode('config')];

    final config = await Ed25519HDPublicKey.findProgramAddress(
      seeds: configSeeds,
      programId: programId,
    );

    final setGambleCostIx = SetGambleCostInstruction(
      config: config,
      admin: payer.publicKey,
      new_cost: BigInt.from(newGamleCost),
    ).toInstruction();

    final message = Message(instructions: [setGambleCostIx]);
    final signature = await client.signAndSendTransaction(message, [payer]);
    print("Transaction signature to set gamble cost: $signature");
  } catch (e) {
    print('Error getting : $e');
    return;
  }
}
