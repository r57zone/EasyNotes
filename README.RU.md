[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/EasyNotes/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/EasyNotes/blob/master/README.RU.md) 
# EasyNotes
![](https://user-images.githubusercontent.com/9499881/100446367-1cd14000-30c8-11eb-8e82-335f134a8c95.png)

Простые заметки для Windows, Android и iOS, с прямой локальной синхронизацией или синхронизацией с веб-сервером. Сервером может выступать как приложение для Windows (для синхронизации необходимо запускать его), так и ваш веб-сервер. Посмотреть API можно [здесь](https://github.com/r57zone/EasyNotes/blob/master/API.RU.md).

## Особенности
Поддерживаются следующие языки: английский, русский, китайский (традиционный), испанский, португальский (бразильский португальский), французкий, немецкий, японский, арабский, итальянский и корейский.

![flag-united-kingdom](https://github.com/user-attachments/assets/8c03c9b8-d154-466f-b9c4-6ea60278d537)
![flag-russia](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)
![flag-chine](https://github.com/user-attachments/assets/16848591-2baf-4300-893b-b95d5249a34e)
![flag-spanish](https://github.com/user-attachments/assets/a892b7ce-d83f-4914-9c54-9ba16c9c9e38)
![flag-brazil](https://github.com/user-attachments/assets/f2544579-81df-43b4-94c5-59c569828182)
![flag-french](https://github.com/user-attachments/assets/57f54331-32a3-4146-823c-4aa85a4c6669)
![flag-germany](https://github.com/user-attachments/assets/11066aa3-7c0d-4507-9df1-cad00fe53fad)
![flag-japan](https://github.com/user-attachments/assets/37cfc183-4de7-4d5a-a698-0da1286a6ee1)
![flag-egypt](https://github.com/user-attachments/assets/44399d0f-f05f-4d44-a4ab-13b6d7ded087)
![flag-saudi-arabia](https://github.com/user-attachments/assets/07d7d133-5a21-4bde-8c37-c1ef3772ac91)
![flag-united-arab-emirates](https://github.com/user-attachments/assets/81d3b610-a2f4-44c9-b2ad-20e4d7cfb2b2)
![flag-italy](https://github.com/user-attachments/assets/692490d6-bc53-446f-99b8-bf2becb8ec0d)
![flag-north-korea](https://github.com/user-attachments/assets/5b315a3d-6ce0-4cbb-b7a3-133ef2bcb2c5)
![flag-south-korea](https://github.com/user-attachments/assets/ed3d3778-9193-444a-85fd-ac5dd7bc91c6)


Приложения имеют тёмную тему и автоматические переключение на неё в тёмное время суток.


Присутствует полная поддержка планшетов.


Если необходимо оставить старую дату, при редактировани заметки, то на мобильных телефонах нужно нажать на дату, а на ПК зажать клавишу "Shift", при нажатии на кнопку готово.


Имеется ограничение на 5 мегабайт для заметок, следить за объёмом доступной памяти можно в настройках приложения.

## Настройка
### Windows
Для Windows есть 2 приложения, одно является серверным приложением, которое является центром P2P синхронизации и второе клиентским, синхронизирующимся с P2P или веб-сервером.

### Android
Установите `EasyNotes.apk`, выберите автопоиск IP адреса или введите зарезервированный постоянный IP вашего компьютера (об этом ниже). Если ваш маршрутизатор присваивает следующие IP адреса: `192.168.0.0/15`, `192.168.0.100/115`, `192.168.1.0/15`, `192.168.1.100/115`, `192.168.2.0/15`, `192.168.3.0/15`, то можно просто включить автопоиск IP адреса и приложение само найдет ваш компьютер.

### iOS 13+
Если вы хотите синхронизироваться напрямую с ПК или с http веб-сервером, то вам необходимо проделать следующее:
1. Загрузите архив "EasyNotes.iOS.zip", распакуйте его в папку EasyNotes и разместите папку в [Apple iCloud](https://www.icloud.com/iclouddrive/), также создайте папку `images` и переместите туда изображения из `EasyNotes\images`.
2. Установите приложение [HTML Viewer Q](https://apps.apple.com/us/app/html-viewer-q/id810042973) (или любое другое, способное отобразить HTML приложение и разрешающее интернет-соединения).
3. Запустите приложение `HTML Viewer Q`, нажмите иконку файлы (5-ая внизу). Нажмите `Обзор`, перейдите в iCloud Drive, далее в `Приложения` и нажмите на папке `EasyNotes` переместить, после чего переместите папку в `iPhone/HTML Viewer`.
4. Далее открываем `index.html`, закрываем приложение `HTML Viewer Q` и открываем его снова, после чего приложение заработает и все стили будут отображаться.
5. В настройках приложения можно отключить `Tabbed Browsing`, чтобы отключить верхний бар, с переключением HTML страниц.

### iOS 13+
Если вы хотите просто использовать приложение без синхронизации или хотите синхронизироваться с https веб-сервером, то вам необходимо проделать следующее:
1. Откройте браузер Safari, на мобильном устройстве и введите там `https://easynotespwa.github.io`.
2. Нажмите кнопку `Поделиться` → `На экран Домой`. На рабочем столе появится ярлык для EasyNotes.

### iOS 9-12
1. Откройте браузер Safari, на мобильном устройстве и введите там `http://IP:735/webapp`, где IP это зарезервированный постоянный IP вашего компьютера.
2. Нажмите кнопку `Поделиться` → `На экран Домой`. На рабочем столе появится ярлык для EasyNotes.

Также если у вас iOS 6-8, можно использовать [старую версию веб-приложения](https://github.com/r57zone/EasyNotes/releases/download/0.8.7/EasyNotes.iOS.6-8.support.fix.zip).

### Синхронизация мобильных приложений по P2P (опционально, в случае проблем)
Проверьте брандмауэр Windows, разрешены ли входящие подключения у вашего типа сети (частной) и разрешите если отключены. 

Далее для приложений Windows, Android и iOS 13+ можно включить автопоиск IP-адреса, и попробовать сихнронизироваться. Если синхронизация не работает или у вас более старая iOS, то попробуйте проделать следующее:
1. Зарезервируйте постоянный IP адрес компьютеру, с Windows приложением. Это делается в настройках Wi-Fi роутера, в разделе "DHCP".
2. Зарезервируйте постоянный IP адрес мобильного устройства и добавьте его, если он отсуствует, в настройках приложения для Windows. Также можно открыть доступ для всех IP адресов (небезопасно). При необходимости удалите ненужные IP адреса.

### Настройка веб-синхронизации
Следуйте инструкциям описанном [здесь](https://github.com/r57zone/EasyNotes/tree/master/Source/Web).

## Скриншоты
### Windows
[![](https://github.com/user-attachments/assets/8c27ae18-10ae-49f0-9be2-bad14172166c)](https://github.com/user-attachments/assets/36da3bcd-ac0d-474c-a733-dc70f4b035f7)
[![](https://github.com/user-attachments/assets/868fa151-ce97-447a-b87e-a8b435e8b29b)](https://github.com/user-attachments/assets/33a7e206-ae5a-438d-b1c2-92a2b95070a5)

### Android / iOS
![UI](https://github.com/user-attachments/assets/3e241777-79cf-4cdc-ab20-b322a0d2f099)
![HTML Viewer Q](https://github.com/user-attachments/assets/6496fda0-4566-4eae-80d6-0fb7fa1ae880)
![PWA / HTML app](https://github.com/user-attachments/assets/4cec5cb1-4bf8-4f9a-98e8-ce646bab1998)

>На втором изображении показана установка приложения для iOS с офлайн работой и синхронизацией, с помощью стороннего приложения HTML Viewer Q. 


>На третьем изображении показана установка PWA или HTML приложения. PWA может синхронизироваться только с https серверами. HTML приложения могут работать офлайн только до iOS 13, начиная с iOS 13 для офлайн работы нужно будет использовать предыдущий метод.

## Загрузка
>Версии для Android 7.1+, iOS 9+ и Windows 7+ (с установленным Internet Explorer 11).

**[Загрузить](https://github.com/r57zone/EasyNotes/releases)**

## Обратная связь
`r57zone[собака]gmail.com`