// import 'dart:typed_data';
import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_data/testClass.dart';

class DemoScreenForDecryption extends StatefulWidget {
  const DemoScreenForDecryption({super.key});

  @override
  _DemoScreenForDecryptionState createState() =>
      _DemoScreenForDecryptionState();
}

class _DemoScreenForDecryptionState extends State<DemoScreenForDecryption> {
  String decryptedText = '';

  final userInp = {
    "itemCode": "P099",
    "itemName": "DOUBLE FRIED CHICKEN 2 PCS300",
    "unit": "pcs",
    "unitPrice": "300.00",
    "vatRate": "5.00",
    "sdRate": "0.00",
    "bin": "005263903-0101",
    "vatPolicyId": 263
  };

  encryptData(String plainText) async {
    final userJson = jsonEncode(plainText);
    final key = enc.Key.fromBase64(
      await rootBundle.loadString('assets/my_secret_key.pem'),
    );

    // final b64key = enc.Key.fromBase64(base64Url.encode(key.bytes));
    final fernet = enc.Fernet(key);
    final encrypter = enc.Encrypter(fernet);
    final encrypted = encrypter.encrypt(userJson);
    print(encrypted.base64);
  }

  test() async {
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
    final decrypted = encrypter.decrypt(enc.Encrypted.from64(abc));

    print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    print(
        "${encrypted.base64}\t  dfjldfjlsdjflsdafjjfsdlajfdsfj\n"); // random cipher text
    print(fernet.extractTimestamp(encrypted.bytes)); // unix timestamp
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Decryption"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  // encryptData("Hello world");
                  EncryptDecrypt.encryptData(userInp);
                },
                child: const Text("Encrypt")),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                // Replace this with your encrypted text
                // const encryptedTextToDecrypt = 'Hello World';
                // decryptWithPrivateKey(encryptedTextToDecrypt);
                EncryptDecrypt.decryptData(
                    "gAAAAABlDBmfCyK8T1B0ZqIcoOAnJkaZtqTWXLOkjo3wQInIMdtaxVLgUU9ufv+5C19b+3+OMaXmKp7i3ZM9CGs+I12mTy3xmMVlQonoz/AMET1zX2S5h8CVOwlO5sRyjMxLW5DgZks9GakbJJQdmp3IyOL8HHFl8cdU6JtQTkNFx57FA3YLW80E4cyVeO4T0gRwJieVMugbQL/OSPeSowAtDOU7NbGNePQ66/0fImqa2TtXGStSbLv5ChQqCZYArUqw32qqM276uXMp7h46/tg7goGPKmY2OA==");
              },
              child: const Text('Decrypt'),
            ),
            const SizedBox(height: 16),
            Text(
                'Decrypted Text: ${EncryptDecrypt.decryptData("gAAAAABlC-i3KJIbRdekTR5ZreYLDxDMoIRB6qRcaK--YURhVezrEU2iPLJVPvadnftPPkHFEG95a7vdxvBLXzVBHOzBSRfwimKQvpr4i1oyN9Ii7q7ACLXugFihLcJF4akbkhcdhfbL0qlUErg85_KTzk9HkuvYefoeu5nLqLb0--9233qfWq968iA17XUdzkaYLnElZlnUwAIozZ4uT3PhS3K8Fsm6dzBCvyXSA9nlb0_5YK7nMl9mT0sYq6i3_qE8SsebZ0NKr4nA9aw1vsXoPOb1z7Wxfzg0gmAnXtwHzUT-5o5nFN-2ZO04jhtcyGD-zn3E3Xzl")}'),
          ],
        ),
      ),
    );
  }
}
