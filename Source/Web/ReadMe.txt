Notes synchronization web server for EasyNotes.

En:
1. Unzip the contents of the "Web" folder to your web hosting.

2. Change the mysql database settings in the "api/config.php" settings file.

3. In the Windows (client) and Android application settings, enter your domain address, for example, "http://example.com" and port 80.

4. For iOS 13+, copy the files from the "Source/Multi" directory to the web hosting folder. If the hosting has a security certificate (https), you can enable PWA so that the application works offline. To enable PWA, change the "let IsPWA = false;" parameter to let IsPWA = true; in the "index.html" file, you can also change the "let UseManualAddress = true;" parameter to "let UseManualAddress = false;" to disable server change settings in the application.

For iOS 9-12, copy the files from the "Source/Windows/webapp" directory (Windows applications) to the root of your web hosting, then go to your domain, adding the file to "/getnotes.php" to the link, so that it looks like "http://example.com/getnotes.php", after which you can install the web application on iOS. More details in the main instructions.

5. Sync all your devices and close access to sync new devices by changing the parameter in the settings file "api/config.php".


Ru:
1. Распакуйте содержимое папки "Web" на ваш веб-хостинг.

2. Измените параметры базы данных mysql в файле настроек "api/config.php".

3. В настройках приложений для Windows (клиент) и Android введите адрес вашего домена, например, "http://example.com" и 80 порт.

4. Для iOS 13+ скопируйте файлы из каталога "Source/Multi", в папку веб-хостинга. Если хостинг имеет сертификат безопасности (https), то можно включить PWA, чтобы приложение работало офлайн. Для включения PWA измените параметр "let IsPWA = false;" на let IsPWA = true; в файле "index.html", также можно изменить параметр "let UseManualAddress = true;" на "let UseManualAddress = false;", чтобы отключить параметры изменения сервера, в приложении.

Для iOS 9-12 скопируйте в корень вашего веб-хостинга файлы из каталога "Source/Windows/webapp" (приложения для Windows), после чего перейдите на ваш домен, добавив в ссылку файл на "/getnotes.php", чтобы вышло примерно следующее "http://example.com/getnotes.php", после чего можно установить веб-приложение на iOS. Подробнее в основной инструкции.

5. Синхронизируйте все ваши устройства и закройте доступ для синхронизации новых устройств, изменив параметр в файле настроек "api/config.php".