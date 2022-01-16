FROM alpine:latest
WORKDIR /work
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY assets /work/assets
COPY public /work/public
COPY certs /work/certs
COPY entrypoint.sh /work
COPY server /work

EXPOSE 8080
ENTRYPOINT ["/work/entrypoint.sh"]