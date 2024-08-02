import 'package:flutter/material.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/widgets.dart';

class ActivitiyList extends StatelessWidget {
  const ActivitiyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            const Expanded(flex: 26, child: SizedBox()),

            Expanded(
              flex: 341,
              child: Column(
                children: [
                  // AppBar
                  const Expanded(
                    flex: 75,
                    child: Center(child: Text('Активности', style: appBarTextStyle)),
                  ),

                  // GridView
                  Expanded(
                    flex: 743,
                    child: Container(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 25,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return ActivityBlockWidget();
                        },
                        itemCount: 10, // Количество элементов в вашем списке
                      ),
                    ),
                  ),

                  const Expanded(flex: 34, child: SizedBox()),
                ],
              ),
            ),

            const Expanded(flex: 26, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class ActivityBlockWidget extends StatelessWidget {
  const ActivityBlockWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: darkColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.23),
            spreadRadius: 6,
            blurRadius: 10,
          ),
        ],
      ),
      width: 190,
      height: 190,
      child: Row(
        children: [
          Expanded(
            flex: 15,
            child: SizedBox(),
          ),
          Expanded(
            flex: 130,
            child: Column(
              children: [
                Expanded(
                  flex: 18,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 30,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 107,
                        child: Text('Неутвержденная активность', style: unconfirmActivity,),
                      ),
                      Expanded(
                        flex: 30,
                        child: SizedBox(
                          height: 24,
                          child: Image.asset('icons/Pencil.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 18,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 92,
                  child: Text(
                    'Короткое описание данной активности до 5 слов',
                    style: desriptionActivity,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 15,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
