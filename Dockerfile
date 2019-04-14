FROM library/swift
LABEL maintainer="Eve <eve@storybooklabs.io>"
LABEL Description="Docker Container which can run both ruby and swift"

RUN \
  apt-get update && \
  apt-get install -y wget

ADD install-ruby.sh /tmp/install-ruby.sh
RUN chmod a+x /tmp/install-ruby.sh
RUN cd /tmp && ./install-ruby.sh && rm install-ruby.sh

ENV PATH /opt/rubies/ruby-2.6.2/bin:$PATH
ENV LANG en_US.UTF-8

RUN apt-get -yq install sqlite3 && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /data

CMD ["bash"]
