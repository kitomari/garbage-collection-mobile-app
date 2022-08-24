import 'dart:convert';
import 'dart:io';

import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
import 'package:collection_app/screens/clients_screens/scann_customer.dart';
import 'package:collection_app/services/add_collection_service.dart';
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

    // String name;
    // String category;
    // String amount;
    // String user_id;

  Future<void> compareQrCode({required String qr_code}) async{
    http.Response response = await http.post(
      Uri.parse('$uri/api/compareQrCode.php'), 
      body: jsonEncode({'qr_code': qr_code}),
      headers: {'Content-Type': 'application/json'});

      print("Data zotez ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        var allDataz = data['data'];

        if(allDataz != null){
          DataServices.qrInfo = allDataz;
        }else{
          return  null;
        }
        // return qrInfo;
      }
  }



  //Send captured QR to the second screen
  void _sendQrToSecondScreen(BuildContext context){
    String qrCaptured = result!.code.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => CapturedQrScreen(qrCodes: qrCaptured,)));
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