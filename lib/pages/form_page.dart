import 'package:flutter/material.dart';
import '../data/dummy_items.dart';
import '../models/item.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();

  ReportType _type = ReportType.hilang;
  String _category = kCategories.first;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _locationCtrl.dispose();
    _timeCtrl.dispose();
    _contactCtrl.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Kolom ini wajib diisi';
    }
    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final item = Item(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameCtrl.text.trim(),
      category: _category,
      description: _descCtrl.text.trim(),
      location: _locationCtrl.text.trim(),
      time: _timeCtrl.text.trim(),
      contact: _contactCtrl.text.trim(),
      imagePath: kDefaultImage,
      type: _type,
    );
    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    final isLost = _type == ReportType.hilang;

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah laporan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Jenis laporan'),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<ReportType>(
                  segments: const [
                    ButtonSegment(
                      value: ReportType.hilang,
                      label: Text('Barang hilang'),
                      icon: Icon(Icons.search_off),
                    ),
                    ButtonSegment(
                      value: ReportType.ditemukan,
                      label: Text('Barang ditemukan'),
                      icon: Icon(Icons.inventory_2),
                    ),
                  ],
                  selected: {_type},
                  onSelectionChanged: (selection) =>
                      setState(() => _type = selection.first),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nama barang',
                  border: OutlineInputBorder(),
                ),
                validator: _required,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: kCategories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _category = value);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi ciri barang',
                  border: OutlineInputBorder(),
                ),
                validator: _required,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationCtrl,
                decoration: InputDecoration(
                  labelText: isLost ? 'Lokasi kehilangan' : 'Lokasi penemuan',
                  border: const OutlineInputBorder(),
                ),
                validator: _required,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeCtrl,
                decoration: InputDecoration(
                  labelText: isLost ? 'Waktu kehilangan' : 'Waktu penemuan',
                  hintText: 'Contoh: 6 Nov 2026, 10.30',
                  border: const OutlineInputBorder(),
                ),
                validator: _required,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Kontak pelapor',
                  hintText: 'Contoh: 0812-0000-0000',
                  border: OutlineInputBorder(),
                ),
                validator: _required,
              ),
              const SizedBox(height: 8),
              Text(
                'Laporan baru memakai gambar bawaan.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan laporan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}