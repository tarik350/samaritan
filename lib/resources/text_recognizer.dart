import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class TextReconitionModel {
  static Future<String> getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    String scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }

    /// i don't know why we need the for loop we can simply return the scanned text
    /// using the following line
    // return recognisedText.text;

    // print("==========================================" +
    //     scannedText +
    //     "++++++++++++++++++++++++++");
    // textScanning = false;
    // setState(() {});
    return scannedText;
  }
}
