# Force Sleep

<img width="128" height="128" alt="AppIcon" src="https://github.com/user-attachments/assets/ec19fb92-08d5-497f-9bab-1739e1c14e0f" align="left"/>

**Force Sleep** is a simple, lightweight macOS utility application that allows users to put their Mac to sleep after a user-defined time. The application *ignores whether there are applications active* and forces the computer to sleep after the set time limit. It is designed to be minimal, fast, and easy to use, with a native SwiftUI interface.

---

## ⭐️ Features

- Set the sleep timer using the slider (1 minute to 4 hours)
- Quick-select time button options (15-120 minutes)
- Manual “Sleep Now” button in the top-right
- Native macOS SwiftUI interface
- Runs locally, no background services or permissions required

<img width="444" height="478" alt="Force Sleep Timer UI" src="https://github.com/user-attachments/assets/02b8c1b3-3498-4f87-9b5e-24900d067360" />

---

## 💻 Purpose of the App

In macOS, there is an option to "Turn display off on power adapter when inactive" in System Settings → Lock Screen. However, there is no option to lock your computer or put it to sleep after a set time even when it is "active."

This application can be used in scenarios where you may use your computer for media playback (like watching a movie or listening to a music playlist), but expect you fall asleep so you want the laptop to go to sleep automatically to save power/battery.

## 💤 Application Script

The application starts a timer, and then when the time runs out, it runs this command: `/usr/bin/pmset sleepnow` to put the device in sleep mode.

---

## 🖥️ System Requirements

- Supports Apple Silicon
- macOS 26.0 or later
- Memory usage is minimal (around 30MB)

---

## 📦 Installation

### Option 1: Prebuilt Release

1. Go to the **Releases** section
2. Download `ForceSleep.v1.0.zip`
3. Unzip the file
4. Open the containing folder
5. Right-click the app and click "Open"

> ⚠️ If macOS shows a warning to say the app is from an unidentified developer,
> Go to System Settings → Privacy & Security → “Open Anyway”

---

### Option 2: Build from Source

1. Clone the repository:
   ```bash
   git clone https://github.com/ahmadarefin/forcesleep.git

---

## 🤖 DISCLAIMER

The project was developed using **AI-assisted tools**, including OpenAI's ChatGPT-5.3-mini.
The icon was also created with assistance from Google Gemini. All code was generated through iterative prompting, and has been used and tested by the project maintainer. It was initially made for personal-use, but I thought it may be useful to others.

I also noticed there are paid applications like [Sleepr](https://apps.apple.com/us/app/sleepr-app/id6465683427) which offer the same functionality as this app, but do not currently support macOS Tahoe. I have little coding experience and make no promises that this will be actively maintained but I will do my best to update and fix issues where I can.

---

## 📋 LICENSE

The project is released as free and open-source software under the GNU General Public License (GPL), and is distributed without warranty. The full license can be found in the GPL-3.0 License section of this repository, or at https://www.gnu.org/licenses.
