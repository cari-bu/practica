import 'package:flutter/material.dart';
import '../registro/registro_controller.dart';
import '../registro/usuario_model.dart';

class ScreenFormulario extends StatefulWidget {
  const ScreenFormulario({super.key});

  @override
  State<ScreenFormulario> createState() => _ScreenFormularioState();
}

class _ScreenFormularioState extends State<ScreenFormulario> {
  // Controladores de campo y registro
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _registroController = RegistroController();

  void registrar() {
    if (_formKey.currentState!.validate()) {
      String nombre = _nombreController.text.trim();
      String email = _emailController.text.trim();

      // Guardar en la lista del controlador y actualizar pantalla
      setState(() {
        _registroController.agregarUsuario(nombre, email);
      });

      // Ocultar teclado / quitar foco
      FocusScope.of(context).unfocus();

      // Limpiar los campos después del registro
      _nombreController.clear();
      _emailController.clear();

      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registro exitoso: $nombre'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Usuario> listaUsuarios = RegistroController.usuarios;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Formulario de Registro'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 56,
                            color: Colors.indigo,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Crear cuenta',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _nombreController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              hintText: 'Ingresa tu nombre completo',
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Por favor ingresa tu nombre';
                              }
                              if (value.trim().length < 3) {
                                return 'El nombre debe tener al menos 3 letras';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'ejemplo@gmail.com',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Por favor ingresa tu email';
                              }
                              final emailRegex =
                                  RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(value.trim())) {
                                return 'Por favor ingresa un email válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: registrar,
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text(
                                'Registrar',
                                style: TextStyle(fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // LISTA VISUAL DE USUARIOS REGISTRADOS
                if (listaUsuarios.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Usuarios registrados (${listaUsuarios.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listaUsuarios.length,
                    itemBuilder: (context, index) {
                      final usuario = listaUsuarios[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo.shade100,
                            child: Text(
                              usuario.nombre.isNotEmpty
                                  ? usuario.nombre[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            usuario.nombre,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(usuario.email),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _registroController.eliminarUsuario(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
