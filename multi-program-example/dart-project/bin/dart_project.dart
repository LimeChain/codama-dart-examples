import 'dart:io';
import 'package:solana/solana.dart';
import '../utils/lib.dart';

import './data_structures/lib.dart';
import './anchor_program/lib.dart';

RpcClient createSolanaClient() {
  return RpcClient('http://localhost:8899');
}

void main(List<String> arguments) async {
  // Signer keypair
  final Ed25519HDKeyPair payer = await Ed25519HDKeyPair.fromMnemonic(payerMnemonic);

  // Rpc client
  final RpcClient client = createSolanaClient();

  // // Airdrop Sol to the payer account
  airdropSol(client, payer);

  // Get balance of the signer(payer)
  getSolBalance(client, payer.publicKey.toBase58());

  // 1. Run the data structures example.
  //  - To test: Uncomment init/read/modify functions in dataStructures() and observe printed output.
  //  - Example: initialize an account, read its data, modify it, then read again to verify changes.
  // dataStructures(client, payer);

  // 2. Run the anchor program example.
  //  - To test: Uncomment and implement anchorProgram() calls, then follow a similar workflow as above.
  //  - Example: initialize, read, modify, and verify account data for the anchor program.
  // anchorProgram(client, payer);
}