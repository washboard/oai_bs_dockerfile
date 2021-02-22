FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install sudo git vim net-tools iputils-ping curl -y
RUN cd ~ && git clone https://gitlab.eurecom.fr/oai/openairinterface5g.git && cd openairinterface5g && git checkout develop
RUN sed -i '/2190472.git/d' ~/openairinterface5g/cmake_targets/tools/build_helper
RUN cp ~/openairinterface5g/targets/PROJECTS/GENERIC-LTE-EPC/CONF/enb.band7.tm1.50PRB.usrpb210.conf ~/openairinterface5g/
RUN ~/openairinterface5g/cmake_targets/build_oai -I
RUN sudo add-apt-repository ppa:ettusresearch/uhd
RUN sudo apt-get update -y
RUN sudo apt-get install libuhd-dev libuhd003 uhd-host -y
RUN sudo uhd_images_downloader
RUN ~/openairinterface5g/cmake_targets/build_oai --eNB --gNB -c -C -w USRP
