import 'package:flutter/material.dart';

class HomeMiddleWidget extends StatelessWidget{
  const HomeMiddleWidget({super.key});

  @override
  Widget build(BuildContext context) {
   return Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [
       Text(
         '인기 여행지',
         style: TextStyle(
           fontWeight: FontWeight.bold,
           fontSize: 20,
           color: Colors.black
         ),
       ),
       ElevatedButton(
           onPressed: () => {},
           style: ButtonStyle(
             backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
             elevation: WidgetStatePropertyAll(2)
           ),
           child: Text(
             '전체 여행지 보기',
             style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.w500,
               fontSize: 14
             ),
           )
       )
     ],
   );
  }
}