import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget homePageCard(Color color, IconData icon, String title,
    BuildContext context, Widget route, animation, animation2) {
  double w = MediaQuery.of(context).size.width;
  return Opacity(
    opacity: animation.value,
    child: Transform.translate(
      offset: Offset(0, animation.value),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return route;
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          height: w / 2,
          width: w / 2.4,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(.15),
                blurRadius: 99,
              ),
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(),
              Container(
                height: w / 8,
                width: w / 8,
                decoration: BoxDecoration(
                  color: color.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color.withOpacity(.6),
                ),
              ),
              Text(
                title,
                maxLines: 4,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: "Montesserat",
                  color: Colors.black.withOpacity(.5),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    ),
  );
}
