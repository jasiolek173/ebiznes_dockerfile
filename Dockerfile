FROM ubuntu:18.04

# git, vim, java 8
RUN apt update && \
    apt-get install -y vim git unzip curl && \
    apt-get install -y openjdk-8-jdk

#scala 2.12.8
RUN curl -L -o scala-2.12.8.deb https://downloads.lightbend.com/scala/2.12.8/scala-2.12.8.deb && \
    dpkg -i scala-2.12.8.deb && \
    rm scala-2.12.8.deb

#sbt
RUN \
  curl -L -o sbt-1.3.10.deb https://dl.bintray.com/sbt/debian/sbt-1.3.10.deb && \
  dpkg -i sbt-1.3.10.deb && \
  rm sbt-1.3.10.deb && \
  apt-get update && \
  apt-get install sbt 

#npm w 6.8
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs  && \
    npm install -g npm@6.8


RUN useradd -ms /bin/bash adam_jasiolek
USER adam_jasiolek
WORKDIR /home/adam_jasiolek
RUN mkdir projekt

# run sbt- current user adam_jasiolek
RUN sbt sbtVersion


VOLUME /home/adam_jasiolek/projekt

EXPOSE 8000
EXPOSE 9000
EXPOSE 5000
EXPOSE 8888


#test
#RUN java -version   && \
#    scala -version  && \
#    sbt   -version  && \
#    node  -v  && \
#    npm   -v 
