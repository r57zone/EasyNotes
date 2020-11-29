## Easy Notes API
### In English
The Windows app is a notes server. The data is sent in XML markup. The text of the note is converted into a sequence of characters - "x" + character number. For example, the word "Hello" is converted to "x72x101x108x108x111".

| Request | Request type | Description | Value / Status |
| ------------- | ------------- | ------------- | ------------- |
| `IP:PORT/api/connecttest` | GET | Getting the server availability status. | "ok" |
| `IP:PORT/api/auth?id=DEVICE` | GET | Request to add to the list of authorized devices. | "auth:ok" or "auth:denied" |
| `IP:PORT/api/notes?id=DEVICE` | GET | Getting a list with identifiers (Unix timestamp), notes and note times (Unix timestamp with UTC offset). | &lt;notes&gt;<br>&lt;note id="1553285632" datetime="1553300032"&gt;x72x101x108x108x111&lt;/note&gt;<br>&lt;note id="1553248570" datetime="1553262970"&gt;x72x101x108x108x111&lt;/note&gt;<br>&lt;/notes&gt; |
| `IP:PORT/api/actions?id=DEVICE` | GET | Receiving new changes from the server. | &lt;actions&gt;<br>&lt;insert id="1553285632" datetime="1553300032"&gt;x72x101x108x108x111&lt;/insert&gt;<br>&lt;update id="1553248570" datetime="1553262970"&gt;x72x101x108x108x111&lt;/update&gt;<br>&lt;delete id="1553248570"&gt;&lt;/delete&gt;<br>&lt;/actions&gt; |
| `IP:PORT/api/received?id=DEVICE` | GET | Confirmation of receiving new changes from the server. | "ok" or "auth:denied" |
| `IP:PORT/api/syncnotes?id=DEVICE` | POST | Sending new changes from the client. | &lt;actions&gt;<br>&lt;insert id="1553285632" datetime="1553300032"&gt;x72x101x108x108x111&lt;/insert&gt;<br>&lt;update id="1553248570" datetime="1553262970"&gt;x72x101x108x108x111&lt;/update&gt;<br>&lt;delete id="1553248570"&gt;&lt;/delete&gt;<br>&lt;/actions&gt; |

`IP` is the address running the application for Windows. The default port is 735. `DEVICE` is the name of the device, for example `Android_g9N1z5S2` or `iOS_rM5s3Gz7`.

### На русском
Приложение для Windows является сервером заметок. Данные пересылаются в XML разметке. Текст заметки конвертируется в последовательность символов - "x" + номер символа. Например, слово "Привет" конвертируется в "x1055x1088x1080x1074x1077x1090".

| Запрос | Тип запроса | Описание | Значение / Статус |
| ------------- | ------------- | ------------- | ------------- |
| `IP:PORT/api/connecttest` | GET | Получение статуса доступности сервера. | "ok" |
| `IP:PORT/api/auth?id=DEVICE` | GET | Запрос на добавление в список авторизованных устройств. | "auth:ok" или "auth:denied" |
| `IP:PORT/api/notes?id=DEVICE` | GET | Получение списка с идентификаторами (Unix timestamp), заметками и временем заметок (Unix timestamp с UTC смещением). | &lt;notes&gt;<br>&lt;note id="1553285632" datetime="1553300032"&gt;x72x101x108x108x111&lt;/note&gt;<br>&lt;note id="1553248570" datetime="1553262970"&gt;x72x101x108x108x111&lt;/note&gt;<br>&lt;/notes&gt; |
| `IP:PORT/api/actions?id=DEVICE` | GET | Получение новых изменений от сервера. | &lt;actions&gt;<br>&lt;insert id="1553285632" datetime="1553300032"&gt;x72x101x108x108x111&lt;/insert&gt;<br>&lt;update id="1553248570" datetime="1553262970"&gt;x72x101x108x108x111&lt;/update&gt;<br>&lt;delete id="1553248570"&gt;&lt;/delete&gt;<br>&lt;/actions&gt; |
| `IP:PORT/api/received?id=DEVICE` | GET | Подтверждение получения новых изменений от сервера. | "ok" или "auth:denied" |
| `IP:PORT/api/syncnotes?id=DEVICE` | POST | Отправка новых изменений от клиента. | &lt;actions&gt;<br>&lt;insert id="1553285632" datetime="1553300032"&gt;x72x101x108x108x111&lt;/insert&gt;<br>&lt;update id="1553248570" datetime="1553262970"&gt;x72x101x108x108x111&lt;/update&gt;<br>&lt;delete id="1553248570"&gt;&lt;/delete&gt;<br>&lt;/actions&gt; |

`IP` это адрес, с запущенным приложением для Windows. Порт по умолчанию 735. `DEVICE` это название устройства, например, `Android_g9N1z5S2` или `iOS_rM5s3Gz7`.