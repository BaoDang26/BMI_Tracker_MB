# BMI Tracker

BMI Tracker is a cross-platform mobile application built with Flutter that helps users monitor and manage their body mass index (BMI), weight, and daily health activities. The app provides a user-friendly interface for tracking personal health data, logging meals and workouts, and visualizing progress through statistics and charts.

## Features

- **BMI Calculation & Tracking:**  
  Calculate your BMI based on your height and weight, and monitor changes over time.
- **Weight Management:**  
  Set target weights, track your daily weight, and receive feedback on your progress.
- **Meal Logging:**  
  Record your daily meals and view nutritional information.
- **Workout & Activity Log:**  
  Log your physical activities and track calories burned.
- **Statistics & Charts:**  
  Visualize your weight and calorie history with interactive charts.
- **Personalized Feedback:**  
  Get insights and recommendations based on your BMI and health data.
- **Notifications:**  
  Stay motivated with reminders and notifications.
- **Chat & Advisor:**  
  Communicate with advisors or other users via integrated chat features.
- **ZaloPay Payment Integration:**  
  Secure payment processing for subscription packages and premium features using ZaloPay SDK.
- **Platform Support:**  
  Available for Android


## Project Structure

- `lib/` - Main source code
  - `screens/` - App screens (Home, Login, Statistics, etc.)
  - `controllers/` - State management and business logic
  - `models/` - Data models
  - `widgets/` - Reusable UI components
  - `util/` - Utility functions (including BMI and calorie calculations)
  - `assets/images/` - App images and illustrations

## Dependencies

Key packages used:
- `get` for state management and navigation
- `cometchat_chat_uikit` for chat features
- `firebase_core`, `firebase_messaging`, `firebase_storage` for cloud and notifications
- `flutter_zalopay_sdk` for ZaloPay payment integration
- `table_calendar`, `percent_indicator`, `carousel_slider`, and more for UI and functionality

See `pubspec.yaml` for the full list.

## License

This project is for educational and demonstration purposes.
