
import 'package:flutter/material.dart';

void main() {
  runApp(const ProductProfileApp());
}

class ProductProfileApp extends StatelessWidget {
  const ProductProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product & Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF386641),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7F2),
      ),
      home: const ProductProfilePage(),
    );
  }
}

class ProductProfilePage extends StatelessWidget {
  const ProductProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PPM Sesi 2 - Yasef Hatam (20240040010)',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF386641),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          PromoBanner(),
          SizedBox(height: 20),
          SectionTitle(title: 'Profil Mahasiswa'),
          SizedBox(height: 10),
          StudentProfileCard(
            name: 'Yasef Hatam',
            nim: '20240040010',
            studyProgram: 'Teknik Informatika / TI24C',
          ),
          SizedBox(height: 24),
          SectionTitle(title: 'Produk Pilihan'),
          SizedBox(height: 10),
          ProductCard(),
        ],
      ),
    );
  }
}

// Banner promo menggunakan Stack dan Positioned.
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      decoration: BoxDecoration(
        color: const Color(0xFF386641),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 18,
            top: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PROMO SPESIAL',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Belanja Lebih Hemat!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Produk pilihan untuk kamu.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const Positioned(
            right: 18,
            bottom: 18,
            child: Icon(
              Icons.local_offer,
              size: 48,
              color: Color(0xFFFFD166),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF283D2B),
      ),
    );
  }
}

// Kartu profil menggunakan StatelessWidget.
class StudentProfileCard extends StatelessWidget {
  final String name;
  final String nim;
  final String studyProgram;

  const StudentProfileCard({
    super.key,
    required this.name,
    required this.nim,
    required this.studyProgram,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 34,
              backgroundColor: Color(0xFFDDE9D8),
              child: Icon(
                Icons.person,
                size: 42,
                color: Color(0xFF386641),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text('NIM: $nim'),
                  Text(
                    studyProgram,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                    ],
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

// Kartu produk menggunakan StatefulWidget karena datanya berubah.
class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final String productName = 'Tumbler Eco Green';
  final String category = 'Aksesori';
  final int price = 75000;

  int quantity = 1;
  int likes = 12;
  bool isFavorite = false;

  String formatRupiah(int amount) {
    final formatted = amount.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
    return 'Rp$formatted';
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      likes += isFavorite ? 1 : -1;
    });
  }

  void changeQuantity(int amount) {
    setState(() {
      quantity += amount;

      // Jumlah produk tidak boleh kurang dari satu.
      if (quantity < 1) {
        quantity = 1;
      }
    });
  }

  void addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$productName sebanyak $quantity berhasil ditambahkan '
          'ke keranjang. Total: ${formatRupiah(price * quantity)}',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder gambar produk.
          Container(
            height: 190,
            width: double.infinity,
            color: const Color(0xFFE5EDDF),
            child: const Icon(
              Icons.shopping_bag,
              size: 90,
              color: Color(0xFF386641),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            category,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Favorite',
                      onPressed: toggleFavorite,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  formatRupiah(price),
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF386641),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$likes Like',
                  style: const TextStyle(color: Colors.black54),
                ),
                const Divider(height: 28),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Jumlah produk',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton.filledTonal(
                      tooltip: 'Kurangi jumlah',
                      onPressed: () => changeQuantity(-1),
                      icon: const Icon(Icons.remove),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton.filledTonal(
                      tooltip: 'Tambah jumlah',
                      onPressed: () => changeQuantity(1),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F5EC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Total harga',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        formatRupiah(price * quantity),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF386641),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: addToCart,
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Tambah ke Keranjang'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF386641),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
