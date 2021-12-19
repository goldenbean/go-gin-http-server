FROM alpine:latest
WORKDIR /work
COPY server /work
COPY entrypoint.sh /work
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
EXPOSE 8080
ENTRYPOINT ["/work/entrypoint.sh"]