[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/EasyNotes/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/EasyNotes/blob/master/README.RU.md) 
# EasyNotes
![](https://user-images.githubusercontent.com/9499881/100446367-1cd14000-30c8-11eb-8e82-335f134a8c95.png)

Приложения заметок для Windows, iOS и Android, с прямой локальной синхронизацией или синхронизацией с веб-сервером. Сервером может выступать как приложение для Windows (для синхронизации необходимо запускать его), так и ваш веб-сервер. Посмотреть API можно [здесь](https://github.com/r57zone/EasyNotes/blob/master/API.md).

## Особенности
Если необходимо оставить старую дату, при редактировани заметки, то на мобильных телефонах нужно нажать на дату, а на ПК зажать клавишу "Shift", при нажатии на кнопку готово.


Приложения имеют тёмную тему и автоматические переключение на неё в тёмное время суток.


Также присутствует полная поддержка планшетов.


Из-за отключения WebSQL пришлось перейти на локальное хранилище в мобильных и веб-версиях. Из-за этого имеется ограничение на 5 мегабайт для заметок, следить за объёмом доступной памяти можно в настройках приложения. 


~~В Android версии присутствует QR сканер кодов.~~ Начиная с версии 1.0.5 удалено.

## Настройка
### Синхронизация мобильных приложений по P2P
1. Зарезервируйте постоянный IP адрес компьютеру, с Windows приложением. Это делается в настройках Wi-Fi роутера, в разделе "DHCP".
2. Зарезервируйте постоянный IP адрес мобильного устройства и добавьте его, если он отсуствует, в настройках приложения для Windows. Также можно открыть доступ для всех IP адресов (небезопасно). При необходимости удалите ненужные IP адреса.
3. Проверьте брандмауэр Windows, разрешены ли входящие подключения у вашего типа сети (частной) и разрешите если отключены. 

### iOS
Откройте браузер Safari, на мобильном устройстве и введите там "http://IP:735/webapp", где IP это зарезервированный постоянный IP вашего компьютера. Далее нужно нажать "Поделиться" -> "На экран Домой". На рабочем столе появится ярлык для EasyNotes.


Для обновления нужно синхронизироваться, далее зайти в настройки "Safari" и удалить историю и данные, после чего можно заново добавлять приложение.

### Android
Установите "EasyNotes.apk" и введите зарезервированный постоянный IP вашего компьютера. Если ваш маршрутизатор присваивает следующие IP адреса: `192.168.0.0/15`, `192.168.0.100/115`, `192.168.1.0/15`, `192.168.1.100/115`, `192.168.2.0/15`, `192.168.3.0/15`, то можно просто включить автопоиск IP адреса и приложение само найдет ваш компьютер.

### Windows
Для Windows есть 2 приложения, одно является серверным приложением, которое является центром P2P синхронизации и второе клиентским, синхронизирующимся с P2P или веб-сервером.

### Настройка веб-синхронизации
Следуйте инструкциям описанном [здесь](https://github.com/r57zone/EasyNotes/tree/master/Source/Web).

## Скриншоты
### Windows
[![](https://user-images.githubusercontent.com/9499881/93087172-41ad3e00-f6a9-11ea-93b9-db93f3f8069e.PNG)](https://user-images.githubusercontent.com/9499881/54879010-b3f2e880-4e4d-11e9-8d46-3d983cb8495e.PNG)
[![](https://user-images.githubusercontent.com/9499881/93087171-41ad3e00-f6a9-11ea-9847-cc4e01de977c.PNG)](https://user-images.githubusercontent.com/9499881/93085355-7ec40100-f6a6-11ea-8a65-2cae4a206e33.PNG)

### iOS
![](https://user-images.githubusercontent.com/9499881/54878998-87d76780-4e4d-11e9-89ae-bd15ea494f73.PNG)
![](https://user-images.githubusercontent.com/9499881/54879001-9887dd80-4e4d-11e9-9618-5993cb06e93a.PNG)
![Setup](https://user-images.githubusercontent.com/9499881/54852962-d2e76280-4d07-11e9-841a-06d50fafb3c4.gif)

### Android
[![](https://user-images.githubusercontent.com/9499881/93085646-eb3f0000-f6a6-11ea-8323-a06e6f06fa65.png)](https://user-images.githubusercontent.com/9499881/93085457-a7e49180-f6a6-11ea-9b18-d87e9c7671ec.png)
[![](https://user-images.githubusercontent.com/9499881/93085644-eaa66980-f6a6-11ea-98f2-024ae3bb97ac.png)](https://user-images.githubusercontent.com/9499881/93085454-a74bfb00-f6a6-11ea-9825-ebbdd163cb92.png)
[![](https://user-images.githubusercontent.com/9499881/93085761-1b869e80-f6a7-11ea-9b36-7620790c43ab.png)](https://user-images.githubusercontent.com/9499881/93085547-c5b1f680-f6a6-11ea-8465-99fd70bb31b9.png)
[![](https://user-images.githubusercontent.com/9499881/93085759-1b869e80-f6a7-11ea-9868-07929effdac8.png)](https://user-images.githubusercontent.com/9499881/93085569-cea2c800-f6a6-11ea-96f9-2425c14b7aa7.png)

## Загрузка
>Версии для Android 7.1, iOS 9+ и Windows 7+ (с установленным Internet Explorer 11).

**[Загрузить](https://github.com/r57zone/EasyNotes/releases)**

## Обратная связь
`r57zone[собака]gmail.com`