import 'package:adm_boletos/screens/boleto_historico_screen.dart';
import 'package:adm_boletos/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
  ];
  final List<double> valores = [800, 1200, 950, 1100, 1300, 900, 1000, 1150];
  int tabSelecionada = 1;

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              );

              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
       child: AnimatedContainer(
         duration: const Duration(milliseconds: 250),
         curve: Curves.easeOut,
         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
         decoration: BoxDecoration(
           color: ativo ? Colors.white : Colors.transparent,
           borderRadius: BorderRadius.circular(12),
           boxShadow: ativo
               ? [
                   BoxShadow(
                     color: Colors.black26,
                     blurRadius: 6,
                     offset: const Offset(0, 2),
                   ),
                 ]
               : [],
           border: Border.all(
             color: ativo ? Colors.white : Colors.white24,
           ),
         ),
         child: AnimatedDefaultTextStyle(
           duration: const Duration(milliseconds: 250),
           style: TextStyle(
      color: ativo ? Colors.black : Colors.white,
             fontWeight: FontWeight.w600,
             fontSize: 16,
           ),
           child: Text(label),
         ),
      ),
    );
  }

  Widget _buildBarra(String mes, double valor, double alturaMax) {
    final altura = (valor / 1400) * alturaMax;
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
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
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
                    const Text(
                      'R\$ 1.250,00',
                      style: TextStyle(
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
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total pago esse mês',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'R\$ 1.150,00',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
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
        selectedIndex: 0,
        onItemTapped: (index) {
          // Navegação ou ação
        },
      ),
    );
  }
}
