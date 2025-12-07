FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    openssh-client \
    pdsh \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH for persistent usage
RUN mkdir /var/run/sshd

# 1. Allow Root Login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 2. Disable Strict Modes (CRITICAL FIX)
# This tells SSHd to accept keys even if they are owned by your host user "tudor"
RUN echo "StrictModes no" >> /etc/ssh/sshd_config

# 3. Disable StrictHostKeyChecking (Client side)
RUN mkdir -p /root/.ssh && \
    echo "Host *\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile /dev/null\n\tLogLevel ERROR" > /root/.ssh/config

ENV PDSH_RCMD_TYPE=ssh

# --- NEW SECTION STARTS HERE ---

# Copy the entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to our script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# --- NEW SECTION ENDS HERE ---

EXPOSE 22

# This command is passed to the entrypoint script as "$@"
CMD ["/usr/sbin/sshd", "-D"]