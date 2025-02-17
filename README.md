# Celo Composer Flutter Template

**Issue Title:** Feature Request: Create `celo-composer-flutter` - A Flutter Plugin for Celo Web3 Development

### Introduction

This issue proposes the creation of `celo-composer-flutter`, a Flutter plugin designed to mirror the functionality and user experience of our existing `celo-composer` React template.  Our goal is to provide a seamless and intuitive starting point for developers looking to build Web3 applications on Celo using Flutter.

### Requirement

Our primary goal is to create a Flutter plugin (`celo-composer-flutter`) that provides a similar developer experience and core functionalities as the existing `celo-composer` React template. This includes:

- **Template Structure:** Establish a foundational Flutter project structure optimized for Celo Web3 development.
- **UI Components:** Implement a set of reusable Flutter UI components that mirror the look and feel of the React template where applicable (buttons, input fields, wallet connection components, etc.). The focus should be on a clean and intuitive UI.
- **Web3 Integration:** Seamless integration with Celo blockchain using appropriate Flutter Web3 libraries (e.g., [web3dart](https://www.google.com/url?sa=E&source=gmail&q=https://pub.dev/packages/web3dart&authuser=1) or similar).
- **Wallet Connection:** Simplified mechanisms for connecting to popular Celo wallets (e.g., MetaMask via WalletConnect, Valora, etc.).
- **Example Template:** Provide a working example template showcasing the plugin's capabilities, including common Web3 interactions (e.g., reading contract data, sending transactions).
- **Comprehensive Documentation:** Crucially, provide clear and concise documentation to guide developers through setup, usage, and customization of the `celo-composer-flutter` template.

### Contribution Guidelines

- **Start with a Clear Proposal (Optional but Recommended):** Before diving into code, consider opening a discussion in this issue or creating a separate issue to discuss your approach, specific features you plan to implement, or any design choices. This helps ensure alignment and avoids duplicated effort.
- **Follow Project Conventions:** Adhere to established Flutter and Dart coding conventions. Look at existing Flutter projects for best practices. If a `.flutterformat` or `.dartformat` configuration is established, please use it.
- **Mirror UI/UX of React Template (Where Relevant):** While Flutter UI will have its own style, strive to maintain a similar user experience and visual language to the `celo-composer` React template for core components and flows. Consistency is key for users familiar with the React version.
- **Comprehensive Documentation is Essential:** **Every PR must include updated documentation.** This is non-negotiable. Documentation should include:
    - **Installation Instructions:** Clear steps on how to add the `celo-composer-flutter` plugin to a Flutter project.
    - **Template Usage Guide:** Detailed instructions on how to use the provided example template.
    - **Command Reference:** List all essential commands for running the template (e.g., `flutter run`, commands for local development, etc.). Be explicit and provide copy-pasteable commands.
    - **Component and Feature Documentation:** Document each core component and feature of the plugin, explaining its purpose, usage, and any relevant parameters or configurations.
    - **Troubleshooting Tips (Optional but Helpful):** Anticipate common issues developers might encounter and provide troubleshooting advice.
- **Clear and Concise Commit Messages:** Use meaningful commit messages that describe the changes made in each commit. This makes the PR review process smoother and helps maintain a clean project history.

### **Getting Started:**

- **Fork the Repository:** Fork github.com/celo-org/celo-composer-flutter to your personal Github account.
- **Clone Your Fork:** Clone the forked repository to your local machine.
- **Explore the `celo-composer` React Template:** Familiarize yourself with the features and UI of the React template to guide the Flutter plugin development.
- **Start Building!** Begin implementing the Flutter plugin and template, keeping the guidelines above in mind.
