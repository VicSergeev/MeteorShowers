# MeteorShowers App Developer Manual

## Table of Contents
1. [Architecture Overview](#architecture-overview)
2. [Core Components](#core-components)
3. [Dependencies](#dependencies)
4. [File Structure](#file-structure)
5. [Key Features](#key-features)
6. [Notifications System](#notifications-system)
7. [Location Services](#location-services)
8. [UI Components](#ui-components)

## Architecture Overview

MeteorShowers is an iOS application built using UIKit that helps users track meteor showers and provides relevant astronomical data. The app follows a traditional MVC (Model-View-Controller) architecture pattern.

### Design Patterns Used
- Singleton (LocationManager, RemindersManager)
- Delegate Pattern (LocationManagerDelegate)
- Observer Pattern (NotificationCenter for updates)

## Core Components

### Models
1. **MeteorShower**
   - Properties: name, datePeak, ZHR (Zenithal Hourly Rate)
   - Used to represent individual meteor shower events

2. **LocationManager**
   - Singleton class managing device location
   - Handles location permissions and updates
   - Provides location data to TopView for calculations

3. **RemindersManager**
   - Manages local notifications for meteor shower reminders
   - Handles persistence of reminder settings
   - Methods:
     - `saveReminder(for:)`
     - `removeReminder(for:)`
     - `hasReminder(for:)`
     - `restoreAllReminders()`

4. **AstronomicalCalculations**
   - Contains moon phase calculation logic
   - Enum `MoonPhase` for different moon phases
   - Struct `MoonPhaseCalculation` for calculations

### ViewControllers

1. **MainViewController**
   - Root view controller
   - Displays list of meteor showers
   - Background color: .darkMidnight

2. **ShowerDetailViewController**
   - Shows detailed information about selected shower
   - Manages reminder functionality
   - Key UI elements:
     - Reminder bell icon
     - Peak date
     - ZHR information
     - Moon phase details

### Views

1. **TopView**
   - Custom view showing astronomical data
   - Dependencies:
     - LocationManager
     - MoonPhaseCalculation
     - SunRiseSetCalc
   - Features:
     - Sunrise/sunset times
     - Moon phase
     - Location-based calculations

2. **MeteorShowerTableViewCell**
   - Custom cell for meteor shower list
   - Background: .lightMidnight
   - Corner radius: 9pt

## Dependencies

### External Libraries
1. **Alamofire**
   - Used for network requests
   - Installation: Swift Package Manager

2. **SnapKit**
   - Auto-layout DSL
   - Used for programmatic constraints

### Frameworks
1. **UIKit**
   - Main UI framework
2. **CoreLocation**
   - Location services
3. **UserNotifications**
   - Local notifications for reminders

## File Structure

```
MeteorShowers/
├── App/
│   ├── SceneDelegate.swift
│   ├── AppDelegate.swift
│   └── Info.plist
├── ViewControllers/
│   ├── MainViewController.swift
│   └── ShowerDetailViewController.swift
├── Views/
│   ├── TopView.swift
│   └── MeteorShowerTableViewCell.swift
├── Models/
│   ├── MeteorShower.swift
│   ├── LocationManager.swift
│   └── AstronomicalCalculations.swift
├── Managers/
│   └── RemindersManager.swift
└── Assets.xcassets/
```

## Key Features

### Reminder System
- Set reminders 3 days before meteor shower peaks
- Persistent storage using UserDefaults
- Local notifications using UNUserNotificationCenter
- Visual feedback with bell icon

### Location Services
- Uses CoreLocation for user position
- Permission handling: "When In Use" authorization
- Fallback to Moscow coordinates if location unavailable
- Used for calculating:
  - Sunrise/sunset times
  - Moon phase visibility

### Astronomical Calculations
1. **Sun Calculations**
   - Sunrise/sunset times based on location
   - Uses UTC time zone to avoid conversion issues

2. **Moon Phase**
   - Calculates current moon phase
   - Shows illumination percentage
   - Updates based on current date

## UI Components

### Color Scheme
- `.darkMidnight`: Main background color
- `.lightMidnight`: Secondary background color
- `.lightMidnight1`: Navigation title color

### Typography
- Navigation title: System font, large title
- Labels: System font, 12pt, weight: thin
- Time labels: System font, 12pt, weight: thin

### Layout
- Corner radius: 12pt for main views
- Standard padding: 16pt
- Icon sizes: 24x24pt

## Notifications System

### Local Notifications
- Scheduled 3 days before peak
- Unique identifier format: "meteorShower-[name]"
- Permission requested on first reminder set
- Persisted across app restarts

### Permission Handling
```swift
NSUserNotificationUsageDescription: "We'll notify you 3 days before meteor shower peaks so you don't miss the show!"
```

## Location Services

### Permission Handling
```swift
NSLocationWhenInUseUsageDescription: "We need your location to calculate accurate sunrise and sunset times for your area."
```

### Location Updates
- Accuracy level: Best
- Updates when:
  1. App launches
  2. Returns from background
  3. Location permission granted

## Best Practices

1. **Memory Management**
   - Use weak self in closures
   - Proper deinitialization of observers
   - Cleanup of notification requests

2. **Error Handling**
   - Location fallback mechanism
   - Graceful degradation of features
   - User feedback for failures

3. **Performance**
   - Reusable cells for list
   - Efficient astronomical calculations
   - Proper threading for UI updates

4. **Code Organization**
   - Clear separation of concerns
   - Protocol-oriented design
   - Extension-based organization

## Contributing

When contributing to this project:
1. Follow the existing architecture patterns
2. Maintain consistent code style
3. Add appropriate documentation
4. Test on multiple iOS versions
5. Consider backward compatibility
