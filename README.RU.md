[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/eNotes/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/eNotes/blob/master/README.RU.md) 
# EasyNotes
Приложение для заметок, с синхронизацией. Сервером выступает приложение для Windows, поэтому для синхронизации необходимо запускать его. Для Android на данный момент приложения нет.

## Настройка
Для корректного отображения интерфейса Windows приложения запустите файл "ie11_enable.reg".

### Синхронизация мобильного клиента
1. Зарезервируйте постоянный IP адрес компьютеру с Windows приложением. Это делается в настройках Wi-Fi роутера, в разделе DHCP.
2. Зарезервируйте постоянный IP адрес iOS устройства и вставьте его IP адрес в файл "Allow.txt", чтобы заблокировать доступ другим устройствам или вставьте слово "ALL", чтобы открыть доступ для всех IP адресов.
3. Узнайте локальный IP адрес вашего компьютера с Windows приложением. Это можно сделать, например, в командной строке, введя комаунду "ipconfig" или в настройках Windows.
4. Зайдите в Safari на iOS устройстве и введите там "IP/webapp", где IP это зарезервированный постоянный IP вашего компьютера. Далее нужно нажать "Поделиться" -> "На экран Домой". На рабочем столе появится ярлык для EasyNotes.

## Скриншоты
### Windows
![](https://user-images.githubusercontent.com/9499881/54496678-ad271b80-490b-11e9-89b4-6a87ba156e43.PNG)

### iOS
![](https://user-images.githubusercontent.com/9499881/54852979-e1ce1500-4d07-11e9-8c0a-91dca563fcf7.PNG)
![](https://user-images.githubusercontent.com/9499881/54852821-6ff5cb80-4d07-11e9-889f-2858175af05a.PNG)
![Setup](https://user-images.githubusercontent.com/9499881/54852962-d2e76280-4d07-11e9-841a-06d50fafb3c4.gif)

## Загрузка
>Версия для Windows 7, 8.1, 10.

**[Загрузить](https://github.com/r57zone/eNotes/releases)**

## API
| Запрос | Тип запроса | Описание | Пример |
| ------------- | ------------- | ------------- | ------------- |
| `IP/getnotes` | GET | Получение списка идентификатора (Unix timestamp) и времени заметки (Unix timestamp с UTC смещением). | &lt;notes&gt;&lt;note id="1553287432" datetime="1553301832"&gt;&lt;/note&gt;&lt;note id="1553287428" datetime="1553301828"&gt;&lt;/note&gt;&lt;/notes&gt; |
| `IP/getfullnotes` | GET | Получение списка идентификатора, заметки (в Base64) и времени заметки. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;note id="1553248570" datetime="1553262970"&gt;Mg==&lt;/note&gt;&lt;/notes&gt; |
| `IP/getnote=ID` | GET | Получение содержимого заметки по идентификатору. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;/notes&gt; |
| `IP/syncnotes` | POST | Отправка созданных и измененных клиентом заметок. | &lt;actions&gt;&lt;insert id="1553285632" datetime="1553300032"&gt;Mw==&lt;/insert&gt;&lt;update id="1553248570" datetime="1553262970"&gt;Mg==&lt;/update&gt;&lt;delete id="1553248570"&gt;&lt;/delete&gt;&lt;/actions&gt; |

Где IP это адрес, с запущенным приложением для Windows. Данные получаются и передаются в разметке XML.

## Обратная связь
`r57zone[собака]gmail.com`