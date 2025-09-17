import '../utils/generate_mnemonic.dart';

Future<void> main() async {
  await generateAndSaveMnemonic('array.mnemonic');
  await generateAndSaveMnemonic('wallet.mnemonic');
  await generateAndSaveMnemonic('struct.mnemonic');
  await generateAndSaveMnemonic('enum.mnemonic');
}