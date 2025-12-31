# N-Queens Puzzle Game

An iOS application that challenges players to solve the classic N-Queens puzzle. Place N queens on an N×N chessboard such that no two queens threaten each other.

## How to Build, Run, and Test

### Prerequisites

- Xcode 26.0 or later
- iOS 17.0 or later

### Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
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

### Testing

The App has a test coverage of 100%. The Project has three types of tests:

**Unit Tests:**
- `GameViewModelTests.swift` - Tests game view logic and state management
- `BestTimesViewModelTests.swift` - Tests best times functionality
- `BestTimesStoreTests.swift` - Tests persistence layer
- `NQueensValidatorTests.swift` - Tests queen placement validation logic

**Snapshot Tests:**
- `GameViewSnapshotTests.swift` - Snapshot tests for game view
- `StartViewSnapshotTests.swift` - Snapshot  tests for start view
- `BestTimesViewSnapshotTests.swift` - Snapshot tests for best times view
- `WinViewSnapshotTests.swift` - Snapshot  tests for win view

**UI Tests (XCUITest):**
- `GameViewUITests.swift` - End-to-end tests for game interactions
- `StartViewUITests.swift` - End-to-end tests for start screen
- `BestTimesViewUITests.swift` - End-to-end tests for best times screen
- `WinViewUITests.swift` - End-to-end tests for win screen

**Run all tests in Xcode:**
1. Press `Cmd + U` or select Product → Test
2. Or run a specific test by clicking the diamond icon next to the test


## Architecture Decisions

### MVVM-C (Model-View-ViewModel-Coordinator)

The application follows the **MVVM-C** architecture pattern, which provides clear separation of concerns and testability:

#### Components

**Coordinator (`AppCoordinatorView`):**
- Handles navigation flow between screens
- Manages navigation stack using SwiftUI's `NavigationStack`
- Defines all app routes as an enum (`Route`)
- Injects dependencies (e.g., `BestTimesStore`) into view models

**ViewModels:**
- Implement the `ViewModel` protocol which enforces a reducer pattern
- Use a pure, deterministic `reduce` function that maps Events + State → (NewState, Effects)
- Separate side effects (effects) from state updates
- State is `@Published` and observed by SwiftUI views
- All business logic resides in view models, making them easily testable

**Views:**
- Implement `ViewProtocol` for consistent view model integration
- Are purely declarative SwiftUI views
- Handle events by calling `viewModel.handle(_:)`
- Observe state through `@ObservedObject` or `@StateObject`

**Models:**
- Pure data structures (`GameState`, `BoardPosition`, `ValidationResult`)
- No business logic in models
- Game validation logic is in `NQueensValidator` (a stateless utility)

#### Benefits of This Architecture

1. **Testability:** ViewModels are pure functions (reducers) that can be tested without UI dependencies
2. **Separation of Concerns:** Business logic (ViewModel), UI (View), and Navigation (Coordinator) are clearly separated
3. **Scalability:** Easy to add new screens by following the established pattern
4. **Dependency Injection:** Services are injected through initializers, enabling easy mocking for tests
5. **Predictable State Management:** Reducer pattern ensures state changes are predictable and traceable

### Design System

The app includes a reusable design system (`DesignSystem` module) with:
- Consistent colors, typography, and spacing
- Reusable components (`Card`, `NPickerView`)
- Button styles and view modifiers
- Centralized styling for easy theme updates

### Services

**Persistence:**
- `BestTimesStore` protocol for abstraction
- `UserDefaultsBestTimesStore` as concrete implementation
- Easy to swap implementations (e.g., Core Data, CloudKit)

**Sound Effects:**
- `SoundFxManager` protocol for abstraction
- `SystemSoundFxManager` as concrete implementation
- Mocks available for testing

## Quality Tools

The project integrates several quality assurance tools to maintain code quality and consistency:

### SwiftLint

Static analysis tool that enforces Swift style and conventions.

### SwiftFormat

Automatic code formatting tool to ensure consistent code style across the codebase.

### Periphery

Detects unused code to help maintain a clean codebase.


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
