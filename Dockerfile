FROM frolvlad/alpine-glibc
LABEL maintainer="Carlo Dri" \
      description="minimal texlive-full image"
    
RUN mkdir /tmp/install-tl-unx

WORKDIR /tmp/install-tl-unx    

COPY texlive.profile .

RUN sed -i -e 's/v3\.6/edge/g' /etc/apk/repositories \
    && apk upgrade --update-cache --available \
    && apk --no-cache add perl wget xz tar \
    && wget ftp://tug.org/historic/systems/texlive/2018/install-tl-unx.tar.gz \
    && tar --strip-components=1 -xvf install-tl-unx.tar.gz \
    && ./install-tl -profile texlive.profile \
    && apk del wget xz tar \
    && cd \
    && rm -rf /tmp/install-tl-unx \
    && mkdir /workdir

ENV PATH="/usr/local/texlive/2018/bin/x86_64-linux:${PATH}"

WORKDIR /workdir

VOLUME ["/workdir"]
