import 'package:flutter/material.dart';
import '../models/boleto.dart';
import '../services/boleto_storage.dart';

class BoletoHistoricoScreen extends StatelessWidget {
  final int filtroIndex;

  const BoletoHistoricoScreen({super.key, required this.filtroIndex});

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
        centerTitle: true,
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
                future: carregarBoletos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final boletos = snapshot.data!;
                  final filtrados =
                      boletos.where((b) {
                        switch (filtroIndex) {
                          case 1:
                            return b.status == 'pendente';
                          case 2:
                            return b.status == 'pago';
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
}
