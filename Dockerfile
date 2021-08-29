# ubuntu:xenial -> ubuntu 16.04
FROM ubuntu:18.04

MAINTAINER Ninja <ninja.devops@dev.com>

workdir /home

copy . /home

run apt-get update

run apt-get -y install $(cat pkglist)

run pip3 install -r requirements.txt

run cobc -x -free -o /home/TESTMERGE /home/TESTMERGE.cbl

EXPOSE 8090

CMD ["python3", "app.py"]
