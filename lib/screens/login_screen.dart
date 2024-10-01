import 'package:flutter/material.dart';
import 'package:moviles_2024/onboarding/introduction_screen.dart';

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
    
    // Obtenemos las dimensiones de la pantalla
    final screenSize = MediaQuery.of(context).size;

    // Text field para el usuario
    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'Usuario o Email', // Etiqueta del campo
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

    // Contenedor para las credenciales
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
          txtUser,
          SizedBox(height: 16), // Espaciado entre campos
          txtPwd,
        ],
      ),
    );

    // Botón de inicio de sesión
    final btn_Login = Positioned(
      bottom: 100, // Espaciado desde el fondo
      width: screenSize.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 77, 115, 252),
        ),
        onPressed: () {
          setState(() {
            isloading = true; // Cambia el estado a cargando
          });
          Future.delayed(const Duration(milliseconds: 2000)).then((value) {
            setState(() {
              isloading = false; // Restablece el estado
            });
            // Navega a la pantalla de introducción después del inicio de sesión exitoso
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => IntroductionScreen()),
            );
          });
        },
        child: const Text('Validar usuario'),
      ),
    );

    // GIF de carga
    final gifLoading = Positioned(
      top: 50,
      child: Image.asset(
        'assets/loading.gif',
        height: 100,
      ),
    );

    // Scaffold con imagen de fondo y widgets apilados
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
            ctnCredentials, // Contenedor con los campos de texto
            btn_Login, // Botón de inicio de sesión
            if (isloading) gifLoading, // Mostrar GIF de carga si es necesario
          ],
        ),
      ),
    );
  }
}
