# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).


### Задание 0

1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav). 
Этот функционал понадобится к следующей лекции.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
------

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
Убедитесь что ваша версия **Terraform** ~>1.8.4

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.
------
### Ответ

![1](https://github.com/Takarigua/terraform2/blob/da49887184921355c89454b48ab442a68a446b56/screen/1.png)
------
![2](https://github.com/Takarigua/terraform2/blob/da49887184921355c89454b48ab442a68a446b56/screen/2.png)
------
По поводу 5 пункта - были ошибки в части platform_id, даже при выполнении apply сообщалось о том, что v4 не существует. Я заменил на 1. Так как я заменил на единицу - за собой потянулась ошибка в части ресурсов, а именно ядер, на v1 не могло быть 1 ядро - или 2 или 4 (опять же сообщение от apply). Также у меня была проблема по поводу инициализации и нужно было явно указать required_providers.
По поводу 8 пункта - preemptible = true - создает прерываемую ВМ, полезна для тестирования или обучения, ВМ работает дешевле, но может быть остановлена в любой момент. core_fraction = 5 - ограничивает производительность CPU до 5% от полной мощности ядра, что значительно снижает стоимость (применение то же самое из-за плюса по цене).


------
### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 
------
### Ответ

![3](https://github.com/Takarigua/terraform2/blob/85b1c538bb97a125ac53048e5d55c04319322f35/screen/3.png)
------
### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.
------
### Ответ

![4](https://github.com/Takarigua/terraform2/blob/85b1c538bb97a125ac53048e5d55c04319322f35/screen/4.png)
------
### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.
------
### Ответ

![5](https://github.com/Takarigua/terraform2/blob/85b1c538bb97a125ac53048e5d55c04319322f35/screen/5.png)
------
### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.
------
### Ответ

![6](https://github.com/Takarigua/terraform2/blob/85b1c538bb97a125ac53048e5d55c04319322f35/screen/6.png)
------

### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=2
       memory=2
       core_fraction=5
       hdd_size=10
       hdd_type="network-hdd"
       ...
     },
     db= {
       cores=2
       memory=4
       core_fraction=20
       hdd_size=10
       hdd_type="network-ssd"
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.
------
### Ответ
------
Тут важная ремарка - я немного усложнил себе задачу и пришлось поковыряться (ради опыта, так как я работаю в КИИ и мне важно делать все безопасно), я не хотел нигде явно светить ключом, поэтому я решил сделать этот пункт через обращение к файлу ключа в системе. Т.е. по моему замыслу, если бы я закосячил с .gitignore и запушил чувствительные данные, то тимлид бы меня сильно не побил, так как в конфигах была лишь ссылка на файл в системе *.pub, без данных о ключе естественно. Не знаю, насколько такое правильно, но оно сработало и вроде выполнило условия задачи. Я игрался только под конец с прятанием ключа. Я не прочь получить совета от профессионалов). 
------
![7](https://github.com/Takarigua/terraform2/blob/2f8c97ab2cc88cfecd933f0f44fec0a4bfb42dfa/screen/7.png)
------
