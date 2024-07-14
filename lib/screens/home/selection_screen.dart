import "package:flutter/material.dart";
import 'package:helperhive/screens/auth/screens/signup.dart';
import 'package:lottie/lottie.dart';
class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
            Lottie.asset('assets/onboarding/Animation - selection.json'),
            const SizedBox(height: 15,),
            const Text('Who Are You?', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                child: Row(children: [
              ElevatedButton(
                onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignupScreen(isUser: true,)));           
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(
                                height: 100, 
                                width: 100, 
                                child: Image.asset('assets/onboarding/user.jpg')
                              ),                
                      const Text('User', style: TextStyle(fontSize: 20,color: Colors.blue),),
                    ])
                ),
              ),
              ElevatedButton(
                onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignupScreen(isUser: false,)));           
                              },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(
                                height: 100, 
                                width: 100, 
                                child: Image.asset('assets/onboarding/workers.jpg')
                              ),                
                      const Text('Worksman', style: TextStyle(fontSize: 20,color: Colors.blue),),
                    ])
                ),
              ),])),
            )
          ],
        ),
      ),
    );
  }
}