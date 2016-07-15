FROM debian:jessie

WORKDIR /opt/tools

RUN apt-get update && apt-get install -y wget

RUN wget -P /usr/local/bin/ https://storage.googleapis.com/kubernetes-release/release/v1.3.0/bin/linux/amd64/kubectl
RUN chmod +x /usr/local/bin/kubectl

RUN apt-get install -y openssl shellinabox curl nmap net-tools iftop tcpdump nmon

# copy to workdir
COPY . .

ENTRYPOINT ["/opt/tools/run.sh"]
