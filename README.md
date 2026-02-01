# Premium Fabric Showroom

A luxury fabric showroom tablet application built with Flutter, designed for interior design professionals.

## 🎯 Features

- **Interactive Fabric Catalog**: Browse through premium fabrics with advanced filtering by color, material, and pattern
- **Detailed Fabric View**: View high-resolution images and comprehensive fabric specifications
- **Furniture Selection**: Choose from various furniture items (couches, curtains) to visualize fabrics
- **Multi-Angle Visualization**: Preview selected fabrics on furniture from multiple angles
- **Tablet-First Design**: Optimized responsive UI for tablet devices

## 📱 Screenshots

*(Add screenshots here when available)*

## 🏗️ Architecture

This project follows **Clean Architecture** principles with:

- **Domain Layer**: Business entities and logic
- **Data Layer**: Models, data sources (currently using mock data)
- **Presentation Layer**: UI components and pages

## 🎨 Design

- **Color Palette**: Luxury aesthetic with off-white, beige, and gold accents
- **Typography**: Playfair Display for headers, Inter for body text (via Google Fonts)
- **Responsive**: Built with `flutter_screenutil` for tablet optimization

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.5.4 or higher)
- Dart SDK
- Chrome (for web development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/showroom.git
cd showroom
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run -d chrome
```

## 📦 Dependencies

Key packages used:
- `flutter_bloc` - State management
- `equatable` - Value equality
- `auto_route` - Navigation
- `flutter_screenutil` - Responsive design
- `google_fonts` - Typography
- `cached_network_image` - Image caching
- `smooth_page_indicator` - Page indicators
- `photo_view` - Image zoom functionality

## 🗂️ Project Structure

```
lib/
├── core/
│   ├── constants/      # App-wide constants
│   ├── errors/         # Error handling
│   ├── theme/          # App theme
│   └── widgets/        # Reusable widgets
└── features/
    ├── catalog/        # Fabric catalog feature
    ├── selection/      # Furniture selection feature
    └── preview/        # Visualization preview feature
```

## 🔮 Current Status

This is a **static UI demonstration** with mock data. The app currently:
- ✅ Displays 5 fully functional screens
- ✅ Shows 8 mock fabrics and 8 mock furniture items
- ✅ Includes filtering, navigation, and page indicators
- ❌ No backend integration (Firebase/Hive removed for demo)

## 🛠️ Future Enhancements

- [ ] Firebase integration for remote data
- [ ] Hive integration for local caching
- [ ] BLoC state management implementation
- [ ] Real fabric visualization/overlay
- [ ] User authentication
- [ ] Favorites and recent views
- [ ] PDF export of selections

## 📄 License

This project is available for educational and portfolio purposes.

## 👤 Author

**Your Name**
- GitHub: [@YOUR_USERNAME](https://github.com/YOUR_USERNAME)

## 🙏 Acknowledgments

Built with Flutter and designed for luxury interior design showrooms.
