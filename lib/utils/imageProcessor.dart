import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as IMG;

class ImageProcessor {
  static Future cropSquare(
      String srcFilePath, String destFilePath, bool flip) async {
    var bytes = await File(srcFilePath).readAsBytes();
    IMG.Image src = IMG.decodeImage(bytes)!;

    var cropSize = min(src.width, src.height);
    int offsetX = (src.width - min(src.width, src.height)) ~/ 2;
    int offsetY = (src.height - min(src.width, src.height)) ~/ 2;

    IMG.Image destImage =
        IMG.copyCrop(src, offsetX, offsetY, cropSize, cropSize);

    if (flip) {
      destImage = IMG.flipVertical(destImage);
    }

    var jpg = IMG.encodeJpg(destImage);
    await File(destFilePath).writeAsBytes(jpg);
  }
}
