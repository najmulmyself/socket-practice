import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/services.dart';

class EncryptDecrypt {
  String encryptedText = '';
  String decryptedText = '';

  static Future<String> encryptData(Map<String, dynamic> plainText) async {
    final userJson = jsonEncode(plainText);
    print(userJson);
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
    const plainText = 'hello world';

    // final publicPem = await rootBundle.loadString('assets/my_secret_key.pem');
    // final publicKey = enc.RSAKeyParser().parse(publicPem);

    // print("$publicKey++++++++");

    final key = enc.Key.fromBase64(
        await rootBundle.loadString('assets/my_secret_key.pem'));

    String navin =
        "gAAAAABlCB95QE89r8WW-nn2vuXboCw8GyA-M117CimpJ_9J8bYNTXHMrurTQ4fHiZ8bsu_GZubDsa282-mCFb767ehQanRg7gs4aeAxTpMaCaIvUV4evT6ahwQSQViXgBNERx19XfJheR36-yyO2l9x742-hc0nr2yOIS9J6KOomEKcNa4sCQoai8LK7D1l3T-DX8_50lMmF0lQH4HFeZ5htlH2bM64baxC4GRVF8u49SBpkkGzleF333blTSAammd0iXnc9MqlHh-hOOBxoPf-aEbQT9RT7kLXRAIKnuuhViVTf_1HBA4vB0ZO2n2yf7tdoByNpcYmtO25DmLXeSc-OG1Lw0JCksiAiMNdU7V-ybLKD85ecGLahlFNMYozitXx1pa2I_mreROfbVepXgiaNVef6D-Chd4i2GLV4EbivR2b86FBs7Puw_Oz82jpx-Nf13KAXT1ioA2ZymWhBzv8oQy9xK3m5qvX5SoOCPUpjSL4-zuDU_zDL6cPakmr6ps4qdN9xWpuZFh_uy9a288U2brUV3ayybBb2NSHmSFYk5FQNv7S2hQ5uFSEVd5puE6NF10U0jNQ";

    String abc =
        "gAAAAABlCCSAwMi17efzDdPd1dYqYIdYLmcMjZzWnF9ewFpXeLha9WBhgVgO9ySJ/mhEnWzACYYMC4Ys3JHBeFpHTjatou5RSw==";

    // final b64key = enc.Key.fromBase64(base64Url.encode(key.bytes));
    // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    final fernet = enc.Fernet(key);
    final encrypter = enc.Encrypter(fernet);

    final encrypted = encrypter.encrypt(plainText);
    final decrypted = encrypter.decrypt(enc.Encrypted.from64(encText));
    print(decrypted);
    print(jsonDecode(decrypted)['username']);
    print(
        "${encrypted.base64}\t  dfjldfjlsdjflsdafjjfsdlajfdsfj\n"); // random cipher text
    print(fernet.extractTimestamp(encrypted.bytes)); // unix timestamp
  }
}
