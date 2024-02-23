import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  File? _image;

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() {
        this._image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      decoration: InputDecoration(
        labelText: "Nombre",
        labelStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Ingresa un nombre';
        } else {
          return null;
        }
      },
    );

    final txtCorreo = TextFormField(
      decoration: InputDecoration(
        labelText: "Correo Electronico",
        labelStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: (value) {
        if (value != null && !EmailValidator.validate(value)) {
          return 'Ingresa un correo valido';
        } else {
          return null;
        }
      },
    );

    final txtContrasena = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Contraseña",
        labelStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Ingresa una contraseña';
        } else {
          return null;
        }
      },
    );

    final spaceHorizontal = SizedBox(
      height: 15,
    );
    final spaceGiant = SizedBox(
      height: 60,
    );

    final btnRegistro = ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {}
      },
      style: ElevatedButton.styleFrom(
        elevation: 10.0,
        textStyle:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        fixedSize: const Size(800, 60),
        backgroundColor:
            const Color.fromARGB(255, 255, 255, 255), // Cambia el color aquí
      ),
      child: const Text('Registrarse'),
    );

    final btnImagen = ElevatedButton(
      onPressed: () {
        getImage(ImageSource.gallery);
      },
      style: ElevatedButton.styleFrom(fixedSize: const Size(400, 50)),
      child: Row(
        children: [
          Icon(Icons.image_outlined),
          SizedBox(
            width: 20,
          ),
          Text('Elige una foto de la galería')
        ],
      ),
    );

    final btnCamara = ElevatedButton(
      onPressed: () {
        getImage(ImageSource.camera);
      },
      style: ElevatedButton.styleFrom(fixedSize: const Size(400, 50)),
      child: Row(
        children: [
          Icon(Icons.camera),
          SizedBox(
            width: 20,
          ),
          Text('Realiza una foto con la camara')
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    spaceHorizontal,
                    spaceHorizontal,
                    spaceHorizontal,
                    ClipOval(
                      child: _image != null
                          ? Image.file(
                              _image!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.person,
                              size: 150,
                            ),
                    ),
                    spaceHorizontal,
                    spaceHorizontal,
                    btnImagen,
                    spaceHorizontal,
                    btnCamara,
                    spaceHorizontal,
                    txtNombre,
                    spaceHorizontal,
                    txtCorreo,
                    spaceHorizontal,
                    txtContrasena,
                    spaceHorizontal,
                    spaceHorizontal,
                    spaceHorizontal,
                    btnRegistro,
                    spaceGiant
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
