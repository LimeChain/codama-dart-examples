
import 'package:solana/solana.dart';
export '../data_structures/constants.dart';
import '../../clients/dart/generated/anchor_program/lib.dart';

// Init
import 'initialize.dart';
import 'gamble.dart';
import 'fund_reward_pool_system_account.dart';

// Read
import 'read/lib.dart';

// Write
import 'write/lib.dart';


void anchorProgram(RpcClient client, Ed25519HDKeyPair payer) async {
  /// Entry point for interacting with the anchor_program.
  ///
  /// To get started:
  /// 1. Uncomment and implement the initialization functions to create on-chain accounts.
  /// 2. Use the read functions to fetch and inspect account data.
  /// 3. Use the modify functions to update account data and observe changes.
  ///
  /// Example workflow:
  ///   - Call an init function (e.g., `initAnchorAccount`) to create an account.
  ///   - Call the corresponding read function (e.g., `readAnchorAccount`) to verify.
  ///   - Call a modify function (e.g., `modifyAnchorAccount`) to update the account.
  ///   - Read again to see the changes.
  ///
  /// Pass your `RpcClient` and `Ed25519HDKeyPair` to each function as shown below.
  
  // Constant
  final programId = AnchorProgramProgram.programId; // Get the program ID from the generated code

  // ========= Initialization =======================
  // initialize(client, payer, programId);

  // ========= Read/Fetch Accounts ==================
  // getGambleState(client, programId);
  // getRewardPoolState(client, programId);

  // ========= Write/Modify Accounts ================
  // setGambleCost(client, payer, programId);
  // fundRewardPoolSystemAccount(client, payer, programId);
  // gamble(client, payer, programId); // Before gambling first invoke the fundRewardPoolSystemAccount function
}