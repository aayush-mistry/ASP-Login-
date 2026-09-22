# Use the official Mono image which supports running legacy .NET apps on Linux
FROM mono:latest

# Fix the Debian Buster repository issue (it has reached End of Life and moved to archives)
RUN echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list \
    && apt-get update -o Acquire::Check-Valid-Until=false \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated mono-xsp4 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy all the project files into the container
COPY . .

# Expose the port that the web server will use
EXPOSE 8080

# Start the xsp4 web server on port 8080 without requiring interactive input
CMD ["xsp4", "--port", "8080", "--nonstop"]
