FROM ubuntu:14.04
MAINTAINER Matthias Kadenbach <matthias.kadenbach@gmail.com>

RUN echo 'deb http://deb.torproject.org/torproject.org trusty main' | tee /etc/apt/sources.list.d/torproject.list
RUN gpg --keyserver keys.gnupg.net --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

RUN echo 'deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main' | tee /etc/apt/sources.list.d/ruby.list
RUN gpg --keyserver keyserver.ubuntu.com --recv C3173AA6
RUN gpg --export 80f70e11f0f0d5f10cb20e62f5da5f09c3173aa6 | apt-key add -

RUN apt-get update && \
    apt-get install -y tor polipo ruby2.1 libssl-dev wget curl build-essential zlib1g-dev libyaml-dev libssl-dev && \
    ln -s /lib/x86_64-linux-gnu/libssl.so.1.0.0 /lib/libssl.so.1.0.0

RUN update-rc.d -f tor remove
RUN update-rc.d -f polipo remove

RUN gem install excon -v 0.44.4

ADD start.rb /usr/local/bin/start.rb
RUN chmod +x /usr/local/bin/start.rb

ADD newnym.sh /usr/local/bin/newnym.sh
RUN chmod +x /usr/local/bin/newnym.sh

ADD uncachable /etc/polipo/uncachable

EXPOSE 9000 9000
EXPOSE 9001 9001
EXPOSE 9002 9002
EXPOSE 9003 9003
EXPOSE 9004 9004
EXPOSE 9005 9005
EXPOSE 9006 9006
EXPOSE 9007 9007
EXPOSE 9008 9008
EXPOSE 9009 9009

CMD /usr/local/bin/start.rb
