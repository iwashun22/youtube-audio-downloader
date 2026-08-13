# 🎵 YouTube Audio Downloader

A lightweight Bash CLI tool for downloading YouTube audio as `.opus` files
with proper music metadata.

Built for creating a small, high-quality offline music library.

## ✨ Features

- 🎧 Downloads YouTube's native Opus audio
- 📦 Outputs `.opus` files
- ⚡ Small file sizes with good audio quality
- 🚫 Avoids unnecessary audio re-encoding
- 🏷️ Automatically adds:
  - Artist
  - Title
  - Album
- 📁 Configurable output directory
- 🖥️ Simple CLI interface
- 🌈 Colorful terminal output

## 📋 Prerequisites

- macOS
- Bash
- Python 3.11+
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [FFmpeg](https://ffmpeg.org/)
- [Deno](https://deno.com/)

### Install with Homebrew

If you don't have Homebrew installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install the dependencies:

```bash
brew install python deno ffmpeg
python3 -m pip install -U yt-dlp
```

Verify everything:

```bash
python3 --version
yt-dlp --version
ffmpeg -version
ffprobe -version
deno --version
```

Give permission to `download.sh` file:

```bash
chmod a+x download.sh
```

# 🎶 Usage

```bash
./download.sh <URL> <ARTIST> <SONG> <ALBUM>
```

> `ALBUM` is optional. If omitted, it defaults to `Unknown`.
