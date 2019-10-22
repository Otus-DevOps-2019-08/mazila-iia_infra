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


# terraform-1

+ Создана ветка terraform-1
+ Создан файл конфигурации terraform main.tf
+ В main.tf добавлены ключи для пользователя
+ Добавлены правила фаервола и теги
+ Создан файл для выходных переменных outputs.tf
+ Добавлены провижинеры для деплоя последней версии приложения
+ Создана директория files. В ней юнит для puma.service и deploy.sh
+ Создан variables.tf для переменных
+ Создан terraform.tfvars для переменных

##  Задания со *

+ Добавил пользователей appuser2 и appuser3 для подключения по ssh в main.tf
+ После добавления shh ключа для appuser_web в веб интерфейсе при запуске terraform apply ключ будет удален

## Задания c **

+ Создан балансировщик (конфигурация в файле lb.tf)
+ Ручками копировать код для одинаковых инстансов - иррационально. main.tf поправлен для создания инстансов через count
+ Добавлены output переменные


# terraform-2

+ Создана ветка terraform-2
+ main.tf на отдельные файлы
+ Созданы модули app, db, vpc
+ Созданы окружения stage и prod
+ Создан storage-bucket.tf

##  Задания со *

+ Настроено хранение стейт файла в удаленном бекенде

## Задания c **

+ Настроен автодеплой приложения
+ Для mongodb в конфиге разрешено слушать любой ip, а не только localhost
+ Для app настроены провижинеры. Изменена переменная окружения DATABASE_URL на значение внутреннего адреса mongodb

# ansible-1

+ Создана ветка ansible-1
+ Установлен ansible
+ Создан инвентори файл inventory
+ Создан ansible.cfg. Туда добавлены значения по умолчанию
+ Создан inventory.yml
+ Создан плейбук clone.yml
+ При первом выполнении команды:
```
ansible-playbook clone.yml
```
Никаких изменений не произошло, т.к. репозиторий уже склонирован
При втором изменения уже есть, т.к. мы выполнили
```
ansible app -m command -a 'rm -rf ~/reddit'
```

##  Задания со *

inventory.json

```
#!/bin/bash

app_ip=$(gcloud compute instances describe reddit-app --zone europe-west1-b | grep natIP | sed 's/natIP: /''/' | sed -e 's/[\t ]//g;/^$/d')
db_ip=$(gcloud compute instances describe reddit-db --zone europe-west1-b | grep natIP | sed 's/natIP: /''/' | sed -r 's/\s+//g')
i=$(echo "{
  "app": {
    "hosts": [\"$app_ip \"]
    },
  "db": {
    "hosts": [\"$db_ip \"]
    }
}"
)

echo $i
```

Ох, да, согласен, так себе решение через grep и sed получать значение IP, но этот динозавр работает :)

На выходе получается json с хостами


# ansible-2

+ Создана ветка ansible-2
+ Настроен плейбук для настройки mongo
+ Настроен плейбук для инстанса приложения
+ Настроен плейбук для деплоя
+ Настроен главынй плейбук site.yml

+ Настроены провиженеры на основе ansible для образов
+ Созданы новые образы
+ Окружение stage запущено с новыми образами

##  Задания со *
+ С помощью gcp_compute настроен динамический инвентори (старый динамический инвентори из прошлого ДЗ со * деактивирован)
+ Настроены переменные для внутреннего интерфейса mongodb
