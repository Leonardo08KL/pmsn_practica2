import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  File? _image;
  final _contrasenaController = TextEditingController();
  final _contrasenaFocusNode = FocusNode();
  bool _showPasswordRequirements = false;

  @override
  void initState() {
    super.initState();
    _contrasenaFocusNode.addListener(() {
      setState(() {
        _showPasswordRequirements = _contrasenaFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _contrasenaController.dispose();
    _contrasenaFocusNode.dispose();
    super.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
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
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingresa un nombre';
        }
        return null;
      },
    );

    final txtCorreo = TextFormField(
      decoration: InputDecoration(
        labelText: "Correo Electronico",
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: (value) {
        if (value == null || !EmailValidator.validate(value)) {
          return 'Ingresa un correo válido';
        }
        return null;
      },
    );

    final txtContrasena = TextFormField(
      controller: _contrasenaController,
      obscureText: true,
      focusNode: _contrasenaFocusNode,
      decoration: InputDecoration(
        labelText: "Contraseña",
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingresa una contraseña';
        } else if (value.length < 8) {
          return 'La contraseña debe tener al menos 8 caracteres';
        } else if (!RegExp(
                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|<>?]).+$')
            .hasMatch(value)) {
          return 'La contraseña debe incluir letras y números, combinar mayúsculas y minúsculas, y contener caracteres especiales';
        } else if (value.contains(' ')) {
          return 'La contraseña no puede contener espacios en blanco';
        }
        return null;
      },
    );

    final spaceHorizontal = SizedBox(
      height: 15,
    );

    final btnImagen = ElevatedButton(
      onPressed: () {
        _getImage(ImageSource.gallery);
      },
      child: Row(
        children: [
          Icon(Icons.image_outlined),
          SizedBox(width: 20),
          Text('Elige una foto de la galería')
        ],
      ),
    );

    final btnCamara = ElevatedButton(
      onPressed: () {
        _getImage(ImageSource.camera);
      },
      child: Row(
        children: [
          Icon(Icons.camera),
          SizedBox(width: 20),
          Text('Realiza una foto con la camara')
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                btnImagen,
                spaceHorizontal,
                btnCamara,
                spaceHorizontal,
                txtNombre,
                spaceHorizontal,
                txtCorreo,
                spaceHorizontal,
                txtContrasena,
                if (_showPasswordRequirements)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      ''' - Debe incluir letras y números.\n - Debe combinar letras mayúsculas y minúsculas.\n - La contraseña debe incluir caracteres especiales.\n - La longitud de la contraseña debe ser igual o mayor a 8 caracteres.\n - No debe tener espacios en blanco.''',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                spaceHorizontal,
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Aquí va la lógica para el registro
                    }
                  },
                  child: Text('Registrarse'),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
