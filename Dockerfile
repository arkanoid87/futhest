FROM nimlang/nim:1.6.2-ubuntu

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN  apt-get update && apt-get install -y \
  libclang-10-dev \
  libldap2-dev \
  && rm -rf /var/lib/apt/lists/*

COPY . /usr/src/app
RUN nimble build -y

RUN ./futhest