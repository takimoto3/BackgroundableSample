import SwiftUI
import OSLog
import Backgroundable

private let logger = Logger(subsystem: "org.example.BackgroundableSample", category: "BackgroundTask")

@Observable
@BackgroundableProperty(name: "bkTaskID")
class ClassBaseViewModel {
    /// A simple logging loop.
    @MainActor
    func runLoopA() async {
        logger.info("----------")
        logger.info("[LoopA] Loop starting.")
        let startTime = Date()
        for i in 1...60 {
            let elapsedTime = Date().timeIntervalSince(startTime)
            logger.info("[T+\(String(format: "%.1f", elapsedTime))s] [LoopA] Progress: \(i)/60")
            do {
                try await Task.sleep(for: .seconds(1))
            } catch {
                logger.warning("[LoopA] Task cancelled.")
                break
            }
        }
        logger.info("[LoopA] Loop finished.")
    }

    /// Another simple logging loop (now protected by @Backgroundable).
    ///
    @Backgroundable(propertyName: "bkTaskID", expirationFunc: "cleanupBackgroundTask")
    func runLoopB() async {
        logger.info("----------")
        logger.info("[LoopB] Loop starting.")
        let startTime = Date()
        for i in 1...60 {
            let elapsedTime = Date().timeIntervalSince(startTime)
            logger.info("[T+\(String(format: "%.1f", elapsedTime))s] [LoopB] Progress: \(i)/60")
            do {
                try await Task.sleep(for: .seconds(1))
            } catch {
                logger.warning("[LoopB] Task cancelled.")
                break
            }
        }
        logger.info("[LoopB] Loop finished.")
    }
    
    func cleanupBackgroundTask() {
        logger.info(">>> Cleaning up background task.")
    }
}

struct ClassBaseView: View {
    @State private var isRunning = false
    @State private var viewModel = ClassBaseViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Background Task Test")
                .font(.title.bold())
            
            Text("Use the Console app to check logs.")
                .font(.caption)
                .foregroundColor(.secondary)

            // --- Button for UNPROTECTED Task ---
            VStack {
                Button("Run LoopA") {
                    Task {
                        guard !self.isRunning else { return }
                        self.isRunning = true
                        await viewModel.runLoopA()
                        self.isRunning = false
                    }
                }
                .buttonStyle(.bordered)
                .tint(.pink)
                .disabled(isRunning)

                Text("Unprotected Task\n(Suspended in background)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }

            // --- Button for PROTECTED Task ---
            VStack {
                Button("Run LoopB") {
                    Task {
                        guard !self.isRunning else { return }
                        self.isRunning = true
                        await viewModel.runLoopB()
                        self.isRunning = false
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .disabled(isRunning)
                
                Text("Protected by @Backgroundable\n(Continues in background)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
       }
        .padding()
    }
}
