import 'package:app/repositories/RpNote.dart';
import 'package:app/repositories/RpUser.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/constants.dart';

import '../entities/notes/note.dart';
import '../entities/user/user.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RpNote rpNote = RpNote();
    rpNote.saveNote(Note("1", DateTime.now().millisecondsSinceEpoch));
    rpNote.saveNote(Note("2", (DateTime.now().millisecondsSinceEpoch)+100));
    rpNote.saveNote(Note("3", DateTime.now().millisecondsSinceEpoch));
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        
        child: Row(
          children: [

            Expanded( flex: 26, child: SizedBox() ),
          FutureBuilder<List<Note>>(
            future: rpNote.getNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Ошибка: ${snapshot.error}');
              } else if (snapshot.hasData) {
                print(snapshot.data?.first.information);
                return Text('a');
              } else {
                return Text('Нет данных');
              }
            },
          ),


            Expanded(
              flex: 341,
              child: Column(children: [

                // AppBar
                Expanded(
                  flex: 75, child: Center(child: Text('All in Øne', style: appBarTextStyle)),
                ),

                // список дел
                TaskListWidget(),

                // отступ
                Expanded( flex: 30, child: SizedBox() ),

                // текущая активность
                CurrentActivityWidget(),

                // кнопки активности и заметок
                ButtonsActivitiNoteWidget(),

                CreateActivityNoteWidget(),

                Expanded( flex: 34, child: SizedBox(), ),

              ],)
              ),



            Expanded( flex: 26, child: SizedBox() ),
              
          ],
          ),
        )
    );
  }
}

class CreateActivityNoteWidget extends StatelessWidget {
  const CreateActivityNoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 54,
      child: 
        Container(
          decoration: BoxDecoration(
            color: darkColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.23),
                spreadRadius: 6,
                blurRadius: 10,
              ),
            ],
          ),
    
          child: Row(children: [
            Expanded(
              flex: 48,
              child: IconButton(
                icon: SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset('icons/Mic.png')),
                onPressed: () {
                },
              ),
            ),
            const Expanded(
              flex: 239,
              child: Column(children: [
                Expanded(
                  flex: 31,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('Введите заметку', style: standartTextStyle,)),
                ),
                Expanded(
                  flex: 23,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('удерживайте для активности', style: aaa,)),
                ),
              ],),
            ),
            Expanded(
              flex: 54,
              child: IconButton(
                icon: SizedBox(
                  height: 45,
                  width: 45,
                  child: Image.asset('icons/Button.png')
                  ),
                onPressed: () {
    
                },
              ),
            ),
          ],),
        ),
    );
  }
}

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 356,
      child: Container(
    
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
    
        child: Row(children: [
        
          const Expanded( flex:19, child: SizedBox(), ),
        
          Expanded(
            flex:303,
            child: Column(children: [
        
              //дата
              const Expanded(
                flex: 56,
                child: Center(
                  child: Text('27 мая 2024', 
                  style: TextStyle(
                    color: mainColor,
                    fontFamily: 'SFUIText',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,),
                ),
              ),
              ),
        
              //список активностей
              Expanded(
                flex: 270,
                child: ListView(
                  children: const [
        
                    SizedBox(
                      height: 45,
                      child: Row(
                        children: [
                          Expanded( flex: 3, child: Text('• Сон', style: standartTextStyle)),
                          Expanded( flex: 2, child: Center(child: Text('00:00 – 08:00', style: standartgreyTextStyle)),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(
                      height: 45,
                      child: Row(
                        children: [
                          Expanded( flex: 3, child: Text('• Завтрак', style: standartTextStyle)),
                          Expanded( flex: 2, child: Center(child: Text('08:10 – 08:30', style: standartgreyTextStyle)),
                          ),
                        ],
                      ),
                    ),
        
                    ],
                ),
              ),
        
        
              // отступ
              const Expanded( flex: 30, child: SizedBox(), ),
        
            ],),
          ),
        
          const Expanded( flex:19, child: SizedBox(), ),
          
        
        ],),
      ),
    );
  }
}

class CurrentActivityWidget extends StatelessWidget {
  const CurrentActivityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 249,
      child: Container(
    
        
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
              flex: 19,
              child: SizedBox(),
            ),
            Expanded(
              flex: 303,
              child: Column(
                children: [
                  const Expanded(
                    flex: 47,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('текущая активность', style: standartgreyTextStyle,),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('12:00 – 13:00', style: standartgreyTextStyle,),
                        ),
                      ],
                    ),
                  ),
        
                  const Expanded(
                    flex: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Название активности',
                        style: standartTextStyle,
                      ),
                    ),
                  ),
        
        
                  Expanded(
                    flex: 172,
                    child: Row(
                      children: [
                        const Expanded(flex: 15, child: SizedBox()),
                        
                        Expanded(
                          flex: 272,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 272,
                                child: ListView(
                                  children: const [
                        
                                    SizedBox(
                                      height: 45,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // Выровнять по левому краю
                                        mainAxisAlignment: MainAxisAlignment.center, // Выровнять по центру по вертикали
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft, // Выровнять текст по левому краю
                                              child: Text('• Охладить комнату', style: standartgreyTextStyle),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerLeft, // Выровнять текст по левому краю
                                              child: Text('   включить кондиционер на 17 градусов', style: standartdarkTextStyle),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
    
                                    SizedBox(height: 10,),
    
                                    SizedBox(
                                      height: 45,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // Выровнять по левому краю
                                        mainAxisAlignment: MainAxisAlignment.center, // Выровнять по центру по вертикали
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: Alignment.centerLeft, // Выровнять текст по левому краю
                                              child: Text('• Выключить свет', style: standartgreyTextStyle),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerLeft, // Выровнять текст по левому краю
                                              child: Text('   надеть маску для сна, закрыть жалюзи', style: standartdarkTextStyle),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
    
    
                                    
                                    ],
                                ),
                              ),
                              const Expanded( flex: 30, child: SizedBox(), ),
                            ],
                          ),
                        ),
                        
                        const Expanded(flex: 15, child: SizedBox()),
                      ],
                    ),
                  )
    
                ],
              ),
            ),
            const Expanded(
              flex: 19,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonsActivitiNoteWidget extends StatelessWidget {
  const ButtonsActivitiNoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 50,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25.0), // Добавляем небольшой отступ слева
                child: Text('активности', style: standartTextStyle),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 25.0), // Добавляем небольшой отступ справа
                child: Text('заметки', style: standartTextStyle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
