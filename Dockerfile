FROM ubuntu:14.04

MAINTAINER Ninja <ninja.devops@dev.com>

#update and get pre-requisites

run apt-get update

run apt-get install -y open-cobol

run apt-get install -y gcc



#copy in the source file

copy TESTMERGE.cbl /TESTMERGE.cbl

copy FILEPAY.TXT /FILEPAY.TXT

copy FILEPAY1.TXT /FILEPAY1.TXT

copy FILEMPAY.TXT /FILEMPAY.TXT



#compile the code

run cobc -x -free -o TESTMERGE TESTMERGE.cbl



#run the compiled program

cmd ["/TESTMERGE"]
