# Getting started with k8s-node-manager

Some containers are intended to access, monitor, and possibly change features on the host system directly. These are referred to as super privileged containers.
This project shows capabilities of Super Privileged Container. It is very useful when your host system has some limitations.
 - Many tools that you might want to use to manage or troubleshoot host are not included by default. 
 - Host does not allow for packages to be installed using yum or apt-get commands
 
## Build Image

To build image execute command:

```
$ sudo docker build -t zreigz/k8s-node-manager
```

## Running Privileged Container
 
Running a docker command to include every option you need to run as a super privileged container would require a long command line.

```
docker run -ti --privileged -d --net=host --pid=host -e sysimage=/host -v /:/host -v /run:/run zreigz/k8s-node-manager /bin/bash
```

By understanding what options are run for a super privileged container you can better understand how you might want to use those options 
when running your container that need to access resources on the host. Here are descriptions of those options:

- -i -t: Open a terminal device (-t) and run interactively (-i). 
- The --privileged option turns off the Security separation, meaning a process running as root inside of the container has 
the same access to host that it would have if it were run outside the container.
- The --net=host, and --pid=host flags turn off the net and pid namespaces inside the container. This allows processes within the container to see and use the Host’s network and process table.
- -e sysimage=/host: Sets the location of the host filesystem within the container.
- -v /:/host: Mounting / from the host on /host allows a process within the container to easily modify content on the host.
- -v /run:/run: The -v /run:/run option mounts the /run directory from the host on the /run directory inside the container.
This allows processes within the container to talk to the host’s dbus service and talk directly to the systemd service. 
Processes within the container can even communicate with the docker daemon. 

## Running Commands from k8s-node-manager Container

The container has many useful tools to debug, monitor and system modification.
First of all you can get access to host terminal via WEB. Open your WEB browser and enter link:

```
https://HOST_IP:4200/
```
Now you have full access to node. 

### Command examples

You can use Kubernrtes cli:

```
kubectl get nodes
```

Network tools

- iftop is similar to top, but instead of mainly checking for cpu usage it listens to network traffic on selected network interfaces and displays a table of current usage.
- net-tools which alows use `ifconfig` and `netstat` command.
- nmap allows you to scan your server for open ports or detect which OS is being used.
```
# nmap 127.0.0.1
```
- nmon systems administrator, tuner, benchmark tool gives you a huge amount of important performance information in one go.
- tcpdump a powerful command-line packet analyzer.
```
# tcpdump -i eth1 'udp port 53'
```
To display all FTP session to 202.54.1.5, enter:
```
# tcpdump -i eth1 'dst 202.54.1.5 and (port 21 or 20)'
```
To display all HTTP session to 192.168.1.5:
```
# tcpdump -ni eth0 'dst 192.168.1.5 and tcp and port http'
```
Use wireshark to view detailed information about files, enter:
```
# tcpdump -n -i eth1 -s 0 -w output.txt src or dst port 80
```
