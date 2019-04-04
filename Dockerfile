FROM rust:slim

# gcc and clang are necessary to be able to compile crates that have build scripts
RUN apt-get update && apt-get install -y curl gcc make libssl-dev pkg-config clang

RUN rustup target add asmjs-unknown-emscripten
RUN rustup target add wasm32-unknown-emscripten
RUN rustup target add wasm32-unknown-unknown

RUN rustup toolchain install nightly
RUN rustup target add --toolchain nightly asmjs-unknown-emscripten
RUN rustup target add --toolchain nightly wasm32-unknown-emscripten
RUN rustup target add --toolchain nightly wasm32-unknown-unknown

RUN cargo install cargo-web
RUN cargo web prepare-emscripten

COPY config /root/.cargo
COPY asmjs-emscripten-toolchain.cmake /root
