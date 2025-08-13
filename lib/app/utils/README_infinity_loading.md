# InfinityLoadingIndicator

A beautiful Flutter widget that displays an animated loading indicator in the shape of an infinity symbol (∞) with a flowing gradient animation.

## Features

- **Smooth Animation**: Continuous flowing gradient animation along the infinity symbol path
- **Customizable**: Size, colors, and animation duration can be customized
- **Efficient**: Optimized for 60fps performance using CustomPainter
- **Modern Design**: Blue to cyan gradient with glow effects
- **Responsive**: Automatically scales to fit the provided size
- **Reusable**: Can be used anywhere in your Flutter app

## Usage

### Basic Usage

```dart
import 'package:your_app/app/utils/infinity_loading_indicator.dart';

// Default infinity loading indicator
const InfinityLoadingIndicator()
```

### Customized Usage

```dart
InfinityLoadingIndicator(
  size: 100.0, // Custom size
  primaryColor: Colors.purple, // Custom primary color
  secondaryColor: Colors.pink, // Custom secondary color
  duration: Duration(milliseconds: 2500), // Custom animation duration
)
```

### In a Loading Screen

```dart
Scaffold(
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Loading...',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const InfinityLoadingIndicator(
          size: 80.0,
          duration: Duration(milliseconds: 2000),
        ),
      ],
    ),
  ),
)
```

## Parameters

| Parameter        | Type       | Default                            | Description                               |
| ---------------- | ---------- | ---------------------------------- | ----------------------------------------- |
| `size`           | `double`   | `80.0`                             | The size of the loading indicator         |
| `primaryColor`   | `Color?`   | `Color.fromARGB(255, 4, 182, 253)` | Primary color for the gradient            |
| `secondaryColor` | `Color?`   | `Color.fromARGB(255, 0, 255, 255)` | Secondary color for the gradient          |
| `duration`       | `Duration` | `Duration(milliseconds: 2000)`     | Animation duration for one complete cycle |

## Examples

### Different Sizes

```dart
// Small indicator
InfinityLoadingIndicator(size: 40.0)

// Default size
InfinityLoadingIndicator()

// Large indicator
InfinityLoadingIndicator(size: 120.0)
```

### Different Colors

```dart
// Purple theme
InfinityLoadingIndicator(
  primaryColor: Colors.purple,
  secondaryColor: Colors.pink,
)

// Green theme
InfinityLoadingIndicator(
  primaryColor: Colors.green,
  secondaryColor: Colors.lightGreen,
)

// Orange theme
InfinityLoadingIndicator(
  primaryColor: Colors.orange,
  secondaryColor: Colors.yellow,
)
```

### Different Animation Speeds

```dart
// Fast animation
InfinityLoadingIndicator(duration: Duration(milliseconds: 1000))

// Slow animation
InfinityLoadingIndicator(duration: Duration(milliseconds: 3000))
```

## Demo

To see the widget in action, you can use the `InfinityLoadingDemo` widget:

```dart
import 'package:your_app/app/utils/infinity_loading_demo.dart';

// Navigate to the demo
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const InfinityLoadingDemo()),
);
```

## Technical Details

The widget uses:

- `CustomPainter` for efficient rendering
- `AnimationController` for smooth animations
- `LinearGradient` for the flowing effect
- `MaskFilter.blur` for glow effects
- Mathematical calculations to create the infinity symbol path

The animation creates a continuous flow effect by:

1. Drawing a background stroke with low opacity
2. Animating a gradient along the infinity symbol path
3. Adding a glow effect for visual appeal
4. Using `Curves.easeInOut` for smooth transitions

## Performance

- Optimized for 60fps performance
- Efficient repaint logic in `shouldRepaint`
- Minimal memory usage
- Smooth animations on all devices

## Integration

The widget is designed to integrate seamlessly with your existing Flutter app:

- Uses your app's color scheme by default
- Follows Material Design principles
- Responsive and adaptive
- Easy to customize and extend
