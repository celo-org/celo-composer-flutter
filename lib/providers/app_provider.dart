import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AppProvider with ChangeNotifier {
  ReownAppKitModal? _appKitModal;
  bool _isConnected = false;
  String _userAddress = '';
  String _currentChain = '';
  String _balance = '';

  ReownAppKitModal? get appKitModal => _appKitModal;
  bool get isConnected => _isConnected;
  String get userAddress => _userAddress;
  String get currentChain => _currentChain;
  String get balance => _balance; 

  Future<void> initializeAppKitModal(BuildContext context) async {
    ReownAppKitModalNetworks.removeSupportedNetworks('solana');

    _appKitModal = ReownAppKitModal(
      context: context,
      projectId:
          'YOUR-PROJECT-ID', //TODO: Replace with your Project ID
      metadata: const PairingMetadata(
        name: 'Celo Composer',
        description: 'Memecoin trading made easy',
        url: 'https://celo-composer.com/',
        icons: ['assets/images/logo.png'],
      ),
      featuresConfig: FeaturesConfig(
        email: true,
        socials: [AppKitSocialOption.X, AppKitSocialOption.Farcaster],
        showMainWallets: true, 
      ),
    );

    await _appKitModal?.init();

    _appKitModal?.addListener(_updateState);
    _updateState();
  }

  void _updateState() async {
    _isConnected = _appKitModal?.isConnected ?? false;

    if (_isConnected) {
      // Get address using the selected chain's namespace
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          _appKitModal!.selectedChain?.chainId ?? "");

      _userAddress = _appKitModal?.session?.getAddress(namespace) ?? '';
      _currentChain = _appKitModal?.selectedChain?.name ?? 'Unknown';
      _balance =
          _appKitModal?.balanceNotifier.value ?? '0';
    } else {
      _userAddress = ''; 
      _currentChain = ''; 
      _balance = '0';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _appKitModal?.removeListener(_updateState);
    super.dispose();
  }
}
