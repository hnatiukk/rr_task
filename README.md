# Test task

A simple Flutter authentication app using clean architecture, BLoC, and mock API simulation.  
It features login, logout, token persistence, and state-based routing with GoRouter.

## Demonstration of work
https://github.com/user-attachments/assets/bdf6088a-1c68-421a-be0c-8c1db6d8859c

## Features

- Login with email & password
- Logout
- Token storage with `flutter_secure_storage`
- State-based navigation using `GoRouter`
- Clean architecture (data, domain, presentation, core, di)
- BLoC state management
- Simulated API with `Dio` interceptors
- Form validation with live error messages
- Responsive design with `flutter_screenutil`

## Tech Stack

| Category          | Library                             |
|------------------|-------------------------------------|
| State Management  | `flutter_bloc`                       |
| Networking        | `dio` + `retrofit`                  |
| Dependency Injection | `get_it` + `injectable`           |
| Token Storage     | `flutter_secure_storage`             |
| Routing           | `go_router`                          |
| Parsing           | `freezed` + `json_serializable`      |
| Environment Config| `flutter_dotenv`                     |
| Responsiveness    | `flutter_screenutil`                 |

## Getting Started

### Installation

1. Clone the repo:

```bash
git clone https://github.com/hnatiukk/rr_task.git
cd rr_task
````

2. Install dependencies:

```bash
flutter pub get
```

3. Create a `.env` file in the project root:

```env
BASE_URL=https://mockapi.local
```

> The `BASE_URL` is required by the API layer, even though requests are intercepted.

4. Generate code for Freezed and Injectable:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running the App

Run on an emulator or physical device:

```bash
flutter run
```

### Demo Credentials

Use these for login:

```
Email: jd@test.com
Password: 123456
```

## Project Structure

```
lib/
├── core/          # utilities, constants
├── data/          # API, models, data sources, repositories
├── domain/        # entities, use cases, repositories interfaces
├── di/            # dependency injection setup
└── presentation/  # UI screens, widgets, bloc, routing
```

## Notes

* API is simulated using a `Dio` interceptor; no external backend required.
* Navigation is controlled via GoRouter with auth-based redirection.
* All BLoC events and states are located in the `presentation/bloc` folder.
