import 'package:flutter/material.dart';
import '../models/boleto.dart';
import '../services/boleto_storage.dart';

class BoletoHistoricoScreen extends StatefulWidget {
  final int filtroIndex;

  const BoletoHistoricoScreen({super.key, required this.filtroIndex});

  @override
  State<BoletoHistoricoScreen> createState() => _BoletoHistoricoScreenState();
}

class _BoletoHistoricoScreenState extends State<BoletoHistoricoScreen> {
  late Future<List<Boleto>> _boletosFuture;

  @override
  void initState() {
    super.initState();
    _boletosFuture = carregarBoletos();
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'pago':
        return Colors.green;
      case 'pendente':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon(String? status) {
    switch (status) {
      case 'pago':
        return Icons.check_circle;
      case 'pendente':
        return Icons.schedule;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Histórico de Boletos'),
        backgroundColor: const Color(0xff539c96),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff95f9c3), Color(0xff539c96), Color(0xff0c0b66)],
            stops: [0, 0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: FutureBuilder<List<Boleto>>(
                future: _boletosFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final agora = DateTime.now();
                  final boletos = snapshot.data!;

                  final filtrados = boletos.where((b) {
                    if (b.vencimento == null || b.vencimento!.isEmpty) return false;
                    final vencimentoDate = DateTime.tryParse(b.vencimento!);
                    if (vencimentoDate == null) return false;

                    switch (widget.filtroIndex) {
                      case 1:
                        return b.status == 'pendente' && vencimentoDate.isAfter(agora);
                      case 2:
                        return b.status == 'pago';
                      case 3:
                        return b.status == 'pendente' && vencimentoDate.isBefore(agora);
                      default:
                        return true;
                    }
                  }).toList();

                  if (filtrados.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhum boleto salvo.',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filtrados.length,
                    itemBuilder: (context, index) {
                      final b = filtrados[index];
                      final color = _statusColor(b.status);
                      final icon = _statusIcon(b.status);

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => _buildPagamentoDialog(b),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: b.status == 'pago'
                                  ? Colors.green.shade50
                                  : Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white24,
                                child: Icon(icon, color: color),
                              ),
                              title: Text(
                                b.codigo,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text('Valor: ${b.valor ?? '---'}'),
                                  Text('Vencimento: ${b.vencimento ?? '---'}'),
                                ],
                              ),
                              trailing: Text(
                                b.status?.toUpperCase() ?? '---',
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPagamentoDialog(Boleto boleto) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Marcar como pago?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff539c96),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Confirmar pagamento'),
              onPressed: () async {
                boleto.status = 'pago';
                await salvarBoleto(boleto);

                if (!mounted) return;

                Navigator.of(context).pop();
                setState(() {
                  _boletosFuture = carregarBoletos();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
