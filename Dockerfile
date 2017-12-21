# A Dockerfile for running Swift unit tests inside an Ubuntu Linux container
FROM swift:4

WORKDIR /code

COPY Package.swift /code/.
COPY ./Tests /code/Tests
COPY ./Sources /code/Sources

RUN swift --version
CMD swift test
