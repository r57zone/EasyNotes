[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/EasyNotes/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/EasyNotes/blob/master/README.RU.md) 
← Choose language | Выберите язык

# EasyNotes
![](https://user-images.githubusercontent.com/9499881/100446367-1cd14000-30c8-11eb-8e82-335f134a8c95.png)

Notes apps for Windows, Android and iOS, with direct local sync or web server sync. The server can be either a Windows application (you need to run it for synchronization) or your web server. View API can be [here](https://github.com/r57zone/EasyNotes/blob/master/API.md).

## Features
The following languages ​​are supported: English, Russian, Chinese (Traditional), Spanish, Portuguese (Brazilian Portuguese), French, German, Japanese, Arabic, Italian and Korean.

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


Apps have a dark theme and automatic switching to it in the dark time.


There is full support for tablets.


If you want to leave the old date when editing a note then on mobile phones you need to click on the date and on the PC hold down the "Shift" key when you click on the done button.


There is a 5 megabyte limit for notes, you can monitor the amount of available memory in the application settings.

## Setup
### Windows
For Windows, there are 2 applications, one is a server application that is a P2P sync hub and the other is a client application that syncs with a P2P or web server.

### Android
Install `EasyNotes.apk`, select auto search for IP address or enter a reserved permanent IP of your computer (more on this below). If your router assigns the following IP addresses: `192.168.0.0/15`, `192.168.0.100/115`, `192.168.1.0/15`, `192.168.1.100/115`, `192.168.2.0/15`, `192.168.3.0/15`, then you can simply enable auto search for IP address and the application will find your computer itself.

### iOS 13+
If you want to sync directly with a PC or with an http web server, you need to do the following:
1. Download the archive "EasyNotes.iOS.zip", unzip it to the EasyNotes folder and place the folder in [Apple iCloud](https://www.icloud.com/iclouddrive/), also create an `images` folder and move the images from `EasyNotes\images` there.
2. Install the [HTML Viewer Q](https://apps.apple.com/us/app/html-viewer-q/id810042973) application (or any other application that can display HTML).
3. Launch the `HTML Viewer Q` application, click the files icon (5th from the bottom). Click on `Browse`, go to iCloud Drive, then to `Applications` and click on the `EasyNotes` folder to move, then move the folder to `iPhone/HTML Viewer`.
4. Next, open `index.html`, close the `HTML Viewer Q` application and open it again, after which the application will work and all styles will be displayed.
5. In the application settings, you can disable `Tabbed Browsing` to disable the top bar with switching HTML pages.

### iOS 13+ (PWA)
If you just want to use the application without synchronization or want to synchronize with an https web server, then you need to do the following:
1. Open the Safari browser on your mobile device and enter `https://easynotespwa.github.io` there.
2. Click the `Share` button → `To Home Screen`. A shortcut to EasyNotes will appear on the desktop.

### iOS 9-12
1. Open Safari browser on your mobile device and enter `http://IP:735/webapp`, where IP is the reserved permanent IP of your computer.
2. Click the `Share` button → `Add to Home Screen`. A shortcut to EasyNotes will appear on your desktop.

Also, if you have iOS 6-8, you can use [the old version of the web app](https://github.com/r57zone/EasyNotes/releases/download/0.8.7/EasyNotes.iOS.6-8.support.fix.zip).

### P2P mobile app synchronization (optional, in case of problems)
Check Windows firewall to see if incoming connections are allowed for your network type (private) and allow if disabled.

Next, for Windows, Android and iOS 13+ apps, you can enable automatic IP address search and try to sync. If synchronization does not work or you have an older iOS, try the following:
1. Reserve a permanent IP address for the computer with the Windows app. This is done in the Wi-Fi router settings, in the "DHCP" section.
2. Reserve a permanent IP address for the mobile device and add it, if it is missing, in the Windows app settings. You can also open access for all IP addresses (unsafe). If necessary, delete unnecessary IP addresses.

### Setup web sync
Follow the instructions described [here](https://github.com/r57zone/EasyNotes/tree/master/Source/Web).

## Download
>Versions for Android 7.1+, iOS 9+ and Windows 7+ (with Internet Explorer 11 installed). 

**[Download](https://github.com/r57zone/EasyNotes/releases)**

## Screenshots
### Windows
[![](https://github.com/user-attachments/assets/9195f448-6e8e-4e64-bf9d-7d346bb27d59)](https://github.com/user-attachments/assets/928a044c-921e-4780-aa4b-81c1ab86d89b)
[![](https://github.com/user-attachments/assets/2fd0aed4-fddf-433b-8fe7-78a6759261bb)](https://github.com/user-attachments/assets/21b2a33c-13cd-44fd-a501-1be23a3d7d57)

### Android / iOS
![UI](https://github.com/user-attachments/assets/bbb6e01a-abe3-4b72-bcba-0817f3d88c06)
![HTML Viewer Q](https://github.com/user-attachments/assets/a6988b94-1d23-4497-b5f6-6b46dc8e8115)
![PWA / HTML app](https://github.com/user-attachments/assets/f56a9649-6220-405e-a0e0-a021280c613b)

## Feedback
`r57zone[at]gmail.com`