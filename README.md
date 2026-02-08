# FUTO Hostel Reservation App

A Flutter application for the Federal University of Technology, Owerri (FUTO) hostel reservation system. This project implements the frontend design with a focus on "FUTO Green" branding and usability.

## Screens Implemented

1.  **Splash Screen** (`splash_screen.dart`)
    *   **Description**: Displays the FUTO logo on a green background with a loading animation.
    *   **Logic**: Automatically navigates to Sign In after 3 seconds.

2.  **Sign In Screen** (`sign_in_screen.dart`)
    *   **Description**: Login form with branding.
    *   **Flow**: Success -> Hostel Gallery | "Sign Up" -> Registration Screen.

3.  **Registration Screen** (`registration_screen.dart`)
    *   **Description**: Detailed student registration form (Reg No, Dept, etc.).
    *   **Flow**: Success -> Back to Sign In.

4.  **Hostel Gallery** (`hostel_gallery_screen.dart`)
    *   **Description**: Main dashboard showing available hostels in a grid layout.
    *   **Features**: Hero animations, Availability tags ("Available", "Full").
    *   **Flow**: Click Hostel -> Room Selection.

5.  **Room Selection** (`hostel_details_screen.dart`)
    *   **Description**: Displays the list of rooms for a specific hostel.
    *   **Features**: Filter chips (4-Man, 2-Man), Room cards with attributes.
    *   **Flow**: Click "Select" -> Room Showcase.

6.  **Room Showcase** (`room_detail_screen.dart`)
    *   **Description**: Detailed view of a specific room.
    *   **Features**: Image header, Amenities grid, Description, "Book Now" action.

## Project Structure

```
lib/
├── core/
│   └── theme/
│       └── app_theme.dart       # FUTO Colors & Google Fonts
├── data/
│   └── mock_data.dart           # Mock Hostels & Rooms data
├── presentation/
│   └── screens/                 # All 6 Screens
└── main.dart                    # App Entry Point
```

## How to Run

1.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

2.  **Run App**:
    It is recommended to run on **Chrome** for the fastest setup.
    ```bash
    flutter run -d chrome
    ```

3.  **Note**: This app uses `NetworkImage` to load the high-quality assets provided in the design. Ensure you have an active internet connection when running.

## Troubleshooting

*   **Stuck on "Downloading Windows tools"**:
    The first time you run on Windows, Flutter tries to download build tools (Visual Studio) which can be very large (gigabytes).
    **Fix**: Press `Ctrl+C` in the terminal to stop it, then run with `-d chrome` to use the web browser instead.

*   **Images not loading**: Check your internet connection.
