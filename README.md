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

In macOS, there is an option to "Turn display off on power adapter *when inactive*" in System Settings → Lock Screen. However, there is **no option** to lock your computer, put it to sleep or have a Screen Saver come on after a set time when it is "active" or if there are processes/applications running in the foreground.

<img width="735" height="242" alt="Lock Screen Settings" src="https://github.com/user-attachments/assets/1aedc19a-913a-446f-b7e4-8f9ae579b498" /> <br>

In contrast, this application can be used in scenarios where you may leave your computer on for media playback (like watching a movie or listening to a music playlist), but you may expect to fall asleep and want it to be put into Sleep Mode after a set amount of time, to save power/battery.

## 💤 Application Script

The application starts a timer based on user input, and then once the time runs out, it runs the following command: `/usr/bin/pmset sleepnow` to put the device in Sleep Mode.

---

## 🖥️ System Requirements

- Supports Apple Silicon
- Supports macOS 26.0 or higher
- Memory usage is minimal (around 30MB)

---

## 📦 Installation

### Option 1: Prebuilt Release

1. Download `ForceSleep.v1.0.zip` from **Releases** or with the button below
2. Unzip the file and open the containing folder
3. Right-click the app and click "Open"
> ⚠️ If macOS shows a warning to say the app is from an unidentified developer,
> Go to System Settings → Privacy & Security → “Open Anyway”
4. After opening the app successfully, move to your Applications folder to install

[<img width="250" height="80" alt="Download_for_MAC_Badge_Black_Colour_English_600x200" src="https://github.com/user-attachments/assets/604ff369-54f3-4863-8e8b-e133b071fce6" />](https://github.com/ahmadarefin/forcesleep/releases/download/v1.0.0/Force.Sleep.v1.0.zip)

---

### Option 2: Build from Source

1. Clone the GitHub repository:
   ```bash
   git clone https://github.com/ahmadarefin/forcesleep.git
2. Sign the application in XCode using your Apple ID.
3. Build and run the application.

---

## 🤖 DISCLAIMER

The app was initially made for personal use, and was developed **using AI Large-Language Models**, including OpenAI's ChatGPT-5.3-mini. The icon was also designed with assistance from Google Gemini. The code was generated through iterative prompting, and the application has been used and tested by the project maintainer on specific hardware.

There are paid applications available like [Sleep Utility](https://apps.apple.com/us/app/sleep-utility/id1206520984) and [Sleepr](https://apps.apple.com/us/app/sleepr-app/id6465683427) which offer similar functionality to this app, but these options are rarely free-of-charge or open-source. Therefore, I felt it could be helpful to have a free FOSS option available to users. I have little coding experience, and make no promises that this will be actively maintained, but I will do my best to update and fix issues where I can and welcome contributions.

---

## 📋 LICENSE

The project is released as free and open-source software under the GNU General Public License (GPL), and is distributed without warranty; or even the implied warranty of merchantability or fitness for a particular purpose. The full license can be found in the GPL-3.0 License section of this repository, or at https://www.gnu.org/licenses.
