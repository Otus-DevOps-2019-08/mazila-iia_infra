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

+ Скрипты от прошлого ДЗ перенесены в директорию VPN
+ Созданы shell скрипты для автоматизации установки приложения
+ Создан startup_script.sh для автоматического деплоя приложения

### Startup script

```
gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
starup-script=./startup_script.sh
```

### Firewall rules

```
gcloud compute firewall-rules create default-puma-server \
    --network default \
    --allow=tcp:9292 \
    --source-ranges 0.0.0.0/0 \
    --target-tags=puma-server
```

# packer-base

+ Создан файл immutable.json (Packer шаблон)
+ Добавлены провижинеры для установки MongoDB и Ruby
+ Создан образ из шаблона
+ Создан инстанс из образа
+ Добавлены пользовательские переменные
+ Добавлен variables.json.example (variables.json добавлен в .gitignore)
+ Создан Packer шаблон immutable.json с автоматически установленным/запущенным приложением
+ Написан скрипт unit.sh для создания юнита puma
+ Создан create-redditvm.sh для создания инстанса из образа в bash
