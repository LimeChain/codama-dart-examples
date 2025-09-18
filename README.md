# Codama-Dart Examples

This repository contains a collection of example projects that demonstrate how to use the codama-dart renderer in different scenarios. Each example shows how to integrate codama-dart into a Dart project and use it to generate client code from Solana program IDLs.

## Example Projects

- [`multi-program-example/`](multi-program-example/):  
  An advanced example integrating a Solana Anchor program with a Dart CLI. It shows how to generate Dart clients from Anchor and use codama-dart for rich terminal output.

- [`codama-example/`](codama-example/):  
  Example to showcase how to use the dart-renderer with Codama IDL.

## Getting Started

Each example contains its own `README.md` with setup and usage instructions. To try out an example:

1. Navigate to the example directory:
   ```sh
   cd multi-program-example
   ```

2. Follow the steps in the example's `README.md`.

3. Since we have not published the npm package:
  - Clone the `codama-dart` renderer locally from our repository.
  - In your project’s package.json, create a local link to this cloned repo [here](https://github.com/LimeChain/codama-dart-examples/blob/simple-example/multi-program-example/anchor-program/package.json).
  - Use the same approach shown in that example, but update the path so it points to your local copy of `codama-dart`.

## About Codama-Dart

**codama-dart** is a renderer for Dart CLI applications, providing rich and interactive terminal output. These examples are designed to help you understand how to integrate and use codama-dart in your own projects.

---

Feel free to explore, run, and modify the examples to fit
