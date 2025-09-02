import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:adm_boletos/models/boleto.dart';
import 'package:adm_boletos/services/boleto_storage.dart';
import 'package:adm_boletos/screens/boleto_historico_screen.dart';
import 'package:adm_boletos/widgets/bottom_nav_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

      void didPopNext() {
        _carregarDados();
      }
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int tabSelecionada = 1;

  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  final List<String> meses = [
    'JAN',
    'FEV',
    'MAR',
    'ABR',
    'MAI',
    'JUN',
    'JUL',
    'AGO',
    'SET',
    'OUT',
    'NOV',
    'DEZ',
  ];

  double totalPendentes = 0.0;
  double totalPagoMesAtual = 0.0;
  Map<String, double> grafico2025 = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

Future<void> _carregarDados() async {
  final todos = await carregarBoletos();
  final agora = DateTime.now();

  final pendentes = todos.where((b) => b.status == 'pendente');

  final pagosMesAtual = todos.where((b) {
    final vencStr = b.vencimento;
    if (vencStr == null || vencStr.isEmpty) return false;

    final venc = DateTime.tryParse(vencStr);
    return venc != null &&
        b.status == 'pago' &&
        venc.month == agora.month &&
        venc.year == agora.year;
  });

  final mapa = <String, double>{};
  for (var b in todos) {
    final vencStr = b.vencimento;
    if (vencStr == null || vencStr.isEmpty) continue;

    final venc = DateTime.tryParse(vencStr);
    if (venc != null && b.status == 'pago' && venc.year == 2025) {
      // Padroniza a chave para bater com a lista de meses
      final chave = DateFormat.MMM('pt_BR').format(venc).toUpperCase().substring(0, 3);

      final rawValor = b.valor ?? '0';
      final limpo = rawValor.replaceAll(RegExp(r'[^\d,]'), '').replaceAll(',', '.');
      final valor = double.tryParse(limpo) ?? 0.0;

      mapa[chave] = (mapa[chave] ?? 0.0) + valor;
    }
  }

  setState(() {
    totalPendentes = _calcularTotal(pendentes.toList());
    totalPagoMesAtual = _calcularTotal(pagosMesAtual.toList());
    grafico2025 = mapa;
  });
}


  double _calcularTotal(List<Boleto> boletos) {
    return boletos.fold(0.0, (total, b) {
      final raw = b.valor ?? '0';
      final limpo = raw.replaceAll(RegExp(r'[^\d,]'), '').replaceAll(',', '.');
      final convertido = double.tryParse(limpo) ?? 0.0;
      return total + convertido;
    });
  }

  double _maiorValorGrafico() {
    if (grafico2025.isEmpty) return 1;
    return grafico2025.values.reduce((a, b) => a > b ? a : b);
  }

  Widget _buildBotao(String label, bool ativo) {
    return Expanded(
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: ativo ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: ativo ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final ativo = tabSelecionada == index;
    return GestureDetector(
      onTap: () {
        setState(() => tabSelecionada = index);
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:
                (_, __, ___) => BoletoHistoricoScreen(filtroIndex: index),
            transitionsBuilder: (_, animation, __, child) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0.0, 1.0), // Começa de baixo
                end: Offset.zero, // Termina no centro
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              );
              _carregarDados();
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: ativo ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              ativo
                  ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ]
                  : [],
          border: Border.all(color: ativo ? Colors.white : Colors.white24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: ativo ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildBarra(String mes, double valor, double alturaMax) {
    final double altura =
        valor > 0
            ? ((valor / _maiorValorGrafico()) * alturaMax).toDouble()
            : 4.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: altura,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(mes, style: const TextStyle(fontSize: 12, color: Colors.white)),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    final List<double> valores =
        meses.map((m) => grafico2025[m] ?? 0.0).toList();

    return Scaffold(
      backgroundColor: const Color(0xff0c0b66),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff95f9c3), Color(0xff539c96), Color(0xff0c0b66)],
            stops: [0, 0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: largura * 0.06,
                  vertical: 20,
                ),
                child: ListView(
                  children: [
                    const Text(
                      'Boletos a pagar!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${totalPendentes.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildBotao('PAGAR', true),
                        const SizedBox(width: 12),
                        _buildBotao('PAGOS', false),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTab('A PAGAR', 1),
                        _buildTab('TOTAL PAGOS', 2),
                        _buildTab('VENCIDOS', 3),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total pago esse mês',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'R\$ ${totalPagoMesAtual.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          BoletoHistoricoScreen(filtroIndex: 2),
                                ),
                              );
                            },
                            child: const Text(
                              'Mais detalhes',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Seus boletos pagos de 2025',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: altura * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(
                          meses.length,
                          (i) =>
                              _buildBarra(meses[i], valores[i], altura * 0.2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class Boleto {
//   String codigo;
//   String? valor;
//   String? vencimento;
//   String? status;

//   Boleto({
//     required this.codigo,
//     this.valor,
//     this.vencimento,
//     this.status,
//   });

//   factory Boleto.fromJson(String jsonStr) {
//     final json = jsonDecode(jsonStr);
//     return Boleto(
//       codigo: json['codigo'],
//       valor: json['valor'],
//       vencimento: json['vencimento'],
//       status: json['status'],
//     );
//   }

//   String toJson() {
//     return jsonEncode({
//       'codigo': codigo,
//       'valor': valor,
//       'vencimento': vencimento,
//       'status': status,
//     });
//   }
// }

// class TesteBoletosScreen extends StatefulWidget {
//   const TesteBoletosScreen({super.key});

//   @override
//   State<TesteBoletosScreen> createState() => _TesteBoletosScreenState();
// }

// class _TesteBoletosScreenState extends State<TesteBoletosScreen> {
//   List<Boleto> boletos = [];

//   Future<void> salvarBoleto(Boleto boleto) async {
//     final prefs = await SharedPreferences.getInstance();
//     final lista = prefs.getStringList('boletos') ?? [];

//     lista.removeWhere((json) {
//       final existente = Boleto.fromJson(json);
//       return existente.codigo == boleto.codigo;
//     });

//     lista.add(boleto.toJson());
//     await prefs.setStringList('boletos', lista);
//     print('Boletos salvos: $lista');
//   }

//   Future<void> carregarBoletos() async {
//     final prefs = await SharedPreferences.getInstance();
//     final lista = prefs.getStringList('boletos') ?? [];
//     final carregados = lista.map((json) => Boleto.fromJson(json)).toList();

//     setState(() {
//       boletos = carregados;
//     });

//     print('Boletos carregados: ${boletos.map((b) => b.codigo).toList()}');
//   }

//   @override
//   void initState() {
//     super.initState();
//     carregarBoletos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Teste de Boletos')),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               final novo = Boleto(
//                 codigo: DateTime.now().millisecondsSinceEpoch.toString(),
//                 valor: '120.00',
//                 vencimento: '2025-08-25',
//                 status: 'pendente',
//               );
//               await salvarBoleto(novo);
//               await carregarBoletos();
//             },
//             child: const Text('Salvar novo boleto'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: boletos.length,
//               itemBuilder: (context, index) {
//                 final b = boletos[index];
//                 return ListTile(
//                   title: Text('Código: ${b.codigo}'),
//                   subtitle: Text('Status: ${b.status}'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
