FROM ruby:2.1-onbuild
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.1.0/dockerize-linux-amd64-v0.1.0.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.1.0.tar.gz
CMD ["/usr/local/bin/dockerize -wait tcp://rabbit:5672 /usr/src/app/crawl.rb"]