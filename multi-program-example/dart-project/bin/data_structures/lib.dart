
import 'package:solana/solana.dart';
export 'constants.dart';

// Init
import 'init_array.dart';
import 'init_enum.dart';
import 'init_structs.dart';

// Read
import 'read/lib.dart';

// Write
import 'write/lib.dart';


void dataStructures(RpcClient client, Ed25519HDKeyPair payer) async {
  /// Entry point for interacting with the data_structures program.
  ///
  /// To get started:
  /// 1. Uncomment the initialization functions to create on-chain accounts.
  /// 2. Use the read functions to fetch and inspect account data.
  /// 3. Use the modify functions to update account data and observe changes.
  ///
  /// Example workflow:
  ///   - Call an init function (e.g., `initArray`) to create an account.
  ///   - Call the corresponding read function (e.g., `readArray`) to verify.
  ///   - Call a modify function (e.g., `modifyArray`) to update the account.
  ///   - Read again to see the changes.
  ///
  /// Pass your `RpcClient` and `Ed25519HDKeyPair` to each function as shown below.

  // ========= Initialization =======================
  // initArray(client, payer);
  // initEnum(client, payer);
  // initStructs(client, payer);

  // ========= Read/Fetch Accounts ==================
  // readArray(client, payer);
  // readEnum(client, payer);
  // readStruct(client, payer);

  // ========= Write/Modify Accounts ================
  // modifyArray(client, payer);
  // modifyEnum(client, payer);
  // modifyStruct(client, payer);
}