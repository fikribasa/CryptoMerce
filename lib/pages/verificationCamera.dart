import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:wartec_app/components/primaryButton.dart';

class VerificationCameraScreen extends StatefulWidget {
  final String? type;
  VerificationCameraScreen(this.type);
  @override
  _State createState() => _State();
}

class _State extends State<VerificationCameraScreen>
    with TickerProviderStateMixin {
  CameraController? controller;
  List? cameras;
  int? selectedCameraIdx;

  XFile? capturedFile;
  bool isPreView = false;
  bool isPrecessing = false;

  get _getAppbar {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 1.0,
      leading: new InkWell(
        child: new Icon(
          Icons.close,
          color: Colors.white,
          size: 30,
        ),
        onTap: () {
          Get.back();
        },
      ),
      centerTitle: true,
    );
  }

  Future _initCameraController(CameraDescription cameraDescription,
      [BuildContext? context]) async {
    setState(() {
      isPrecessing = true;
    });
    if (controller != null) {
      await controller!.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    controller!.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller!.value.hasError) {
        print('Camera error ${controller!.value.errorDescription}');
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      if (context != null) {
        showCameraException(context, e);
      }
    }

    if (mounted) {
      setState(() {
        isPrecessing = false;
      });
    }
  }

  Widget _cameraTogglesRowWidget(BuildContext ctx) {
    if (cameras == null || cameras!.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras![selectedCameraIdx!];
    if (isPreView) {
      return Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                  "Make sure your ${widget.type} and its information are clearly visible"),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: PrimaryOutline(
                          onPressed: () {
                            setState(() {
                              isPreView = false;
                            });
                          },
                          label: "Retake")),
                  SizedBox(width: 20),
                  Expanded(
                    child: PrimaryButton(
                      label: "Submit",
                      onPressed: () {
                        print("capturedFile: ${capturedFile!.path}");
                        Get.back(result: capturedFile);
                      },
                    ),
                  ),
                ],
              )
            ],
          ));
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 60),
          InkWell(
            child: Container(
                child: Image.asset("assets/icons/shutter.png", width: 80)),
            onTap: isPrecessing
                ? null
                : () {
                    setState(() {
                      _onCapturePressed(context);
                    });
                  },
          ),
          InkWell(
              child: Container(
                  child: Image.asset("assets/icons/camera.png", width: 60)),
              onTap: isPrecessing
                  ? null
                  : () {
                      setState(() {
                        isPreView = false;
                      });
                      _onSwitchCamera(ctx);
                    }),
          // FlatButton.icon(
          //   onPressed: isPrecessing
          //       ? null
          //       : () {
          //           setState(() {
          //             isPreView = false;
          //           });
          //           _onSwitchCamera();
          //         },
          //   icon: Icon(
          //     getCameraLensIcon(lensDirection),
          //     size: 35,
          //   ),
          //   label: Text(
          //       "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}"),
          // ),
          // FlatButton.icon(
          //   onPressed: isPrecessing
          //       ? null
          //       : () {
          //           if (isPreView) {
          //             setState(() {
          //               isPreView = false;
          //             });
          //           } else {
          //             setState(() {
          //               _onCapturePressed(context);
          //             });
          //           }
          //         },
          //   icon: Icon(
          //     Icons.save,
          //     size: 35,
          //   ),
          //   label: isPreView ? Text('Retake') : Text('Capture'),
          // ),
        ],
      ),
    );
  }

  void _onSwitchCamera(BuildContext context) async {
    selectedCameraIdx =
        selectedCameraIdx! < cameras!.length - 1 ? selectedCameraIdx! + 1 : 0;
    CameraDescription selectedCamera = cameras![selectedCameraIdx!];

    await _initCameraController(selectedCamera, context);
    setState(() {
      isPreView = false;
    });
  }

  void showInSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void showCameraException(BuildContext context, CameraException e) {
    showInSnackBar(context, 'Error: ${e.code}\n${e.description}');
  }

  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  void _onCapturePressed(context) async {
    setState(() {
      isPrecessing = true;
    });
    try {
      capturedFile = await controller!.takePicture();

      setState(() {
        isPrecessing = false;
        isPreView = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _imagePreviewOrCamera(BuildContext context) {
    if (isPrecessing) {
      return Expanded(
          flex: 1, child: Center(child: CircularProgressIndicator()));
    }
    if (isPreView) {
      return Expanded(
        flex: 1,
        child: Stack(
          children: [
            Container(
              child: Image.file(File(capturedFile!.path)),
            ),
          ],
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
          child: Stack(
            children: [
              // AspectRatio(
              //   aspectRatio: 1,
              //   child: ClipRect(
              //     child: Transform.scale(
              //       scale: 1 / controller!.value.aspectRatio,
              //       child: Center(
              //         child: AspectRatio(
              //           aspectRatio: controller!.value.aspectRatio,
              //           child: CameraPreview(controller!),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              buildCameraPreview(context, controller!),
            ],
          ),
        ),
      );
    }
  }

  Widget buildCameraPreview(
      BuildContext context, CameraController cameraController) {
    final double previewAspectRatio = 1;
    final mediaSize = MediaQuery.of(context).size;
    final scale =
        1 / (cameraController.value.aspectRatio * mediaSize.aspectRatio);
    return Center(
      child: ClipRect(
        clipper: _MediaSizeClipper(mediaSize),
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: CameraPreview(cameraController),
        ),
      ),
    );
  }

  Widget cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return CameraPreview(controller!);
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(capturedFile!.path).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }

  @override
  void dispose() {
    super.dispose();
    if (controller != null) {
      controller!.dispose();
    }
  }

  @override
  void initState() {
    super.initState();

    availableCameras().then((availableCameras) async {
      cameras = availableCameras;
      if (cameras!.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        await _initCameraController(cameras![selectedCameraIdx!]);
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err');
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: _getAppbar,
      body: Container(
        child: Column(
          children: [
            // buildCameraPreview(controller!),
            _imagePreviewOrCamera(context),
            _cameraTogglesRowWidget(context)
          ],
        ),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
