FROM ytnobody/base
MAINTAINER ytnobody <ytnobody@gmail.com>

RUN mkdir /app
RUN git clone https://github.com/uzulla/Pyazo2.git /app/pyazo2

RUN apt-get update && apt-get -y install libjpeg-dev libpng-dev libgif-dev zlib1g-dev ffmpeg imagemagick

WORKDIR /app/pyazo2
RUN cpanm -n --installdeps . 
RUN cpanm -n Starlet Server::Starter Linux::Inotify2

RUN cp config/development.pl.sample config/production.pl
RUN sed -i 's/development\.db/pyazo2.db/g' config/production.pl

ADD run.sh run.sh
RUN mkdir img

EXPOSE 5000
RUN ln -s $(which ffmpeg) /usr/local/bin/ffmpeg
RUN ln -s $(which convert) /usr/local/bin/convert

CMD ["./run.sh"]
