import 'package:openpgp/openpgp.dart';

class Encryption {
  Future<KeyPair> generateKey(String passphrase) async {
    var keyOptions = KeyOptions()..rsaBits = 2048;
    var keyPair = await OpenPGP.generate(
        options: Options()
          ..passphrase = passphrase
          ..keyOptions = keyOptions);
    return keyPair;
  }

  Future<String> encrypt(String publicKey, String data) async {
    String result = await OpenPGP.encrypt(data, publicKey);
    return result;
  }

  decrypt(String privateKey, String data, String passphrase) async {
    var result = await OpenPGP.decrypt(data, privateKey, passphrase);
    return result;
  }
}
