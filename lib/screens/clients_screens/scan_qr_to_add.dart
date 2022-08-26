import 'dart:convert';
import 'dart:io';

import 'package:collection_app/common_widgets/universal_button.dart';
import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
import 'package:collection_app/screens/clients_screens/scann_customer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({ Key? key }) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  bool _isLoading = false;

  Future<dynamic> compareQrCode({String? qr_code}) async{
    http.Response response = await http.post(
      Uri.parse('$uri/api/compareQr.php'), 
      body: jsonEncode({'qr_code': qr_code}),
      headers: {'Content-Type': 'application/json'});

      print("Za QR ${response.body}");
      var responseCode = jsonDecode(response.body);
      if(response.statusCode == 200){
         print('Zangu nii $responseCode');
         var scannedData = responseCode['data'][0];
        return {
          "code": response.statusCode,
          "my_data": scannedData,
         
        };
      }else{
        return {
          "code": response.statusCode
        };
      }
  }
  //In order to get hotreload to work we need to pause the camera if the platform is android and resume if iOS

  @override
  void reassemble(){
    super.reassemble();
    if(Platform.isAndroid){
      controller!.pauseCamera();
    }else if(Platform.isIOS){
      controller!.resumeCamera();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey, onQRViewCreated: _onQRViewCreated
              )
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    (result != null) ? Text('QrCode: ${describeEnum(result!.format)} Data: ${result!.code}' ) : Text('Scan a QrCode'),
                    SizedBox(height: 5,),
                    ElevatedButton(onPressed: () async{
                      setState(() {
                        _isLoading = true;
                      });
                      CircularProgressIndicator();
                      await Future.delayed(const Duration(seconds: 5));
                      print('Helloooooooooo');
                      compareQrCode(qr_code: result!.code).then((value){
                        print('Value1: ${value['my_data']}');
                        if(value['code'] == 200){
                          print('Value2: $value');
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CapturedQrScreen(data: value!['my_data'])));
                        }
                      });
                      // _sendQrToSecondScreen(context);
                      setState(() {
                        // _isScanned = false;
                      });
                      
                    }, child: Text('Continue..'))
                  ],
                )
                
              )
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) { 
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}