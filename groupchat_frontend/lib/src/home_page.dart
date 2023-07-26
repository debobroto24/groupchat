import 'package:flutter/material.dart';
import 'package:groupchat_frontend/src/chat_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameCon = TextEditingController();

  // ShowModal(context) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        onPressed: () {
          dialogbox(context);
        },
        child: const Text("Enter Chat"),
      ),
    ));
  }

  Future<dynamic> dialogbox(BuildContext context) {
    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(10)),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: nameCon,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your name",
                      ),
                      validator: (value){
                        if(value == null || value.length<3) return "User must have proper name"; 
                       return null;
                      },
                    ),
                  ),
                ),
                actions: [
                  TextButton(onPressed: (){
                     if(formKey.currentState!.validate()){
                      Navigator.pop(context); 
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatPage(name:nameCon.text)));
                    }
                   
                  }, child:const Text("Enter")), 
                   TextButton(onPressed: (){
                    nameCon.clear();
                    Navigator.pop(context); 
                   }, child: const Text("Cancel", style:TextStyle(color:Colors.orangeAccent)),  )
                ],
              );
            });
  }
}
