Notes synchronization web server for EasyNotes.

En:
1. Extract the contents of the "www" folder to your web host.
2. Change the mysql database parameters in the configuration file "api/config.php".
3. In the app settings for Windows and Android, enter your domain address, for example "http://example.com" and port 80.
4. For iOS, copy the "main.html", "app.manifest" files, as well as the "icons" and "images" folders from the "Source/Windows/webapp" directory to the root of your web host, then go to your domain by adding the file "/getnotes.php" to the link, so that something like the following "http://example.com/getnotes.php" comes out, after which you can install the web application on iOS, after enabling WebSQL support in Safari's advanced settings. Read more in the main instructions.
5. Synchronize all your devices and block access to synchronize new devices by changing the parameter in the settings file "api/config.php".

Ru:
1. Распакуйте содержимое папки "www" на ваш веб-хостинг.
2. Измените параметры базы данных mysql в файле настроек "api/config.php".
3. В настройках приложений для Windows и Android введите адрес вашего домена, например, "http://example.com" и 80 порт.
4. Для iOS скопируйте в корень вашего веб-хостинга файлы "main.html", "app.manifest", а также папки "icons" и "images", из каталога "Source/Windows/webapp", после чего перейдите на ваш домен, добавив в ссылку файл "/getnotes.php", чтобы вышло примерно следующее "http://example.com/getnotes.php", после чего можно установить веб-приложение на iOS, предварительно включив в расширенных настройках Safari поддержку WebSQL. Подробнее в основной инструкции.
5. Синхронизируйте все ваши устройства и закройте доступ для синхронизации новых устройств, изменив параметр в файле настроек "api/config.php".