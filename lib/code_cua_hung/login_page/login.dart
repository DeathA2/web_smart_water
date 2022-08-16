import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../api/api.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool visible = true;
  String textus = '';
  String textpw ='';
  bool isHover = false;
  bool userFocus = false;
  bool passwordFocus = false;
  final TextEditingController userTxt = TextEditingController();
  final TextEditingController passwordTxt = TextEditingController();
  String? get errorUsername{
    final text = userTxt.value.text;
    if(text.isEmpty && userFocus == true){
      return 'Please enter an username';
    }
    return null;
  }
  String? get errorPassword{
    final text = passwordTxt.value.text;
    if(text.isEmpty && passwordFocus == true){
      return 'Please enter a password';
    }
    return null;
  }
  void _displayErrorMotionToast() {
    MotionToast.error(
      title: const Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('Đăng nhập thất bại'),
      animationType: AnimationType.fromBottom,
      position: MotionToastPosition.bottom,
      barrierColor: Colors.transparent,
      width: 300,
      height: 80,
      dismissable: true,
    ).show(context);
  }
  Future<bool> user() async {
    return await api.postUser(userTxt.text,passwordTxt.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 40,
        color: const Color.fromARGB(255, 44, 62, 80),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const SizedBox(
              height: 100,
            ),
            const Image(image: AssetImage('assets/img/logo.png'),height: 240,),
            Center(
              child: Column(
                children: [
                  const Text('DHC AMR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 38,
                      color: Color.fromARGB(255, 44, 62, 80),
                    ),),
                  SizedBox(
                    height: 250,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(height: 0.5,color: Colors.grey,),
                          SizedBox(
                            height: 60,
                            child: TextField(
                              onChanged: (value){
                                setState(() => {textus,userFocus = true});
                              },
                              controller: userTxt,
                              cursorHeight: 22,
                              cursorWidth: 0.5,
                              cursorColor: Colors.black,
                              // controller: usernameController,
                              textAlignVertical: const TextAlignVertical(y: 1),
                              style: const TextStyle(
                                  fontSize: 16
                              ),
                              decoration: InputDecoration(
                                  errorText: errorUsername,
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromARGB(255, 44, 62, 80), width: 1.0)
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: 'username'
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: TextField(
                              onChanged: (value){
                                setState(() =>{textpw,passwordFocus = true});
                              },
                              controller: passwordTxt,
                              cursorHeight: 22,
                              cursorWidth: 0.5,
                              obscureText: visible,
                              cursorColor: Colors.black,
                              // controller: usernameController,
                              textAlignVertical: const TextAlignVertical(y: 1),
                              style: const TextStyle(
                                  fontSize: 16
                              ),
                              decoration: InputDecoration(
                                  errorText: errorPassword,
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        visible = !visible;
                                      });
                                    },
                                    child: Icon(visible?Icons.visibility_outlined
                                        :Icons.visibility_off_outlined,color: const Color.fromARGB(255, 44, 62, 80),),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Color.fromARGB(255, 44, 62, 80), width: 1.0)
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: 'password'
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 40,
                              width: 350,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 44, 62, 80)
                                  ),
                                    backgroundColor: isHover? const Color.fromARGB(255, 44, 62, 80):Colors.white
                                ),
                                onPressed: (){
                                  user().then((value) {
                                    if(value){
                                      Future.delayed(
                                      const Duration(seconds: 0)).then((
                                      value) =>
                                      Get.offAllNamed('/list_account'));
                                    }else{
                                      _displayErrorMotionToast();
                                    }
                                  });
                                },
                                child:  Text('Login',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: isHover ?Colors.white : const Color.fromARGB(255, 44, 62, 80)
                                  ),),
                                onHover: (val){
                                  setState(() {
                                    isHover = val;
                                  });
                                },
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

