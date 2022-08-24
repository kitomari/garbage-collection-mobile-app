import 'dart:io';

import 'package:collection_app/screens/clients_screens/add_client.dart';
// import 'package:collection_app/screens/clients_screens/captured_qr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScannerRegister extends StatefulWidget {
  const QrCodeScannerRegister({ Key? key }) : super(key: key);

  @override
  State<QrCodeScannerRegister> createState() => _QrCodeScannerRegisterState();
}

class _QrCodeScannerRegisterState extends State<QrCodeScannerRegister> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

    //Send captured QR to the second screen
  void _sendQrToSecondScreen(BuildContext context){
    String qrCaptured = result!.code.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddClientScreen(qrCodes: qrCaptured,)));
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
      body: Column(
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
                  ElevatedButton(onPressed: (){
                    _sendQrToSecondScreen(context);
                  }, child: Text('Continue..'))
                ],
              )
              
            )
          ),
        ],
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