//
//  Force Sleep for macOS
//  Built & Maintained by Ahmad Arefin.
// ---------------------------------------
//  This project is released as free and open-source software under the GNU General Public License (GPL), and is distributed without warranty. The project was developed using AI Large-Language Models and tools, including GPT-5.3-mini and Sonnet 4.6. All code below was generated through iterative prompting, and has been used and tested by the project maintainer.
// ----------------------------------------
// See the GNU General Public License for more details: https://www.gnu.org/licenses/ //"

import SwiftUI
import AppKit

struct ContentView: View {
    // MARK: - State
    // MARK: - Discrete slider values (in minutes)
    let sliderValues: [Int] = [1, 5, 15, 30, 45, 60, 90, 120, 150, 180, 210, 240]

    @AppStorage("rememberLastTime") private var rememberLastTime: Bool = false
    @AppStorage("savedSliderIndex") private var savedSliderIndex: Int = 5 // defaults to 60m

    @State private var sliderIndex: Double = 5
    @State private var remainingSeconds: Int = 0
    @State private var timer: Timer? = nil
    @State private var isRunning = false

    // Manual time entry
    @State private var manualHours: Int = 0
    @State private var manualMinutes: Int = 0
    @State private var useManualTime: Bool = false

    // Error alert
    @State private var showSleepError = false
    @State private var sleepErrorMessage = ""

    var selectedMinutes: Int {
        if useManualTime {
            return (manualHours * 60) + manualMinutes
        }
        return sliderValues[Int(sliderIndex)]
    }

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
                    Text("Force Sleep")
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
                Text(formattedMinutes(selectedMinutes))
                    .font(.title2)
                    .monospacedDigit()

                // Slider or manual steppers depending on mode
                if useManualTime {
                    HStack(spacing: 16) {
                        Stepper(value: $manualHours, in: 0...23) {
                            Text("\(manualHours)h")
                                .monospacedDigit()
                                .frame(width: 36, alignment: .trailing)
                        }
                        .onChange(of: manualHours) { _, _ in
                            // If hours drops to 0, ensure minutes is at least 1
                            if manualHours == 0 && manualMinutes == 0 {
                                manualMinutes = 1
                            }
                        }
                        Stepper(value: $manualMinutes, in: (manualHours == 0 ? 1 : 0)...59) {
                            Text("\(manualMinutes)m")
                                .monospacedDigit()
                                .frame(width: 36, alignment: .trailing)
                        }
                    }
                    .transition(.opacity)
                } else {
                    VStack(spacing: 12) {
                        Slider(
                            value: $sliderIndex,
                            in: 0...Double(sliderValues.count - 1),
                            step: 1
                        )
                        .frame(width: 250)

                        HStack {
                            presetButton(15)
                            presetButton(30)
                            presetButton(60)
                            presetButton(120)
                        }
                    }
                    .transition(.opacity)
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

            // Top-left checkboxes (anchored)
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Toggle("Manual time", isOn: $useManualTime)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .toggleStyle(.checkbox)
                            .fixedSize()
                            .animation(.easeInOut(duration: 0.2), value: useManualTime)
                        Toggle("Remember last time", isOn: $rememberLastTime)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .toggleStyle(.checkbox)
                            .fixedSize()
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(12)

            // Top-right Sleep Now button (anchored)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        sleepNow()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "sleep")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Sleep Now")
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
        .alert("Failed to Sleep", isPresented: $showSleepError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(sleepErrorMessage)
        }
        .onAppear {
            if rememberLastTime {
                sliderIndex = Double(savedSliderIndex)
            }
        }
        .onChange(of: sliderIndex) { _, newValue in
            if rememberLastTime {
                savedSliderIndex = Int(newValue)
            }
        }
        .onChange(of: rememberLastTime) { _, isEnabled in
            if isEnabled {
                savedSliderIndex = Int(sliderIndex)
            }
        }
        .onChange(of: useManualTime) { _, isEnabled in
            if isEnabled && manualHours == 0 && manualMinutes == 0 {
                manualMinutes = 1
            }
        }
    }

    // MARK: - Presets
    func presetButton(_ value: Int) -> some View {
        Button("\(value)m") {
            if let index = sliderValues.firstIndex(of: value) {
                sliderIndex = Double(index)
            }
        }
        .buttonStyle(.bordered)
    }

    // MARK: - Timer Logic
    func startTimer() {
        guard selectedMinutes > 0 else { return }
        remainingSeconds = selectedMinutes * 60
        isRunning = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async {
                if self.remainingSeconds > 0 {
                    self.remainingSeconds -= 1
                } else {
                    self.cancelTimer()
                    self.sleepNow()
                }
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
        do {
            try process.run()
        } catch {
            sleepErrorMessage = error.localizedDescription
            showSleepError = true
        }
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
}
