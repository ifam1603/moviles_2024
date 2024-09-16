import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  final String _fullName = 'Antonio Rodriguez';
  final String _email = 'luis_antonio1603@hotmail.com';
  final String _phoneNumber = '+4613200738';
  final String _githubUrl = 'https://github.com/ifam1603';

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Función para abrir correo, teléfono o GitHub
  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileImage(),
            const SizedBox(height: 20),
            _buildInfoSection(),
            const SizedBox(height: 20),
            _buildContactSection(),
            const SizedBox(height: 20),
            _buildGitHubSection(),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(235, 76, 119, 211),
    );
  }

  // Widget para mostrar y seleccionar la imagen de perfil
  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: _image == null
                ? AssetImage('assets/default_profile.png')
                : FileImage(_image!) as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.camera_alt, color: Colors.blue, size: 30),
              onPressed: () {
                _showImagePickerOptions();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget para la sección de información personal
  Widget _buildInfoSection() {
    return Card(
      elevation: 5,
      child: Container(
        color: const Color.fromARGB(197, 240, 99, 89),
        child: ListTile(
          title: Text(
            _fullName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Estudiante de Ingenieria '),
          leading: Icon(Icons.person, color: Colors.blueAccent, size: 40),
        ),
      ),
    );
  }

  // Widget para la sección de contacto (Correo y Teléfono)
  Widget _buildContactSection() {
    return Card(
      elevation: 5,
      child: Container(
        color: const Color.fromARGB(197, 240, 99, 89),
        child: Column(
          children: [
            ListTile(
              title: Text('Correo electrónico'),
              subtitle: Text(_email),
              leading: Icon(Icons.email, color: Colors.blueAccent),
              onTap: () => _launchURL('mailto:$_email'),
            ),
            Divider(),
            ListTile(
              title: Text('Número de teléfono'),
              subtitle: Text(_phoneNumber),
              leading: Icon(Icons.phone, color: Colors.blueAccent),
              onTap: () => _launchURL('tel:$_phoneNumber'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para la sección de GitHub
  Widget _buildGitHubSection() {
    return Card(
      elevation: 5,
      child: Container(
        color: const Color.fromARGB(197, 240, 99, 89),
        child: ListTile(
          title: Text('GitHub'),
          subtitle: Text(_githubUrl),
          leading: Image.asset('assets/github.png'),
          onTap: () => _launchURL(_githubUrl),
        ),
      ),
    );
  }

  // Método para mostrar opciones de selección de imagen (cámara o galería)
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            color: const Color.fromARGB(197, 240, 99, 89) ,
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Cámara'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Galería'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
