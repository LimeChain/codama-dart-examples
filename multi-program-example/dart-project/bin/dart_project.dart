import 'package:solana/solana.dart';
import '../utils/lib.dart';

import './data_structures/lib.dart';
import './anchor_program/lib.dart';

import '../clients/dart/generated/anchor_data_structures/lib.dart';
import '../clients/dart/generated/anchor_program/lib.dart';

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

  // ============= Run the first anchor program from the examples =============
  //  - initialize an account, read its data, modify it, then read again to verify changes.

  // 1. Airdrop Sol to the payer account
  final airdropSignature = await airdropSol(client, payer);
  await waitForConfirmation(client, airdropSignature);

  // 2. Initialize array and wait for confirmation
  final signature = await initArray(client, payer);
  await waitForConfirmation(client, signature);
  print('Init Array Txn Signature: $signature');

  // 3. Read array
  final arrayAccount =  await ArrayAccount.fetch(client, arrayAcc.publicKey);
  // Access the deserialized account fields below (e.g., arrays, balances, etc.) programmatically
  print('First ArrayAccount Read:');
  print('u8_array: ${arrayAccount.u8_array}');
  print('i8_array: ${arrayAccount.i8_array}');
  print("...\n");
  // ... 

  // 4. Modify array
  final modifySignature = await modifyArray(client, payer);
  await waitForConfirmation(client, modifySignature);
  print('Modify Array Txn Signature: $modifySignature');

  // 5. Read array again
  final arrayAccountAgain = await ArrayAccount.fetch(client, arrayAcc.publicKey);
  // you can access the properties of this account now
  print('Second ArrayAccount Read:');
  print('u8_array: ${arrayAccountAgain.u8_array}');
  print('i8_array: ${arrayAccountAgain.i8_array}');
  print("...\n");

  // You can experiment with the rest of the functions like:
  // Or just inspect the code in them 
  // initEnum(client, payer);
  // initStructs(client, payer);
  // modifyEnum(client, payer);
  // modifyStruct(client, payer);

  // ============= Run the second anchor program from the examples =============

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