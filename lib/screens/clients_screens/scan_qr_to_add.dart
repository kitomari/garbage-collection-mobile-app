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

  // bool _isScanned = false;
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
        // print('Scanned : $scannedData');
        // return scannedData;
      }else{
        return {
          "code": response.statusCode
        };
      }
  }



  //Send captured QR to the second screen
  // void _sendQrToSecondScreen(BuildContext context){
  //   String qrCaptured = result!.code.toString();
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => CapturedQrScreen(qrCodes: qrCaptured,)));
  // }

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
            // Text('Scan QR Code'),
            // SizedBox(height: 20),
            // _isScanned ? AlertDialog(
            //   content: Center(
            //     child: Text('QR: ${result!.code}'),
            //   ),
            //   // shape: shape,
            //   title: Center(child: Text('QR CODE SCANNED')),
            //   actionsAlignment: MainAxisAlignment.spaceBetween,
            //   actionsPadding: const EdgeInsets.all(8),
            //   actions: [
            //     UniversalButton(
            //       action: (){
            //         setState(() {
            //           _isScanned = false;
            //         });
            //         CircularProgressIndicator();
            //           compareQrCode(qr_code: result!.code).then((value){
            //             if(value['code'] == 200){
            //               Navigator.pop(context);
            //               Navigator.push(context, MaterialPageRoute(builder: (context) => CapturedQrScreen(data: value!['my_data']['data'][0])));
            //             }
            //           });
            //       }, 
            //       buttonColor: Colors.blue, 
            //       child: Text('NEXT'), 
            //       buttonWidth: 100, 
            //       label: ''
            //     ),

            //     UniversalButton(
            //       action: (){
            //         setState(() {
            //           _isScanned = false;
            //         });
            //       }, 
            //       buttonColor: Colors.blue, 
            //       child: Text('CANCEL'), 
            //       buttonWidth: 100, 
            //       label: ''
            //     ),
            //   ],
            // ) : SizedBox(
            //   height: 250,
            //   width: 250,
            //   child: QRView(
            //     overlay: QrScannerOverlayShape(
            //       borderColor: Colors.white,
            //       borderRadius: 20,
            //       overlayColor: Colors.blue
            //     ),
            //     key: qrKey, 
            //     onQRViewCreated: _onQRViewCreated
            //   ),
            // )
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