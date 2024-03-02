import 'dart:io';
import 'dart:ui';

import 'package:certify/core/constants/env_assets.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/presentation/general_components/auth_component_1.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/general_components/general_example_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CreateProduct extends ConsumerStatefulWidget {
  const CreateProduct({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateProductState();
}

class _CreateProductState extends ConsumerState<CreateProduct> {
  late String imagePath = "";
  final ImagePicker picker = ImagePicker();
  late XFile? pickedFile;
  late final Uint8List? image;
  late TextEditingController nameController;
  late TextEditingController shortNameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    shortNameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  Future<bool> _pickImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Get the file path from the picked image
      imagePath = pickedFile!.path;
      debugPrint('Image Path: $imagePath');

      // You can use imagePath as needed (e.g., display in an Image widget)
      // Example:
      // Image.file(File(imagePath));
      setState(() {});
      return true;
    } else {
      debugPrint('No image selected.');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        return Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CERTIFY',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Montesserat",
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Create A Product",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "Montesserat",
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RouteWhereYouGo();
                              },
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25.r)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                            child: Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  EnvAssets.getSvgPath("Order-History"),
                                  width: 23.w,
                                  height: 23.h,
                                  // ignore: deprecated_member_use
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(.8),
                                  semanticsLabel: "Create Product",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).afmPadding(
                    EdgeInsets.only(left: 15.sp, right: 10.sp),
                  ),
                ),
                SizedBox(
                  height: 535.h,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              _pickImage().then((value) {
                                setState(() {});
                              });
                            },
                            child: Center(
                              child: Container(
                                height: 310.h,
                                width: 310.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(.2),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .primaryColor, // Change the border color as needed
                                    width: 1
                                        .sp, // Adjust the border width as needed
                                  ),
                                  borderRadius: BorderRadius.circular(15.r),
                                  shape: BoxShape.rectangle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: Image.file(
                                    File(imagePath),
                                    fit: BoxFit.fitHeight,
                                    width: 300.w,
                                    height: 300.h,
                                    frameBuilder: (
                                      BuildContext context,
                                      Widget child,
                                      int? frame,
                                      bool wasSynchronouslyLoaded,
                                    ) {
                                      if (wasSynchronouslyLoaded ||
                                          frame != null) {
                                        // Image is fully loaded
                                        return child;
                                      } else {
                                        // Show a loading indicator or placeholder while the image is loading
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      // Show a fallback widget when the image fails to load
                                      return Center(
                                        child: Icon(
                                          Icons.add_a_photo_rounded,
                                          size: 40.sp,
                                        ),
                                      );
                                    },
                                  ).afmBorderRadius(
                                    BorderRadius.only(
                                      topRight: Radius.circular(
                                        20.r,
                                      ),
                                      topLeft: Radius.circular(
                                        20.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          component1(
                            Icons.person,
                            'Name...',
                            false,
                            true,
                            context,
                            nameController,
                          ).afmPadding(
                            EdgeInsets.only(top: 10.h),
                          ),
                          component1(
                            Icons.abc,
                            'Abbreviation...',
                            false,
                            true,
                            context,
                            shortNameController,
                          ).afmPadding(
                            EdgeInsets.symmetric(vertical: 10.h),
                          ),
                          component1(
                            Icons.note,
                            'Description...',
                            false,
                            true,
                            context,
                            descriptionController,
                          ).afmPadding(
                            EdgeInsets.only(bottom: 10.h),
                          ),
                          SizedBox(
                            height: 30.h,
                            width: 200.w,
                            child: CustomButton(pageCTA: 'Create Project')
                                .afmBorderRadius(BorderRadius.circular(20.r)),
                          ).afmPadding(EdgeInsets.only(top: 10.h)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
