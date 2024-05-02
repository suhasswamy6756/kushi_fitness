import 'package:flutter/material.dart';

class settingButtonAlt extends StatelessWidget {
  final String text;

  final void Function()? onTap;

  const settingButtonAlt({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: OutlinedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white10,
            elevation: 10,
            side: BorderSide(
                color: Colors.black12,
                width: 1.5
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black87,
                      width: 5.0,
                    ),
                  ),
                  child: Text(
                    ">",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: Colors.white),
                  ),
                ),
                style: TextButton.styleFrom(

                  padding: EdgeInsets.only(bottom: 5),

                  minimumSize: Size(48, 48),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          )
      ),
    );
  }
}
