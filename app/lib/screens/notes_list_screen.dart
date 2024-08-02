import 'package:flutter/material.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/widgets.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

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
                    child: Center(child: Text('Заметки', style: appBarTextStyle)),
                  ),

                  // GridView
                  Expanded(
                    flex: 743,
                    child: Container(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 25,
                          childAspectRatio: 3,
                        ),
                        itemBuilder: (context, index) {
                          return NoteBlockWidget();
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

class NoteBlockWidget extends StatelessWidget {
  const NoteBlockWidget({
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
      child: Row(
        children: [
          const Expanded(
            flex: 20,
            child: SizedBox()
          ),
          
    
          Expanded(
            flex: 301,
            child: Column(
              children: [

                const Expanded(
                  flex: 20,
                  child: SizedBox()
                ),
                


                 const Expanded(
                  flex: 55,
                  child: Text(
                    'Какая то заметка, которую пользователь быстро записал . . .',
                    style: desriptionActivity,
                    textAlign: TextAlign.left,
                  ),
                ),

                Expanded(
                  flex: 25,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 241,
                        child: Text('27 июля 2024 18:30', style: aaa,),
                      ),
                      Expanded(
                        flex: 25,
                        child: SizedBox(
                          height: 24,
                          child: Image.asset('icons/Pencil.png'),
                        ),
                      ),
                      Expanded(child: SizedBox(), flex: 10,),
                      Expanded(
                        flex: 25,
                        child: SizedBox(
                          height: 24,
                          child: Image.asset('icons/Arrow.png'),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(flex: 10, child: SizedBox(),)
                
              ],
            ),
          ),
          



          const Expanded(
            flex: 20,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
