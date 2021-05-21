FROM docker.io/rocker/r-base:4.0.4

WORKDIR /build

COPY system_libraries.txt .

# Install system dependencies and clean up afterwards
RUN apt-get update \
  && xargs -a system_libraries.txt apt-get install -y \
  && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN Rscript setup.R
