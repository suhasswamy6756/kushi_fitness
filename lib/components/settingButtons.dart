import 'package:flutter/material.dart';

class settingButton extends StatelessWidget {
  final String text;

  final void Function()? onTap;

  const settingButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: OutlinedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 10,
            side: BorderSide(
              color: Colors.black12,
              width: 1.5
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
               ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  ">",
                  style: TextStyle(fontSize: 32),
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
