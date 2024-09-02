import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final conUser = TextEditingController();
  final conPwd = TextEditingController();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {

    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person)
      ),
    );

    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: const InputDecoration(
        prefixIcon:Icon(Icons.password) 
      ),
    );

    final ctnCredentials = Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration:BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          txtUser,
          txtPwd
        ],
      ),
    );

    final btn_Login = Positioned(
      bottom: 200,
      width: MediaQuery.of(context).size.width *.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 77, 115, 252)
        ),
        onPressed: (){
          isloading = true;
          setState(() {});
          Future.delayed(
            const Duration(milliseconds: 4000)
          ).then((value) =>{
            isloading=false,
            setState(() {}),
            Navigator.pushNamed(context, "/home")
          });
        }, 
        child: const Text('validar usuario')
        ),
    );

    final gifLoading = Positioned(
      top: 50,
      child: Image.asset('assets/loading.gif',height: 100,)
      );

    return  Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/sanic.jpg'))
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              child: Image.asset('assets/sanic_logot.png',width: 200,)),
            ctnCredentials,
            btn_Login,
            isloading ? gifLoading:Container()
          ],
        ),
      ),
    );
  }
}