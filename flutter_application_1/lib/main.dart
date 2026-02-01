import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Actividad Flutter',
      debugShowCheckedModeBanner: false,
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final String _tituloOriginal = 'Actividad Integradora 1';
  final String _textoOriginal = 'Bienvenido a mi proyecto Flutter';
  final Color _colorOriginal = Colors.deepPurple;

  final String _tituloAlterno = 'Pantalla Principal';
  final String _textoAlterno = 'Autor: Marcos Meza';
  final Color _colorAlterno = Colors.green;

  late String _tituloApp;
  late String _textoPrincipal;
  late Color _colorAppBar;

  bool _tituloCambiado = false;
  bool _textoCambiado = false;
  bool _colorCambiado = false;

  int _pasoActual = 0;

  @override
  void initState() {
    super.initState();
    _tituloApp = _tituloOriginal;
    _textoPrincipal = _textoOriginal;
    _colorAppBar = _colorOriginal;
  }

void _mostrarSnackBar(String mensaje) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar(); // evita acumulación
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensaje),
      duration: const Duration(seconds: 2),
    ),
  );
}

void _toggleTitulo() {
  setState(() {
    _tituloCambiado = !_tituloCambiado;
    _tituloApp = _tituloCambiado ? _tituloAlterno : _tituloOriginal;
  });

  _mostrarSnackBar(
    _tituloCambiado ? 'Pantalla' : 'Actividad',
  );
}

void _toggleColor() {
  setState(() {
    _colorCambiado = !_colorCambiado;
    _colorAppBar = _colorCambiado ? _colorAlterno : _colorOriginal;
  });

  _mostrarSnackBar(
    _colorCambiado
        ? 'Color del AppBar cambiado a verde'
        : 'Color del AppBar cambiado a lila',
  );
}

void _toggleTexto() {
  setState(() {
    _textoCambiado = !_textoCambiado;
    _textoPrincipal = _textoCambiado ? _textoAlterno : _textoOriginal;
  });

  _mostrarSnackBar(
    _textoCambiado
        ? 'Autor'
        : 'Proyecto',
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloApp),
        backgroundColor: _colorAppBar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              _textoPrincipal,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: _toggleTitulo,
                  child: Text(_tituloCambiado ? 'Restaurar título' : 'Cambiar título'),
                ),
                ElevatedButton(
                  onPressed: _toggleColor,
                  child: Text(_colorCambiado ? 'Restaurar color' : 'Cambiar color AppBar'),
                ),
                ElevatedButton(
                  onPressed: _toggleTexto,
                  child: Text(_textoCambiado ? 'Restaurar texto' : 'Cambiar texto'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Stepper(
                currentStep: _pasoActual,
                onStepContinue: () {
                  if (_pasoActual < 2) setState(() => _pasoActual++);
                },
                onStepCancel: () {
                  if (_pasoActual > 0) setState(() => _pasoActual--);
                },
                steps: const [
                  Step(title: Text('Paso 1'), content: Text('Proyecto creado'), isActive: true),
                  Step(title: Text('Paso 2'), content: Text('Interfaz modificada'), isActive: true),
                  Step(title: Text('Paso 3'), content: Text('Navegación y SnackBar'), isActive: true),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Este es un SnackBar')),
                );
              },
              child: const Text('Mostrar SnackBar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SegundaPantalla()),
                );
              },
              child: const Text('Ir a Segunda Pantalla'),
            ),
          ],
        ),
      ),
    );
  }

}

class SegundaPantalla extends StatelessWidget {
  const SegundaPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Pantalla'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Esta es la segunda pantalla', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}
