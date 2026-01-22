# PwnBase Docker Image

Docker base image for pwn/CTF challenges with pre-installed exploitation, reverse engineering, and debugging tools.

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

### Exploitation Frameworks
- **pwntools** - CTF framework and exploit development library
  - Use for: Binary exploitation, shellcode development, remote interaction
  - Python API for process interaction, tube abstraction, packing/unpacking

- **ropper** - Advanced ROP gadget finder
  - Use for: Finding ROP gadgets in binaries, bypassing ASLR
  - Supports multiple architectures and file formats

- **ROPgadget** - ROP gadget finder
  - Use for: Locating return-oriented programming gadgets
  - Alternative to ropper with different search capabilities

- **one_gadget** - One-gadget ROP resolver for libc
  - Use for: Finding single-call ROP chains that spawn a shell
  - Analyzes libc for execve("/bin/sh", ...) gadgets

### Reverse Engineering
- **Ghidra 12.0.1** - NSA's reverse engineering suite
  - Use for: Deep binary analysis, decompilation, scriptable analysis
  - Headless mode: `ghidra-headless <project> <script>`
  - Location: `/opt/ghidra`

- **PyGhidra** - Python API for Ghidra (installed via bundled distribution)
  - Use for: Automating Ghidra analysis, scripting in Python
  - Pre-installed from Ghidra's bundled PyPI packages (offline mode)
  - Import: `from ghidra.ghidra_bridge import *`

### Testing & Verification
- **pytest** - Python testing framework
  - Use for: Writing exploit tests, validating payloads, CI/CD integration
  - Run with: `pytest` or `pytest <test_file>.py`

- **pytest-json-ctrf** - CTRF test reporting for pytest
  - Use for: JSON test results output, CI/CD integration
  - Generates machine-readable test reports

### Debugging Enhancement
- **pwndbg** - Enhanced GDB for pwn
  - Use for: Dynamic analysis, heap inspection, memory visualization
  - Features: automatic context display, ROP/heap/stack analysis, syscall tracing
  - Loads automatically in GDB

### System Tools
- **Build Tools**: `build-essential` (gcc, g++, make, cmake), `nasm`
- **Python**: `python3`, `python3-pip`, `python3-dev`
- **Debugging**: `gdb`, `gdbserver`, `ltrace`, `strace`
- **Networking**: `curl`, `wget`, `netcat-openbsd`, `socat`
- **Crypto**: `openssl`
- **Utilities**: `file`, `git`, `vim`, `nano`, `unzip`
- **Java**: `openjdk-21-jdk` (version varies by Ubuntu release)

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
2. Select "Build PwnBase Docker Images (Multi-Version)"
3. Click "Run workflow"
4. Select the desired Ubuntu version

## Build Configuration

Version-specific configurations are documented in [build-config.yml](build-config.yml).
