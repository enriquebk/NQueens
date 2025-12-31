# N-Queens Puzzle Game

An iOS application that challenges players to solve the classic N-Queens puzzle. Place N queens on an N×N chessboard such that no two queens threaten each other.

## How to Build, Run, and Test

### Prerequisites

- Xcode 26.0 or later

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/enriquebk/NQueens.git
   cd NQueens
   ```

2. Open the project in Xcode:
   ```bash
   open NQueens.xcodeproj
   ```

### Building & Running

1. Select the `NQueens` scheme 
2. Choose your target device or simulator
3. Select Product → Build to build or Product → Run to run the game

## UI Demo

Here is a short video recording showcasing the app navigation and functionalities:

https://github.com/user-attachments/assets/84aaed41-c84e-4c93-b99a-a7e152645436

## Architecture Decisions

### MVVM-C (Model-View-ViewModel-Coordinator)

The application follows the **MVVM-C** architecture pattern, which provides clear separation of concerns and testability. This pattern extends the traditional MVVM architecture by introducing a Coordinator layer to handle navigation logic, keeping views and view models decoupled from navigation concerns.

#### How It Works

The architecture follows a unidirectional data flow pattern:

1. **User Interaction** → View captures user actions and dispatches Events to the ViewModel
2. **Event Processing** → ViewModel processes Events through a pure reducer function
3. **State Update** → The reducer returns a new State and optional Effects
4. **UI Update** → View automatically updates when observing State changes via `@Published` properties
5. **Side Effects** → Effects (like API calls, navigation, sounds) are processed separately in the ViewModel

#### Components

**ViewModels:**
- All business logic resides in view models, making them easily testable
- State is `@Published` and observed by SwiftUI views, enabling reactive UI updates
- When a UI Event is treated by the ViewModel, it uses a pure, deterministic `reduce` function that maps Events + State → (NewState, Effects). The ViewModel's state is updated with the NewState and the side Effects are processed separately from the pure state updates
- The reducer pattern ensures that state transformations are predictable and testable, as the same Event + State will always produce the same NewState + Effects
- Effects allow handling side operations (API calls, navigation triggers, sound effects) without mixing them with state logic
  
**Views:**
- Implement the screens UI
- Are purely declarative SwiftUI views that focus solely on presentation
- Observe ViewModel's state for updates.
- Dispatch user interactions as Events to the ViewModel, maintaining a unidirectional data flow
- Have no knowledge of navigation or business logic, making them highly reusable and testable

**Models:**
- Pure data structures that represent domain entities,
- No business logic in models - they are simple value types

**Coordinator (`AppCoordinatorView`):**
- Handles navigation flow between screens, abstracting navigation logic from views and view models
- Injects dependencies into view models

#### Benefits of This Architecture

1. **Separation of Concerns:** Business logic (ViewModel), UI (View), and Navigation (Coordinator) are clearly separated, making each component easier to understand and maintain and test.
2. **Scalability:** Easy to add new screens and functionalities by following the established pattern.
3. **Dependency Injection:** Services are injected through initializers, enabling easy mocking for tests and flexible service implementations
4. **Predictable State Management:** Reducer pattern ensures state changes are predictable and traceable - given the same Event and State, the result is always deterministic
5. **Testability:** Every component can be tested in isolation thanks to the separation of concerns of the architecture and the dependency injection pattern. 

### Testing
   
The App has a test coverage of 100%. The testing strategy includes three types of tests: **Unit Tests** for testing ViewModels and game logic, **Snapshot Tests** that verify the correct rendering of the views, and **XCUITest** that test the overall functionality of each screen.

**Unit Tests:**
- `GameViewModelTests.swift` - Tests game view logic and state management
- `BestTimesViewModelTests.swift` - Tests best times functionality
- `BestTimesStoreTests.swift` - Tests persistence layer
- `NQueensValidatorTests.swift` - Tests queen placement validation logic

**Snapshot Tests:**
- `GameViewSnapshotTests.swift` - Snapshot tests for game view
- `StartViewSnapshotTests.swift` - Snapshot tests for start view
- `BestTimesViewSnapshotTests.swift` - Snapshot tests for best times view
- `WinViewSnapshotTests.swift` - Snapshot tests for win view

**UI Tests (XCUITest):**
- `GameViewUITests.swift` - End-to-end tests for game interactions
- `StartViewUITests.swift` - End-to-end tests for start screen
- `BestTimesViewUITests.swift` - End-to-end tests for best times screen
- `WinViewUITests.swift` - End-to-end tests for win screen

### Design System

The app includes a reusable design system (`DesignSystem` module) with:
- Consistent colors, typography, and spacing
- Reusable components (`Card`, `NPickerView`)
- Button styles and view modifiers
- Centralized styling for easy theme updates

### Services

These are external services to the MVVM-C architecture and Design System and are always consumed by the ViewModels.

**Persistence:**
- `BestTimesStore` protocol for abstraction
- `UserDefaultsBestTimesStore` is a concrete implementation of `BestTimesStore` using the standard `UserDefaults`

**Sound Effects:**
- `SoundFxManager` protocol for abstraction
- `SystemSoundFxManager` as concrete implementation
- Mocks available for testing

## Quality Tools

The project integrates several quality assurance tools to maintain code quality and consistency:

- **SwiftLint** - Static analysis tool that enforces Swift style and conventions
- **SwiftFormat** - Automatic code formatting tool to ensure consistent code style across the codebase
- **Periphery** - Detects unused code to help maintain a clean codebase
- **Fastlane** - Helps with easy CI/CD integration

These tools help ensure:
- Consistent code style
- Detection of unused code
- Adherence to Swift best practices
- Reduced technical debt

## Project Structure

```
NQueens/
├── Architecture/          # Core architecture protocols and utilities
│   ├── Coordinator.swift
│   ├── ViewModel.swift
│   └── ViewProtocol.swift
├── Scenes/                # App screens organized by feature
│   ├── AppCoordinator/
│   ├── StartView/
│   ├── GameView/
│   ├── WinView/
│   └── BestTimes/
├── Game/                  # Game logic and validation
│   └── NQueensGame.swift
├── DesignSystem/          # Reusable UI components and styles
├── Services/              # External services (Persistence, SoundFx)
├── Resources/             # Assets, animations, localization
└── Extensions/            # Swift extensions

NQueensTests/
├── Unit Tests
├── SnapshotTests/
└── Mocks/

NQueensUITests/
└── UI Test suites
```


