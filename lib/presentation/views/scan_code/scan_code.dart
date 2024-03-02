// ignore_for_file: unnecessary_cast, use_build_context_synchronously
import 'dart:io';
import 'dart:typed_data';

import 'package:certify/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CertifiedScanner extends StatefulWidget {
  const CertifiedScanner({super.key});

  @override
  State<CertifiedScanner> createState() => _CertifiedScannerState();
}

class _CertifiedScannerState extends State<CertifiedScanner> {
  late MobileScannerController cameraController;
  late String imagePath;
  final ImagePicker picker = ImagePicker();
  late XFile? pickedFile;
  late final List<Barcode> barcodes;
  late final Uint8List? image;
  Future<bool> _pickImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Get the file path from the picked image
      imagePath = pickedFile!.path;
      debugPrint('Image Path: $imagePath');

      // You can use imagePath as needed (e.g., display in an Image widget)
      // Example:
      // Image.file(File(imagePath));
      return true;
    } else {
      debugPrint('No image selected.');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Text(
          'Certify Code',
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: "Montesserat",
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black.withOpacity(.8),
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).unselectedWidgetColor,
            icon: const Icon(Icons.image_rounded),
            iconSize: 25.sp,
            onPressed: () {
              _pickImage().then((value) async {
                bool isCode = await cameraController.analyzeImage(imagePath);
                if (isCode == true) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: Text(
                          barcodes.first.rawValue ?? "",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: "Montesserat",
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        content: Image.file(File(imagePath)),
                      );
                    },
                  );
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 320.w,
                    height: 300.h,
                    child: MobileScanner(
                      controller: cameraController,
                      onDetect: (capture) {
                        barcodes = capture.barcodes;
                        image = capture.image;
                        for (final barcode in barcodes) {
                          debugPrint('Barcode found! ${barcode.rawValue}');
                        }
                        if (image != null) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog.adaptive(
                                  title: Text(
                                    barcodes.first.rawValue ?? "",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontFamily: "Montesserat",
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  content: Image(
                                    image: MemoryImage(image!),
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ).afmBorderRadius(
                    BorderRadius.circular(
                      10.r,
                    ),
                  ),
                ),
                Container(
                  width: 120.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.sp,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Theme.of(context).dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          color: Theme.of(context).unselectedWidgetColor,
                          icon: ValueListenableBuilder(
                            valueListenable: cameraController.torchState,
                            builder: (context, state, child) {
                              switch (state as TorchState) {
                                case TorchState.off:
                                  return Icon(
                                    Icons.flash_off,
                                    color:
                                        Theme.of(context).unselectedWidgetColor,
                                  );
                                case TorchState.on:
                                  return const Icon(Icons.flash_on,
                                      color: Colors.yellow);
                              }
                            },
                          ),
                          iconSize: 25.sp,
                          onPressed: () {
                            setState(() {});
                            cameraController.toggleTorch();
                          }),
                      IconButton(
                        color: Theme.of(context).unselectedWidgetColor,
                        icon: ValueListenableBuilder(
                          valueListenable: cameraController.cameraFacingState,
                          builder: (context, state, child) {
                            switch (state as CameraFacing) {
                              case CameraFacing.front:
                                return const Icon(Icons.cameraswitch_rounded);
                              case CameraFacing.back:
                                return const Icon(Icons.cameraswitch_rounded);
                            }
                          },
                        ),
                        iconSize: 25.sp,
                        onPressed: () => cameraController.switchCamera(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
