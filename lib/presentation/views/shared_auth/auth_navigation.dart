import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/views/home/home.dart';
import 'package:certify/presentation/views/login/login_screen.dart';
import 'package:certify/presentation/views/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CertifyAuthNavigator extends StatelessWidget {
  const CertifyAuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/padlock_coloured_outline.jpg",
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ],
              ).afmPadding(
                EdgeInsets.only(top: 50.h),
              ),
              Text(
                "Giving Physical Products\nA Digital Identity",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montesserat',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomButton(
                pageCTA: 'Get Certified',
                buttonOnPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
              ).afmPadding(
                EdgeInsets.only(bottom: 10.h),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      pageCTA: 'Log In',
                      color: Colors.deepPurple,
                      buttonTextColor: Colors.white,
                      buttonOnPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ).afmPadding(
                      EdgeInsets.only(bottom: 20.h, right: 10.sp),
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      pageCTA: 'Be a guest',
                      color: Colors.deepPurple,
                      buttonTextColor: Colors.white,
                      buttonOnPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CertifiedHome(),
                          ),
                        );
                      },
                    ).afmPadding(
                      EdgeInsets.only(bottom: 20.h, left: 10.sp),
                    ),
                  ),
                ],
              ).afmPadding(
                EdgeInsets.symmetric(horizontal: 20.h),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
