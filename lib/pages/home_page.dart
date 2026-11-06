import 'package:flutter/material.dart';
import '../data/dummy_items.dart';
import '../models/item.dart';
import '../widgets/item_image.dart';
import 'detail_page.dart';
import 'form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<Item> _items = List.of(dummyItems);
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _count(ReportType type) => _items.where((i) => i.type == type).length;

  List<Item> _filtered(ReportType type) {
    final q = _query.trim().toLowerCase();
    return _items
        .where((i) => i.type == type && i.name.toLowerCase().contains(q))
        .toList();
  }

  Future<void> _openForm() async {
    final result = await Navigator.push<Item>(
      context,
      MaterialPageRoute(builder: (_) => const FormPage()),
    );
    if (result == null || !mounted) return;
    setState(() => _items.insert(0, result));
    _tabController.animateTo(result.type == ReportType.hilang ? 0 : 1);
  }

  Future<void> _openDetail(Item item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(item: item)),
    );
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Lost & Found'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Hilang (${_count(ReportType.hilang)})'),
            Tab(text: 'Ditemukan (${_count(ReportType.ditemukan)})'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Cari nama barang',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                isDense: true,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ItemList(
                  items: _filtered(ReportType.hilang),
                  onTap: _openDetail,
                ),
                _ItemList(
                  items: _filtered(ReportType.ditemukan),
                  onTap: _openDetail,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: const Text('Lapor'),
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  final List<Item> items;
  final void Function(Item) onTap;

  const _ItemList({required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Tidak ada barang yang cocok.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ItemImage(path: item.imagePath, width: 64, height: 64),
            ),
            title: Text(item.name),
            subtitle: Text('${item.category} • ${item.location}'),
            trailing: item.isReturned
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.chevron_right),
            onTap: () => onTap(item),
          ),
        );
      },
    );
  }
}