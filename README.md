Certification boxfuse-sample-java-war-hello
=============================

Boxfuse Sample Hello World Java application packaged as a war file

## Prerequisites

Настройка управляющего хоста:

1)  ВМ control в яндекс клауд: ubuntu 20.04, cpu 4 ram 4

2)  Установка Jenkins
sudo -i
apt update
timedatectl set-timezone Europe/Moscow
apt install chrony
systemctl enable chrony
apt install mc openjdk-11-jre -y

Для установки сервиса Jenkins добавляем репозиторий:
nano /etc/apt/sources.list.d/jenkins.list
deb https://pkg.jenkins.io/debian-stable binary/

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
apt update
apt install jenkins
systemctl enable jenkins


3)  Установка yc
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
Копировать yc в bin
su jenkins
yc init
OAuth token
yc iam service-account list
yc iam key create --service-account-name "name" --output key.json

4)  https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart

5)  Установка ansible
sudo apt-add-repository ppa:ansible/ansible
apt update
apt install ansible
apt install docker.io
apt install python3-pip
pip install docker
ansible-galaxy collection install community.docker

Идем в /etc/ansible/ansible.cfg и прописываем host_key_checking=False


7)  Pipeline - git 

Open your browser at http://yourhost:8888/hello-1.0