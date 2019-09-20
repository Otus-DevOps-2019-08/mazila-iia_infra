# mazila-iia_infra
mazila-iia Infra repository

bastion_IP = 35.207.119.87
someinternalhost_IP = 10.156.0.3

+ Создан аккаунт GCP
+ Созданы виртуальные машины
+ Настроены ip-адреса и праваила firewall
+ Настроен VPN сервер на базе pritunl

### Connect one command

```bash
ssh -i ~/.ssh/id_rsa -A root@35.207.119.87 -tt ssh 10.156.0.3
```
### Example conf ~/.ssh/config for aliases

```
Host someinternalhost
HostName 10.156.0.3
User root
IdentityFile ~/.ssh/id_rsa
ProxyCommand ssh -A 35.207.119.87 nc %h %p
```

# cloud-testapp
testapp_IP = 35.204.50.163
testapp_port = 9292
