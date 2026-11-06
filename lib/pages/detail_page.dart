import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_image.dart';

class DetailPage extends StatefulWidget {
  final Item item;

  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void _markReturned() {
    setState(() => widget.item.isReturned = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barang ditandai sudah dikembalikan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final isLost = item.type == ReportType.hilang;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail barang')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemImage(
              path: item.imagePath,
              width: double.infinity,
              height: 240,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text(isLost ? 'Barang hilang' : 'Barang ditemukan')),
                      Chip(label: Text(item.category)),
                      if (item.isReturned)
                        const Chip(label: Text('Sudah dikembalikan')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.place,
                    label: isLost ? 'Lokasi kehilangan' : 'Lokasi penemuan',
                    value: item.location,
                  ),
                  _InfoRow(
                    icon: Icons.access_time,
                    label: isLost ? 'Waktu kehilangan' : 'Waktu penemuan',
                    value: item.time,
                  ),
                  _InfoRow(
                    icon: Icons.phone,
                    label: 'Kontak pelapor',
                    value: item.contact,
                  ),
                  _InfoRow(
                    icon: Icons.description,
                    label: 'Deskripsi',
                    value: item.description,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: item.isReturned ? null : _markReturned,
                      icon: const Icon(Icons.check),
                      label: Text(
                        item.isReturned
                            ? 'Sudah dikembalikan'
                            : 'Tandai sudah dikembalikan',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}