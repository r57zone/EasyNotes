[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/eNotes/) 
[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/eNotes/blob/master/README.RU.md) 
# eNotes
App for notes with sync. The server is a Windows application so you need to run it for synch. For Android at the moment there is no application.

## Setup
To correctly display the Windows interface of the application run the file "ie11_enable.reg".

### Sync of the mobile client
1. Reserve a fixed IP address for a computer with a Windows application. This is done in the settings of the Wi-Fi router in the DHCP section.
2. Reserve the permanent IP address of the iOS device and paste its IP address into the "Allow.txt" file to block access to other devices or insert the word "ALL" to open access for all IP addresses.
3. Find out the local IP address of your Windows computer. This can be done, for example, on the command line, by entering the "ipconfig" command or in the Windows settings.
4. Go to Safari on your iOS device and enter there "IP/webapp", where IP is the reserved permanent IP of your computer. Next you need to click "Share" -> "On the Home Screen". A shortcut to EasyNotes appears on the desktop.

## Screenshot
### Windows
![](https://user-images.githubusercontent.com/9499881/54496688-d6e04280-490b-11e9-9c08-9e8b13d96cc8.PNG)

### iOS
![Setup](https://user-images.githubusercontent.com/9499881/54852962-d2e76280-4d07-11e9-841a-06d50fafb3c4.gif)
![](https://user-images.githubusercontent.com/9499881/54852821-6ff5cb80-4d07-11e9-889f-2858175af05a.PNG)
![](https://user-images.githubusercontent.com/9499881/54852979-e1ce1500-4d07-11e9-8c0a-91dca563fcf7.PNG)

## Download
>Version for Windows 7, 8.1, 10.

**[Download](https://github.com/r57zone/eNotes/releases)**

## API
| Request | Request type | Description | Example |
| ------------- | ------------- | ------------- | ------------- |
| `IP/getnotes` | GET | Getting a list of identifier (Unix timestamp) and time notes (Unix timestamp with UTC offset). | &lt;notes&gt;&lt;note id="1553287432" datetime="1553301832"&gt;&lt;/note&gt;&lt;note id="1553287428" datetime="1553301828"&gt;&lt;/note&gt;&lt;/notes&gt; |
| `IP/getfullnotes` | GET | Getting a list of ID, notes (in Base64) and time notes. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;note id="1553248570" datetime="1553262970"&gt;Mg==&lt;/note&gt;&lt;/notes&gt; |
| `IP//getnote=ID` | GET | Getting a note by id. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;/notes&gt; |
| `IP/syncnotes` | POST | Sending created and modified notes by the client. | &lt;notes&gt;&lt;insert id="1553285632" datetime="1553300032"&gt;Mw==&lt;/insert&gt;&lt;update id="1553248570" datetime="1553262970"&gt;Mg==&lt;/update&gt;&lt;delete id="1553248570"&gt;&lt;/delete&gt;&lt;/notes&gt; |
Where IP is the address running the application for Windows. Data is received and sending in XML markdown.

## Feedback
`r57zone[at]gmail.com`