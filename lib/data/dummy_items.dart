import '../models/item.dart';

const List<String> kCategories = [
  'Dompet',
  'Kunci',
  'Elektronik',
  'Kartu identitas',
  'Lainnya',
];

const String kDefaultImage = 'assets/images/default.png';

final List<Item> dummyItems = [
  Item(
    id: '1',
    name: 'Dompet kulit cokelat',
    category: 'Dompet',
    description:
        'Dompet lipat kulit cokelat dengan kancing di bagian depan. Berisi KTM dan beberapa kartu ATM.',
    location: 'Kantin Gedung Menara PLN',
    time: '5 Nov 2026, 12.30',
    contact: '0812-3456-7801',
    imagePath: 'assets/images/dompet.png',
    type: ReportType.hilang,
  ),
  Item(
    id: '2',
    name: 'Kunci motor Honda',
    category: 'Kunci',
    description: 'Kunci motor Honda. Hilang setelah kuliah sore.',
    location: 'Parkiran motor lantai dasar',
    time: '4 Nov 2026, 16.00',
    contact: '0812-3456-7802',
    imagePath:
        'https://www.hondacengkareng.com/wp-content/uploads/2020/06/KeyBlank-35121K84901.jpg',
    type: ReportType.hilang,
  ),
  Item(
    id: '3',
    name: 'Earphone nirkabel',
    category: 'Elektronik',
    description: 'Earphone nirkabel beserta casing. Hilang di ruang praktikum.',
    location: 'Ruang Lab Komputer 2',
    time: '3 Nov 2026, 10.15',
    contact: '0812-3456-7803',
    imagePath: 'https://m.media-amazon.com/images/I/610Ga5xNk8L.jpg',
    type: ReportType.hilang,
  ),
  Item(
    id: '4',
    name: 'Kartu mahasiswa',
    category: 'Kartu identitas',
    description:
        'Kartu mahasiswa yang tertinggal di meja. Pemilik dapat mengambilnya dengan menyebutkan nama dan NIM.',
    location: 'Depan perpustakaan',
    time: '5 Nov 2026, 09.00',
    contact: '0812-3456-7804',
    imagePath: 'assets/images/kartu.png',
    type: ReportType.ditemukan,
  ),
  Item(
    id: '5',
    name: 'Payung biru navy',
    category: 'Lainnya',
    description:
        'Payung panjang biru navy di bagian luar dan hitam di bagian dalam, dengan gagang hitam melengkung. Tertinggal di kursi tunggu.',
    location: 'Lobi Gedung Menara PLN',
    time: '4 Nov 2026, 17.45',
    contact: '0812-3456-7805',
    imagePath: 'assets/images/payung.png',
    type: ReportType.ditemukan,
  ),
  Item(
    id: '6',
    name: 'Flashdisk SanDisk',
    category: 'Elektronik',
    description:
        'Flashdisk SanDisk warna hitam merah, masih tertancap di komputer.',
    location: 'Lab Komputer 1',
    time: '2 Nov 2026, 13.20',
    contact: '0812-3456-7806',
    imagePath: 'assets/images/flashdisk.png',
    type: ReportType.ditemukan,
  ),
];