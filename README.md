# BackgroundableSample

This is a sample iOS application to demonstrate the usage of the `Backgroundable` Swift package.

`Backgroundable` is a Swift library that provides macros to easily allow `async` functions to continue running for a certain period even after the app has been moved to the background.

## Features

This sample app demonstrates three different ways to use the `@Backgroundable` macro:

- **Struct-based:** `ContentView.swift` shows how to use `@Backgroundable` within a SwiftUI `View` struct.
- **Class-based:** `ClassBaseView.swift` shows how to use it within an `@Observable` class, which is common in MVVM architectures.
- **Actor-based:** `ActorBaseView.swift` shows its usage within a Swift `actor`.

## How to Use

1.  Open `BackgroundableSample.xcodeproj` in Xcode.
2.  Run the app on an iOS Simulator or a physical device.
3.  Use the tabs to navigate between the Struct, Class, and Actor examples.
4.  Press the **"Run LoopA"** button to start a standard `async` task.
5.  Press the **"Run LoopB"** button to start an `async` task protected by `@Backgroundable`.
6.  While a loop is running, move the app to the background.
7.  Observe the log output in Xcode's console or the system's Console app. You will see that "LoopA" is suspended, while "LoopB" continues to run and log messages for a while.

## Dependency

This project relies on the following Swift Package:

- **[Backgroundable](https://github.com/takimoto3/Backgroundable.git)**

Refer to the official repository for more details on how the macros work.
