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
            backgroundColor: Colors.black12,
            elevation: 10,
            side: const BorderSide(
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
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(

                  padding: const EdgeInsets.only(bottom: 5),

                  minimumSize: const Size(48, 48),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  ">",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          )
      ),
    );
  }
}
