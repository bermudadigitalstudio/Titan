# A Dockerfile for running Swift unit tests inside an Ubuntu Linux container
FROM swift

WORKDIR /code

COPY Package.swift /code/
RUN swift package fetch

# Assuming that tests change less than code, so put Tests before Sources copy
COPY ./Tests /code/Tests
COPY ./Sources /code/Sources
RUN swift --version
CMD swift test
