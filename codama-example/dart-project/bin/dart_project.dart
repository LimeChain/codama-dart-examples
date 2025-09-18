import 'package:solana/solana.dart';
import '../utils/lib.dart';

import './anchor_program/lib.dart';

import '../clients/dart/generated/lib.dart';
import 'constants.dart';

RpcClient createSolanaClient() {
  return RpcClient('http://localhost:8899');
}

void main(List<String> arguments) async {
  // Signer keypair
  final Ed25519HDKeyPair payer = await Ed25519HDKeyPair.fromMnemonic(payerMnemonic);

  // Rpc client
  final RpcClient client = createSolanaClient();

  // Load the array account keypair from mnemonic
  final Ed25519HDKeyPair arrayAcc = await Ed25519HDKeyPair.fromMnemonic(
    arrayMnemonic,
  );

  // A type exported from the clients generated code
  final anchorProgramId = AnchorProgramProgram.programId;

  // 1. Airdrop Sol to the payer account
  final airdropSignature2 = await airdropSol(client, payer);
  await waitForConfirmation(client, airdropSignature2);

  // 2. Initialize array and wait for confirmation
  final gambleInitSignature = await initialize(client, payer, anchorProgramId);
  await waitForConfirmation(client, gambleInitSignature);
  print('Init Gamble signature: $gambleInitSignature');

  // 3. Set Gamble Cost
  final setGambleCostSignature = await setGambleCost(client, payer, anchorProgramId);
  await waitForConfirmation(client, setGambleCostSignature);
  print('Set Gamble Cost Signature: $setGambleCostSignature');

  // 4. Fund the Reward Vault
  final fundRewardVaultSignature = await fundRewardPoolSystemAccount(client, payer, anchorProgramId);
  await waitForConfirmation(client, fundRewardVaultSignature);
  print('Fund Reward Vault Signature: $fundRewardVaultSignature');

  // 5. Gamble Instruction
  final gambleSignature = await gamble(client, payer, anchorProgramId);
  await waitForConfirmation(client, gambleSignature);
  print('Gamble Signature: $gambleSignature');

  // 6. Get Gamble State
  final gambleState = await getGambleState(client, anchorProgramId);
  print('\n ======== Gamble State Fetched ========');
  print('Admin: ${gambleState.admin}');
  print('Gamble Cost: ${gambleState.gamble_cost}');
  print('Config Bump: ${gambleState.config_bump}');
  print('Reward Pool Bump: ${gambleState.reward_pool_bump}');

}