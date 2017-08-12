FROM irreverentpixelfeats/haskell-build-ubuntu-xenial:8.0.2-20170808155631-8e84a50
MAINTAINER Dom De Re <domdere@irreverentpixelfeats.com>

ENV IDRIS_VERSION=1.1.1

ADD tars tmp

RUN cd /tmp \
  && mkdir -p /opt/idris \
  && cp idris-${IDRIS_VERSION}.tar.gz /opt/idris \
  && cd /opt/idris \
  && tar xzvf idris-${IDRIS_VERSION}.tar.gz \
  && rm idris-${IDRIS_VERSION}.tar.gz \
  && cd /opt/idris/idris-${IDRIS_VERSION} \
  && cabal update \
  && git init \
  && /opt/mafia/mafia build

# stuff in the data dir is likely to change very frequently but doesnt actually affect the image much itself,
# example: version SHAs
# So adding it last should speed up the builds
ADD data /tmp

# Add the git-sha for the docker file to the image so if you need you can see where
# your image sat in the timeline of git changes (which might be tricky to correlate with the
# docker hub changes)
RUN mkdir -p /var/versions && cp -v /tmp/version /var/versions/idris-build-ubuntu_xenial-1.1.1.version


