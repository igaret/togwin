# togwin

**togwin** is a lightweight AutoHotkey script that toggles the visibility of hidden and system files in Windows Explorer using intuitive keyboard shortcuts. Inspired by Linux's dotfile conventions, it brings fast, shell-style control to the Windows desktop.

## 🔧 Features

- `Ctrl + H`: Toggle visibility of hidden files.
- `Ctrl + Win + H`: Toggle visibility of both hidden and system files.
- Context-aware: Only activates when a shell window (Explorer, Desktop, File Dialog, etc.) is focused.
- Registry-safe: Uses direct registry edits to control Explorer behavior.
- Visual feedback: Displays a tooltip showing current visibility state.

## 📦 Installation

1. Install [AutoHotkey](https://www.autohotkey.com/).
2. Clone or download this repo.
3. Run `togwin.ahk` or compile it to `.exe` for background use.

## 🖥️ Usage

Once running:

- Press `Ctrl + H` to toggle hidden files.
- Press `Ctrl + Win + H` to toggle both hidden and system files.
- Tooltip will confirm the current state.

## 🧠 How It Works

- Reads `Hidden` and `ShowSuperHidden` values from:
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
- Writes updated values based on toggle mode.
- Refreshes Explorer windows with `Ctrl + R` and `F5` to apply changes.

## 📁 Compatibility

- Windows 7 and above
- Works with Explorer, Desktop, File Dialogs, Control Panel, and Settings

## 🧪 Known Limitations

- Registry changes may not reflect instantly in all Explorer views.
- Requires Explorer to be active for hotkeys to trigger.

## 📜 License

MIT License. See [LICENSE](LICENSE) for details.

## 🙌 Credits

Crafted by [Garet](https://rslvd.net) — modular, minimalist, and built for real-world automation.
