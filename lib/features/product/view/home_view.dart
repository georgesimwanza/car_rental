import 'package:flutter/material.dart';

// ─────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────
class CarListing {
  final String name;
  final String brand;
  final double pricePerDay;
  final int mileage;
  final String imageUrl;
  final String fuelType;
  final int seats;

  const CarListing({
    required this.name,
    required this.brand,
    required this.pricePerDay,
    required this.mileage,
    required this.imageUrl,
    required this.fuelType,
    required this.seats,
  });
}

// ─────────────────────────────────────────
// TEST DATA
// ─────────────────────────────────────────
const List<CarListing> kTestCars = [
  CarListing(
    name: 'S-Class',
    brand: 'Mercedes-Benz',
    pricePerDay: 120,
    mileage: 12400,
    imageUrl:
        'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800',
    fuelType: 'Petrol',
    seats: 5,
  ),
  CarListing(
    name: 'Model S',
    brand: 'Tesla',
    pricePerDay: 95,
    mileage: 8700,
    imageUrl: 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800',
    fuelType: 'Electric',
    seats: 5,
  ),
  CarListing(
    name: 'X5',
    brand: 'BMW',
    pricePerDay: 110,
    mileage: 21000,
    imageUrl: 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800',
    fuelType: 'Diesel',
    seats: 7,
  ),
  CarListing(
    name: 'Cayenne',
    brand: 'Porsche',
    pricePerDay: 150,
    mileage: 9300,
    imageUrl:
        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800',
    fuelType: 'Hybrid',
    seats: 5,
  ),
];

// ─────────────────────────────────────────
// HOME VIEW
// ─────────────────────────────────────────
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedFilter = 0;
  final List<String> _filters = [
    'All',
    'Petrol',
    'Diesel',
    'Electric',
    'Hybrid',
  ];

  List<CarListing> get _filteredCars {
    if (_selectedFilter == 0) return kTestCars;
    return kTestCars
        .where((c) => c.fuelType == _filters[_selectedFilter])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildFilterChips(),
          _buildResultCount(),
          Expanded(child: _buildCarList()),
        ],
      ),
    );
  }

  // ── AppBar ──────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0D0D0D),
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFE8FF00),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.directions_car,
              color: Colors.black,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Zed Cars',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // ── Hero Header ─────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: const BoxDecoration(
        color: Color(0xFF0D0D0D),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Find Your\nPerfect Ride',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${kTestCars.length} cars available near you',
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.4),
                  size: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  'Search make, model...',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.35),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Filter Chips ─────────────────────────
  Widget _buildFilterChips() {
    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: _filters.length,
        itemBuilder: (_, i) {
          final selected = _selectedFilter == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF0D0D0D) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF0D0D0D)
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                _filters[i],
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Result Count ─────────────────────────
  Widget _buildResultCount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Text(
        '${_filteredCars.length} results',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ── Car List ─────────────────────────────
  Widget _buildCarList() {
    final cars = _filteredCars;

    if (cars.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.directions_car_outlined,
              size: 54,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),
            Text(
              'No cars in this category',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemCount: cars.length,
      itemBuilder: (_, i) => CarListingCard(car: cars[i]),
    );
  }
}

// ─────────────────────────────────────────
// CAR LISTING CARD
// ─────────────────────────────────────────
class CarListingCard extends StatelessWidget {
  final CarListing car;
  const CarListingCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildImage(), _buildBody()],
      ),
    );
  }

  // ── Image ────────────────────────────────
  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Stack(
        children: [
          Image.network(
            car.imageUrl,
            height: 190,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 190,
              color: Colors.grey.shade100,
              child: const Center(
                child: Icon(Icons.directions_car, size: 60, color: Colors.grey),
              ),
            ),
          ),
          // gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.55), Colors.transparent],
                ),
              ),
            ),
          ),
          // fuel type badge  (top-left)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: _fuelColor(car.fuelType),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                car.fuelType,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          // favourite button (top-right)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.favorite_border_rounded, size: 18),
                color: Colors.black54,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                padding: EdgeInsets.zero,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Body ─────────────────────────────────
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand
          Text(
            car.brand.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          // Model name
          Text(
            car.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0D0D0D),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 14),
          // Stats row
          Row(
            children: [
              _StatChip(
                icon: Icons.speed_rounded,
                label: '${_formatMileage(car.mileage)} km',
              ),
              const SizedBox(width: 10),
              _StatChip(
                icon: Icons.event_seat_rounded,
                label: '${car.seats} seats',
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Price + Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price per day',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$${car.pricePerDay.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0D0D0D),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D0D0D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _fuelColor(String fuel) {
    switch (fuel) {
      case 'Electric':
        return const Color(0xFF2ECC71);
      case 'Hybrid':
        return const Color(0xFF3498DB);
      case 'Diesel':
        return const Color(0xFFE67E22);
      default:
        return const Color(0xFF8E44AD);
    }
  }

  String _formatMileage(int km) =>
      km >= 1000 ? '${(km / 1000).toStringAsFixed(1)}k' : '$km';
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.black54),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
