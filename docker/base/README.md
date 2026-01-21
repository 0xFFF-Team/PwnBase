# PwnAgent Base Pwn Image

Base Docker image for pwn challenges with common tools pre-installed.

## Version: 0.1.0

## Multi-Version Support

This image is available for multiple Ubuntu versions. Each version is optimized with appropriate Java packages and Python configurations for that Ubuntu release.

| Ubuntu Version | Tag | Java | Python | LTS |
|----------------|-----|------|--------|-----|
| 18.04 (Bionic) | `0.1.0-ubuntu18.04` | OpenJDK 11 | 3.6 | Yes |
| 20.04 (Focal) | `0.1.0-ubuntu20.04` | OpenJDK 17 | 3.8 | Yes |
| 22.04 (Jammy) | `0.1.0-ubuntu22.04` | OpenJDK 21 | 3.10 | Yes |
| 24.04 (Noble) | `0.1.0-ubuntu24.04`, `latest`, `lts` | OpenJDK 21 | 3.12 | Yes |
| 24.10 (Oracular) | `0.1.0-ubuntu24.10` | OpenJDK 21 | 3.12+ | No |
| 25.04 (Plucky) | `0.1.0-ubuntu25.04` | OpenJDK 21 | 3.13+ | No |
| 25.10 (Questing) | `0.1.0-ubuntu25.10` | OpenJDK 21 | 3.13+ | No |

## Available Images

### Version-Specific Tags
- `ghcr.io/[owner]/pwnagent-base:0.1.0-ubuntu18.04` - Ubuntu 18.04 (Bionic)
- `ghcr.io/[owner]/pwnagent-base:0.1.0-ubuntu20.04` - Ubuntu 20.04 (Focal)
- `ghcr.io/[owner]/pwnagent-base:0.1.0-ubuntu22.04` - Ubuntu 22.04 (Jammy)
- `ghcr.io/[owner]/pwnagent-base:0.1.0-ubuntu24.04` - Ubuntu 24.04 (Noble)
- `ghcr.io/[owner]/pwnagent-base:0.1.0-ubuntu24.10` - Ubuntu 24.10 (Oracular)
- `ghcr.io/[owner]/pwnagent-base:0.1.0-ubuntu25.04` - Ubuntu 25.04 (Plucky)
- `ghcr.io/[owner]/pwnagent-base:0.1.0-ubuntu25.10` - Ubuntu 25.10 (Questing)

### Convenience Tags
- `ghcr.io/[owner]/pwnagent-base:latest` - Points to Ubuntu 24.04 (latest LTS)
- `ghcr.io/[owner]/pwnagent-base:lts` - Points to Ubuntu 24.04 (latest LTS)
- `ghcr.io/[owner]/pwnagent-base:0.1.0-lts` - Points to Ubuntu 24.04

## Usage

### Using a specific Ubuntu version

In task Dockerfiles:
```dockerfile
FROM ghcr.io/[owner]/pwnagent-base:0.1.0-ubuntu24.04

# Task-specific setup...
```

Or using the latest LTS:
```dockerfile
FROM ghcr.io/[owner]/pwnagent-base:lts

# Task-specific setup...
```

### Using the default (latest)

```dockerfile
FROM ghcr.io/[owner]/pwnagent-base:latest

# Task-specific setup...
```

### Local build for a specific Ubuntu version

```bash
# Build for Ubuntu 24.04 (default)
docker build -t pwnagent/base:0.1.0-ubuntu24.04 docker/base

# Build for Ubuntu 22.04
docker build --build-arg UBUNTU_VERSION=22.04 \
             --build-arg JAVA_PACKAGE=openjdk-21-jdk \
             --build-arg USE_BREAK_SYSTEM_PACKAGES=false \
             -t pwnagent/base:0.1.0-ubuntu22.04 \
             -f docker/base/Dockerfile docker/base

# Build for Ubuntu 18.04 (older Java)
docker build --build-arg UBUNTU_VERSION=18.04 \
             --build-arg JAVA_PACKAGE=openjdk-11-jdk \
             --build-arg USE_BREAK_SYSTEM_PACKAGES=false \
             -t pwnagent/base:0.1.0-ubuntu18.04 \
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

### Ubuntu 18.04 (Bionic)
- Uses OpenJDK 11 (Java 21 not available)
- Python 3.6 (oldest supported version)
- May have compatibility issues with latest tools
- Best for reproducing legacy challenges

### Ubuntu 20.04 (Focal)
- Uses OpenJDK 17
- Python 3.8
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
docker build -t pwnagent/base:0.1.0-ubuntu24.04 docker/base
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
