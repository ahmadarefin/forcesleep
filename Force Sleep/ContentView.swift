//
//  Force Sleep for macOS
//  Built & Maintained by Ahmad Arefin.
// ---------------------------------------
//  This project is released as free and open-source software under the GNU General Public License (GPL), and is distributed without warranty. The project was developed using AI-assisted tools, including GPT-5.3-mini. All code below was generated through iterative prompting, and has been used and tested by the project maintainer.
// ----------------------------------------
// See the GNU General Public License for more details: https://www.gnu.org/licenses/ //"

import SwiftUI
import UserNotifications
import AppKit

struct ContentView: View {

    // MARK: - State
    @State private var minutes: Double = 60
    @State private var remainingSeconds: Int = 0
    @State private var timer: Timer? = nil
    @State private var isRunning = false

    var body: some View {
        ZStack {

            // Main content
            VStack(spacing: 20) {

                // Header
                VStack(spacing: 12) {
                    Image(.appLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .opacity(0.9)

                    Text("Force Sleep Timer")
                        .font(.largeTitle)
                        .fontWeight(.semibold)

                    Text("Set a timer to put your Mac to Sleep after the inputted amount of time.")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: false)
                        .frame(maxWidth: 280)
                }

                // Time display
                Text(formattedMinutes(Int(minutes)))
                    .font(.title2)
                    .monospacedDigit()

                // Slider
                Slider(
                    value: Binding(
                        get: {
                            Double(nearestSliderValue(Int(minutes)))
                        },
                        set: { newValue in
                            minutes = Double(nearestSliderValue(Int(newValue)))
                        }
                    ),
                    in: 1...240
                )
                .frame(width: 250)

                // Presets
                HStack {
                    presetButton(15)
                    presetButton(30)
                    presetButton(60)
                    presetButton(120)
                }

                // Countdown
                if isRunning {
                    Text("Sleeping in \(formatTime(remainingSeconds))")
                        .font(.headline)
                        .monospacedDigit()
                }

                // Controls
                HStack {
                    Button("Start") {
                        startTimer()
                    }
                    .disabled(isRunning)

                    Button("Cancel") {
                        cancelTimer()
                    }
                    .disabled(!isRunning)
                }
            }
            .padding(30)

            // Top-right Sleep button (anchored)
            VStack {
                HStack {
                    Spacer()

                    Button(action: {
                        sleepNow()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "sleep")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Sleep")
                                .font(.system(size: 15, weight: .medium))
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                    }
                    .buttonStyle(.borderless)
                    .help("Put Mac to Sleep")
                }
                Spacer()
            }
            .padding(12)
        }
        .onAppear {
            requestNotificationPermission()
        }
    }

    // MARK: - Presets
    func presetButton(_ value: Int) -> some View {
        Button("\(value)m") {
            minutes = Double(value)
        }
        .buttonStyle(.bordered)
    }

    // MARK: - Timer Logic
    func startTimer() {
        remainingSeconds = Int(minutes) * 60
        isRunning = true

        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                cancelTimer()
                notifyAndSleep()
            }
        }
    }

    func cancelTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    // MARK: - Sleep
    func sleepNow() {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/sh")
        process.arguments = ["-c", "/usr/bin/pmset sleepnow"]

        try? process.run()
    }

    func notifyAndSleep() {
        sendNotification()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sleepNow()
        }
    }

    // MARK: - Notifications
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Sleep Timer"
        content.body = "Your Mac is going to sleep now."

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request)
    }

    // MARK: - Helpers
    func formatTime(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", mins, secs)
    }

    func formattedMinutes(_ mins: Int) -> String {
        let h = mins / 60
        let m = mins % 60

        if h > 0 && m > 0 { return "\(h)h \(m)m" }
        if h > 0 { return "\(h)h" }
        return "\(m)m"
    }
    
    func nearestSliderValue(_ value: Int) -> Int {
        let sliderValues: [Int] = [
            1, 5, 15, 30, 45, 60,
            90, 120, 150, 180, 240
        ]

        return sliderValues.min(by: {
            abs($0 - value) < abs($1 - value)
        }) ?? value
    }
}
