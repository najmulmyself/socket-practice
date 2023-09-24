import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/services.dart';

class EncryptDecrypt {
  String encryptedText = '';
  String decryptedText = '';

  static Future<String> encryptData(Map<String, dynamic> plainText) async {
    final userJson = jsonEncode(plainText);
    // print(userJson);
    final key = enc.Key.fromBase64(
      await rootBundle.loadString('assets/my_secret_key.pem'),
    );

    // final b64key = enc.Key.fromBase64(base64Url.encode(key.bytes));
    final fernet = enc.Fernet(key);
    final encrypter = enc.Encrypter(fernet);
    final encrypted = encrypter.encrypt(userJson);
    print(encrypted.base64);
    return encrypted.base64.toString();
  }

  static decryptData(String encText) async {
    final key = enc.Key.fromBase64(
        await rootBundle.loadString('assets/my_secret_key.pem'));

    // final b64key = enc.Key.fromBase64(base64Url.encode(key.bytes));
    // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    final fernet = enc.Fernet(key);
    final encrypter = enc.Encrypter(fernet);

    final encrypted = encrypter.encrypt(encText);
    final decrypted = encrypter.decrypt(enc.Encrypted.from64(encText));
    print(decrypted);
    // print(jsonDecode(decrypted)['ciphertext']);
    // print(
    //     "${encrypted.base64}\t  dfjldfjlsdjflsdafjjfsdlajfdsfj\n"); // random cipher text
    // print(fernet.extractTimestamp(encrypted.bytes)); // unix timestamp
  }
}
