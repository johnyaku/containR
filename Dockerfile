FROM docker.io/rocker/r-base:4.0.4 AS dev
WORKDIR /build
COPY system_libraries.txt .
# Install system dependencies and clean up afterwards
RUN apt-get update \
  && xargs -a system_libraries.txt apt-get install -y \
  && rm -rf /var/lib/apt/lists/*
RUN R -e install.packages("renv")

FROM dev AS prod
COPY home/project,inflate.R /project
WORKDIR /project
RUN Rscript inflate.R
