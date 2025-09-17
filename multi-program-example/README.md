# Multi-Program Example: Anchor & Dart Codama Renderer Integration

This repository demonstrates how to integrate a Solana Anchor program with a Dart CLI application using the **codama-dart renderer**. The workflow showcases generating Dart clients from your Anchor program and rendering output in the terminal.

## Project Structure

- [`anchor-program/`](anchor-program/): Solana Anchor smart contract + script that generates the `codama-dart` client.
- [`dart-project/`](dart-project/): Dart CLI app using codama-dart renderer

## Quick Start

### 1. Compile & Deploy Anchor Program Locally

Navigate to the Anchor program directory and build/deploy to your local Solana validator:

```sh
cd anchor-program
anchor build
anchor deploy
```

Make sure your local validator is running (`solana-test-validator`).

### 2. Generate Dart Clients

From the `anchor-program` directory, run the client generator script:

```sh
pnpm generate:clients
```

This will generate the `clients/` folder inside [`dart-project/`](dart-project/clients/) with Dart client code for your Anchor program.

### 3. Set Up Dart Project

1. Navigate to the Dart project and install dependencies:

```sh
cd ../dart-project
dart pub get
```

2. Before running the Dart CLI, you must generate the required mnemonic files for the test wallets. Run the following command to automatically create all necessary mnemonics in the keypairs/ directory:


```sh
dart run scripts/generate_all_mnemonics.dart
```

### 4. Run the Dart CLI

Read the comments in the entrypoint file ([`bin/dart_project.dart`](dart-project/bin/dart_project.dart)) for usage instructions, then run:

```sh
dart run
```

You can now interact with your Anchor program from Dart, with terminal output rendered by codama-dart.

---

## Notes

- The [`clients/`](dart-project/clients/) directory is auto-generated and should not be edited manually.
- The Dart CLI is easily extensible—check the code comments for guidance on adding your own commands or logic.
- Ensure your Solana CLI and Anchor CLI are installed and configured for local development.

---

Feel free to explore and modify both the Anchor and Dart projects to fit your needs!