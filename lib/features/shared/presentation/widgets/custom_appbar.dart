import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              width: size.width * 0.46,
              height: 45,
              decoration: BoxDecoration(
                  color: const Color(0xffF9F9F9),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Image.asset('public/icons/Search.png', height: 16),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {},
                    child: MouseRegion(
                      cursor: MaterialStateMouseCursor.textable,
                      child: SizedBox(
                        width: (size.width * 0.45 - 120),
                        child: const Text('Buscar...',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff94979F),
                            )),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: 40,
                        child:
                            Image.asset('public/icons/params.png', height: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: const Color(0xffF9F9F9),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        'public/icons/notification.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
