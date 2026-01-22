# PwnBase

Multi-version Docker base images for PWN/CTF challenges with pre-installed exploitation, reverse engineering, and debugging tools.

## Overview

PwnBase provides ready-to-use Docker images for binary exploitation and CTF challenges. Each image includes a comprehensive toolkit for pwning, reverse engineering, and debugging.

## Supported Ubuntu Versions

| Version | Codename | Tag | Status |
|---------|----------|-----|--------|
| 20.04 | Focal Fossa | `20.04`, `lts` | LTS |
| 22.04 | Jammy Jellyfish | `22.04`, `lts` | LTS |
| 24.04 | Noble Numbat | `24.04`, `latest`, `lts` | LTS (Current) |
| 24.10 | Oracular Oriole | `24.10` | Interim |
| 25.04 | Plucky Porpoise | `25.04` | Interim |
| 25.10 | Questing Quokka | `25.10` | Interim |

## Quick Start

### Pull an Image

```bash
# Pull the latest LTS (Ubuntu 24.04)
docker pull ghcr.io/[owner]/pwnbase:latest

# Pull a specific Ubuntu version
docker pull ghcr.io/[owner]/pwnbase:22.04
```

### Use in Your Dockerfile

```dockerfile
FROM ghcr.io/[owner]/pwnbase:latest

# Add your challenge-specific setup
COPY challenge /app/challenge
RUN chmod +x /app/challenge

# Set up the challenge environment
WORKDIR /app

# Default command
CMD ["/app/challenge"]
```

### Interactive Shell

```bash
docker run -it --rm ghcr.io/[owner]/pwnbase:latest
```

## Pre-installed Tools

### System Tools
- **Build Tools**: `gcc`, `g++`, `make`, `cmake`, `nasm`
- **Python**: `python3`, `pip`
- **Debugging**: `gdb`, `gdbserver`, `ltrace`, `strace`
- **Networking**: `curl`, `wget`, `netcat`, `socat`
- **Utilities**: `git`, `vim`, `nano`, `file`, `openssl`

### Exploitation Frameworks
- **pwntools** - CTF framework and exploit development library
- **ropper** - ROP gadget finder
- **ROPgadget** - Alternative ROP gadget finder
- **one_gadget** - One-gadget ROP resolver for libc

### GDB Enhancement
- **pwndbg** - Enhanced GDB with pwn-specific features
  - Automatic context display
  - Memory visualization
  - ROP/heap/stack analysis

### Reverse Engineering
- **Ghidra 12.0.1** - NSA's reverse engineering framework
  - Headless mode: `ghidra-headless <project> <script>`
  - GUI mode: `ghidra`
  - Location: `/opt/ghidra`

## Project Structure

```
PwnBase/
├── docker/
│   └── base/
│       ├── Dockerfile           # Multi-version template
│       ├── VERSION              # Current image version
│       ├── build-config.yml     # Version-specific configurations
│       ├── README.md            # Detailed image documentation
│       └── pwndbg/
│           └── install.sh       # pwndbg installation script
└── .github/
    └── workflows/
        └── docker-base.yml      # CI/CD matrix build workflow
```

## Building Locally

### Build for Default Version (Ubuntu 24.04)

```bash
docker build -t pwnbase:24.04 docker/base
```

### Build for Specific Ubuntu Version

```bash
# Ubuntu 22.04
docker build \
  --build-arg UBUNTU_VERSION=22.04 \
  --build-arg JAVA_PACKAGE=openjdk-21-jdk \
  --build-arg USE_BREAK_SYSTEM_PACKAGES=false \
  -t pwnbase:22.04 \
  -f docker/base/Dockerfile docker/base

# Ubuntu 20.04
docker build \
  --build-arg UBUNTU_VERSION=20.04 \
  --build-arg JAVA_PACKAGE=openjdk-17-jdk \
  --build-arg USE_BREAK_SYSTEM_PACKAGES=false \
  -t pwnbase:20.04 \
  -f docker/base/Dockerfile docker/base
```

## CI/CD

Images are automatically built and published to GitHub Container Registry when:
- Pushing to the `main` branch
- Creating a release
- Manually triggering the workflow

### Manual Workflow Trigger

1. Go to **Actions** tab in GitHub
2. Select **"Build PwnAgent Base Docker Images (Multi-Version)"**
3. Click **"Run workflow"**
4. Select the desired Ubuntu version or build all

## Version-Specific Notes

### Ubuntu 20.04 (Focal)
- OpenJDK 17
- Python 3.9
- Good balance of compatibility and modern features

### Ubuntu 22.04 (Jammy)
- OpenJDK 21
- Python 3.10
- Previous LTS, widely supported

### Ubuntu 24.04 (Noble)
- OpenJDK 21
- Python 3.12
- Current LTS, recommended for new challenges

### Ubuntu 24.10/25.04/25.10
- Interim releases
- Use for testing latest features only

## Image Tags

### Pattern
```
ghcr.io/[owner]/pwnbase:[ubuntu_version]
```

### Examples
- `ghcr.io/[owner]/pwnbase:24.04` - Ubuntu 24.04 (also `:latest`, `:lts`)
- `ghcr.io/[owner]/pwnbase:22.04` - Ubuntu 22.04 (also `:lts`)
- `ghcr.io/[owner]/pwnbase:20.04` - Ubuntu 20.04 (also `:lts`)
- `ghcr.io/[owner]/pwnbase:24.10` - Ubuntu 24.10
- `ghcr.io/[owner]/pwnbase:25.04` - Ubuntu 25.04
- `ghcr.io/[owner]/pwnbase:25.10` - Ubuntu 25.10

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## License

This project is provided as-is for educational and CTF purposes.

## Version

Current version: **0.1.0**

See [docker/base/VERSION](docker/base/VERSION) for the current version number.
