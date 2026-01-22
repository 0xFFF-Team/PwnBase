# PwnAgent Base Pwn Image
# Version: 0.1.0
# Supports: Ubuntu 20.04, 22.04, 24.04, 24.10, 25.04, 25.10

ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

# Build arguments for version-specific configuration
ARG UBUNTU_VERSION
ARG JAVA_PACKAGE=openjdk-21-jdk
ARG USE_BREAK_SYSTEM_PACKAGES=true

# Install Python 3.9 on Ubuntu 20.04 (required for pytest-json-ctrf)
RUN if [ "${UBUNTU_VERSION}" = "20.04" ]; then \
        apt-get update && \
        apt-get install -y software-properties-common && \
        add-apt-repository -y ppa:deadsnakes/ppa && \
        apt-get update && \
        apt-get install -y python3.9 python3.9-dev python3.9-venv && \
        update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1; \
    fi

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PWNDBG_NO_AUTOUPDATE=1

# Label with Ubuntu version
LABEL ubuntu.version=${UBUNTU_VERSION}

# Install system dependencies and common pwn tools
RUN apt-get update && apt-get install -y \
    # Build tools
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    # Python and pip
    python3 \
    python3-pip \
    python3-dev \
    # Debugging tools
    gdb \
    gdbserver \
    ltrace \
    strace \
    # Network tools
    curl \
    wget \
    netcat-openbsd \
    socat \
    unzip \
    # Crypto and analysis tools
    openssl \
    nasm \
    # Java (required for Ghidra, version varies by Ubuntu version)
    ${JAVA_PACKAGE} \
    # Other utilities
    file \
    git \
    vim \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME based on installed Java version
RUN if [ "${UBUNTU_VERSION}" = "20.04" ]; then \
        echo "JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> /etc/environment; \
    else \
        echo "JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64" >> /etc/environment; \
    fi

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Install Python packages with version-aware flag handling
RUN if [ "${USE_BREAK_SYSTEM_PACKAGES}" = "true" ]; then \
        python3 -m pip install --no-cache-dir --break-system-packages \
            pwntools \
            pytest \
            pytest-json-ctrf \
            ropper \
            ROPgadget \
            one_gadget; \
    else \
        python3 -m pip install --no-cache-dir \
            pwntools \
            pytest \
            pytest-json-ctrf \
            ropper \
            ROPgadget \
            one_gadget; \
    fi

# Install pwndbg (GDB plugin)
COPY pwndbg/install.sh /tmp/pwndbg_install.sh
RUN bash /tmp/pwndbg_install.sh && rm /tmp/pwndbg_install.sh

# Install Ghidra (NSA reverse engineering framework)
ENV GHIDRA_VERSION=12.0.1
ENV GHIDRA_DIR=/opt/ghidra
RUN cd /tmp && \
    wget -q https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${GHIDRA_VERSION}_build/ghidra_${GHIDRA_VERSION}_PUBLIC_20260114.zip && \
    unzip -q ghidra_${GHIDRA_VERSION}_PUBLIC_*.zip -d /opt && \
    mv /opt/ghidra_${GHIDRA_VERSION}_PUBLIC ${GHIDRA_DIR} && \
    rm /tmp/ghidra_${GHIDRA_VERSION}_PUBLIC_*.zip && \
    ln -s ${GHIDRA_DIR}/support/analyzeHeadless /usr/local/bin/ghidra-headless && \
    ln -s ${GHIDRA_DIR}/ghidraRun /usr/local/bin/ghidra

# Set GHIDRA_INSTALL_DIR for PyGhidra
ENV GHIDRA_INSTALL_DIR=${GHIDRA_DIR}

# Install PyGhidra from Ghidra's bundled distribution (offline mode)
RUN if [ "${USE_BREAK_SYSTEM_PACKAGES}" = "true" ]; then \
        python3 -m pip install --no-cache-dir --break-system-packages \
            --no-index -f ${GHIDRA_DIR}/Ghidra/Features/PyGhidra/pypkg/dist pyghidra; \
    else \
        python3 -m pip install --no-cache-dir \
            --no-index -f ${GHIDRA_DIR}/Ghidra/Features/PyGhidra/pypkg/dist pyghidra; \
    fi

# Create pwn user (common for pwn challenges)
RUN useradd -m -s /bin/bash pwnuser

# Create /app directory (standard working directory)
RUN mkdir -p /app && chown -R pwnuser:pwnuser /app

# Set up pwndbg to load automatically
RUN echo "source /opt/pwndbg/gdbinit.py" > /root/.gdbinit

# Set working directory
WORKDIR /app

# Labels for metadata
LABEL maintainer="PwnAgent Team"
LABEL description="Base image for pwn challenges with common tools"
LABEL version="0.1.0"

# Default command
CMD ["/bin/bash"]
