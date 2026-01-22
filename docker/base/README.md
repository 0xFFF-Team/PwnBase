# PwnAgent Base Pwn Image

Base Docker image for pwn challenges with common tools pre-installed.

## Version: 0.1.0

## Multi-Version Support

This image is available for multiple Ubuntu versions. Each version is optimized with appropriate Java packages and Python configurations for that Ubuntu release.

| Ubuntu Version | Tag | Java | Python | LTS |
|----------------|-----|------|--------|-----|
| 20.04 (Focal) | `20.04`, `lts` | OpenJDK 17 | 3.9 | Yes |
| 22.04 (Jammy) | `22.04`, `lts` | OpenJDK 21 | 3.10 | Yes |
| 24.04 (Noble) | `24.04`, `latest`, `lts` | OpenJDK 21 | 3.12 | Yes |
| 24.10 (Oracular) | `24.10` | OpenJDK 21 | 3.12+ | No |
| 25.04 (Plucky) | `25.04` | OpenJDK 21 | 3.13+ | No |
| 25.10 (Questing) | `25.10` | OpenJDK 21 | 3.13+ | No |

## Available Images

### Version-Specific Tags
- `ghcr.io/[owner]/pwnbase:20.04` - Ubuntu 20.04 (Focal)
- `ghcr.io/[owner]/pwnbase:22.04` - Ubuntu 22.04 (Jammy)
- `ghcr.io/[owner]/pwnbase:24.04` - Ubuntu 24.04 (Noble)
- `ghcr.io/[owner]/pwnbase:24.10` - Ubuntu 24.10 (Oracular)
- `ghcr.io/[owner]/pwnbase:25.04` - Ubuntu 25.04 (Plucky)
- `ghcr.io/[owner]/pwnbase:25.10` - Ubuntu 25.10 (Questing)

### Convenience Tags
- `ghcr.io/[owner]/pwnbase:latest` - Points to Ubuntu 24.04 (latest LTS)
- `ghcr.io/[owner]/pwnbase:lts` - Points to Ubuntu 24.04 (latest LTS)

## Usage

### Using a specific Ubuntu version

In task Dockerfiles:
```dockerfile
FROM ghcr.io/[owner]/pwnbase:24.04

# Task-specific setup...
```

Or using the latest LTS:
```dockerfile
FROM ghcr.io/[owner]/pwnbase:lts

# Task-specific setup...
```

### Using the default (latest)

```dockerfile
FROM ghcr.io/[owner]/pwnbase:latest

# Task-specific setup...
```

### Local build for a specific Ubuntu version

```bash
# Build for Ubuntu 24.04 (default)
docker build -t pwnbase:24.04 docker/base

# Build for Ubuntu 22.04
docker build --build-arg UBUNTU_VERSION=22.04 \
             --build-arg JAVA_PACKAGE=openjdk-21-jdk \
             --build-arg USE_BREAK_SYSTEM_PACKAGES=false \
             -t pwnbase:22.04 \
             -f docker/base/Dockerfile docker/base

# Build for Ubuntu 20.04
docker build --build-arg UBUNTU_VERSION=20.04 \
             --build-arg JAVA_PACKAGE=openjdk-17-jdk \
             --build-arg USE_BREAK_SYSTEM_PACKAGES=false \
             -t pwnbase:20.04 \
             -f docker/base/Dockerfile docker/base
```

## Pre-installed Tools

### System Tools
- `build-essential` (gcc, g++, make, cmake)
- `python3`, `python3-pip`
- `gdb`, `gdbserver`
- `ltrace`, `strace`
- `curl`, `wget`, `netcat-openbsd`, `socat`, `unzip`
- `openssl`, `nasm`
- `file`, `git`, `vim`, `nano`
- `openjdk-21-jdk` (version varies by Ubuntu release)

### Reverse Engineering Tools
- `Ghidra` 12.0.1 - NSA's reverse engineering framework
  - Headless mode: `ghidra-headless <project> <script>`
  - GUI mode: `ghidra`
  - Location: `/opt/ghidra`

### Python Tools
- `pwntools` - CTF framework and exploit development library
- `pytest` - Testing framework
- `pytest-json-ctrf` - CTRF test reporting
- `ropper` - ROP gadget finder
- `ROPgadget` - ROP gadget finder
- `one_gadget` - One gadget ROP resolver

### GDB Plugins
- `pwndbg` - Enhanced GDB for pwn

## Version-Specific Notes

### Ubuntu 20.04 (Focal)
- Uses OpenJDK 17
- Python 3.9
- Good balance of compatibility and modern features

### Ubuntu 22.04 (Jammy)
- Uses OpenJDK 21
- Python 3.10
- Previous LTS, widely supported

### Ubuntu 24.04 (Noble)
- Uses OpenJDK 21
- Python 3.12
- Current LTS, recommended for new challenges

### Ubuntu 24.10/25.04/25.10
- Interim releases with shorter support period
- Use for testing latest features
- Not recommended for production challenges

## Building Locally

```bash
# Default build (Ubuntu 24.04)
make docker-build-base

# Or using docker directly
docker build -t pwnbase:24.04 docker/base
```

## Publishing to GitHub Container Registry

Images are automatically built and published via GitHub Actions when:
- Pushing to the main branch
- Creating a release
- Manually triggering the workflow

To manually trigger a build for a specific version:
1. Go to Actions tab in GitHub
2. Select "Build PwnAgent Base Docker Images (Multi-Version)"
3. Click "Run workflow"
4. Select the desired Ubuntu version

## Build Configuration

Version-specific configurations are documented in [build-config.yml](build-config.yml).
