# Use the official Mono image which supports running legacy .NET apps on Linux
FROM mono:latest

# Install xsp4, the Mono lightweight web server for ASP.NET Web Forms
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mono-xsp4 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy all the project files into the container
COPY . .

# Expose the port that the web server will use
EXPOSE 8080

# Start the xsp4 web server on port 8080 without requiring interactive input
CMD ["xsp4", "--port", "8080", "--nonstop"]
