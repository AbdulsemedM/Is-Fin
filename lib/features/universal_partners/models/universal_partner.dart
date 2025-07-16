class UniversalPartner {
  final String id;
  final String name;
  final String phoneNumber;
  final double rating;
  final String sector;
  final String address;
  final bool isAdded;
  final int totalRatings;

  const UniversalPartner({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.rating,
    required this.sector,
    required this.address,
    required this.isAdded,
    required this.totalRatings,
  });

  // Dummy data for testing
  static List<UniversalPartner> getDummyPartners() {
    return [
      const UniversalPartner(
        id: '1',
        name: 'Abdu Trading PLC',
        phoneNumber: '+251 911 234 567',
        rating: 4.8,
        sector: 'Agriculture',
        address: 'Bole, Addis Ababa',
        isAdded: true,
        totalRatings: 128,
      ),
      const UniversalPartner(
        id: '2',
        name: 'Khalid Import Export',
        phoneNumber: '+251 922 345 678',
        rating: 4.5,
        sector: 'Manufacturing',
        address: 'Kirkos, Addis Ababa',
        isAdded: false,
        totalRatings: 89,
      ),
      const UniversalPartner(
        id: '3',
        name: 'Hamza Construction',
        phoneNumber: '+251 933 456 789',
        rating: 4.9,
        sector: 'Construction',
        address: 'Megenagna, Addis Ababa',
        isAdded: true,
        totalRatings: 256,
      ),
      const UniversalPartner(
        id: '4',
        name: 'Teyba Technology Solutions',
        phoneNumber: '+251 944 567 890',
        rating: 4.7,
        sector: 'Technology',
        address: 'Kazanchis, Addis Ababa',
        isAdded: false,
        totalRatings: 167,
      ),
      const UniversalPartner(
        id: '5',
        name: 'Sumeya Transport',
        phoneNumber: '+251 955 678 901',
        rating: 4.6,
        sector: 'Transportation',
        address: 'Piassa, Addis Ababa',
        isAdded: true,
        totalRatings: 145,
      ),
      const UniversalPartner(
        id: '6',
        name: 'Meryem Food Processing',
        phoneNumber: '+251 966 789 012',
        rating: 4.4,
        sector: 'Food Processing',
        address: 'CMC, Addis Ababa',
        isAdded: false,
        totalRatings: 98,
      ),
    ];
  }
}
