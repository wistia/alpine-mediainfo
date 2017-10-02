FROM alpine-zenlib as zenlib
FROM alpine-mediainfolib as mediainfolib

FROM alpine
RUN apk update && apk add git automake autoconf libtool pkgconfig make gcc zlib-dev libc-dev g++
COPY --from=zenlib /ZenLib/Project/GNU/Library/libzen-config /bin/
COPY --from=zenlib /usr/local/include/ZenLib /usr/local/include/ZenLib/
COPY --from=zenlib /usr/local/lib/libzen.a /usr/local/lib/libzen.a
COPY --from=mediainfolib /MediaInfoLib/Project/GNU/Library/libmediainfo-config /bin/
COPY --from=mediainfolib /usr/local/include/MediaInfo /usr/local/include/MediaInfo/
COPY --from=mediainfolib /usr/local/lib/libmediainfo.a /usr/local/lib/libmediainfo.a
RUN git clone https://github.com/MediaArea/MediaInfo.git
WORKDIR /MediaInfo/Project/GNU/CLI
RUN ./autogen.sh && ./configure --enable-static && make && make install
