import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviles_2024/firebase/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conemail = TextEditingController();
  final conPwd = TextEditingController();
  final conuser = TextEditingController();
  bool isLoading = false;
  EmailAuth auth = EmailAuth();

  @override
  Widget build(BuildContext context) {
   final screenSize = MediaQuery.of(context).size;



  @override
  void initState() {
    super.initState();
    
  }


  TextFormField txtemail = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conemail,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'Usuario o Email', // Etiqueta del campo
      ),
    );

    final txtuser = TextFormField(
      keyboardType: TextInputType.text,
      controller: conuser,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person_2),
        labelText: 'nombre', // Etiqueta del campo
      ),
    );

    // Text field para la contraseña
    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.password),
        labelText: 'Contraseña', // Etiqueta del campo
      ),
    );

    final ctnCredentials = Container(
      margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0), // Añadir padding
        children: [
          txtemail,
          SizedBox(height: 16), // Espaciado entre campos
          txtuser,
          SizedBox(height: 16), // Espaciado entre campos
          txtPwd,
        ],
      ),
    );

    final btn_register = Positioned(
      bottom: 150, // Espaciado desde el fondo
      width: screenSize.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 77, 115, 252),
        ),
        onPressed: () async {
          isLoading = true;
          auth.createUser(conuser.text,conemail.text, conPwd.text).then(
            (value){
              value ? 
              setState(() {
                isLoading = false;
              }) 
              : isLoading;;
            },);
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
        }, 
        child: const Text('Registro')));
    // GIF de carga
    final gifLoading = Positioned(
      top: 50,
      child: Image.asset(
        'assets/loading.gif',
        height: 100,
      ),
    );

    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/sanic.jpg'), // Imagen de fondo
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              child: Image.asset('assets/sanic_logot.png', width: 200), // Logo
            ),
            ctnCredentials, // Contenedor con los campos de texto,
            btn_register
          ],
        ),
      ),
    );
  }
}