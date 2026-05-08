FROM fedora:latest

RUN dnf update -y && dnf install -y \
    sudo nano iputils net-tools openssh-clients curl nmap bind-utils \
    && dnf clean all

CMD ["/bin/bash"]
