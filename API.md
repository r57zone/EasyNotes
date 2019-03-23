## Easy Notes API
### In English
| Request | Request type | Description | Example |
| ------------- | ------------- | ------------- | ------------- |
| `IP/getnotes` | GET | Getting a list of identifier (Unix timestamp) and time notes (Unix timestamp with UTC offset). | &lt;notes&gt;&lt;note id="1553287432" datetime="1553301832"&gt;&lt;/note&gt;&lt;note id="1553287428" datetime="1553301828"&gt;&lt;/note&gt;&lt;/notes&gt; |
| `IP/getfullnotes` | GET | Getting a list of ID, notes (in Base64) and time notes. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;note id="1553248570" datetime="1553262970"&gt;Mg==&lt;/note&gt;&lt;/notes&gt; |
| `IP/getnote=ID` | GET | Getting a note by id. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;/notes&gt; |
| `IP/syncnotes` | POST | Sending created and modified notes by the client. | &lt;actions&gt;&lt;insert id="1553285632" datetime="1553300032"&gt;Mw==&lt;/insert&gt;&lt;update id="1553248570" datetime="1553262970"&gt;Mg==&lt;/update&gt;&lt;delete id="1553248570"&gt;&lt;/delete&gt;&lt;/actions&gt; |

Where IP is the address running the application for Windows. Data is received and sending in XML markdown.

### На русском
| Запрос | Тип запроса | Описание | Пример |
| ------------- | ------------- | ------------- | ------------- |
| `IP/getnotes` | GET | Получение списка идентификатора (Unix timestamp) и времени заметки (Unix timestamp с UTC смещением). | &lt;notes&gt;&lt;note id="1553287432" datetime="1553301832"&gt;&lt;/note&gt;&lt;note id="1553287428" datetime="1553301828"&gt;&lt;/note&gt;&lt;/notes&gt; |
| `IP/getfullnotes` | GET | Получение списка идентификатора, заметки (в Base64) и времени заметки. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;note id="1553248570" datetime="1553262970"&gt;Mg==&lt;/note&gt;&lt;/notes&gt; |
| `IP/getnote=ID` | GET | Получение содержимого заметки по идентификатору. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;/notes&gt; |
| `IP/syncnotes` | POST | Отправка созданных и измененных клиентом заметок. | &lt;actions&gt;&lt;insert id="1553285632" datetime="1553300032"&gt;Mw==&lt;/insert&gt;&lt;update id="1553248570" datetime="1553262970"&gt;Mg==&lt;/update&gt;&lt;delete id="1553248570"&gt;&lt;/delete&gt;&lt;/actions&gt; |

Где IP это адрес, с запущенным приложением для Windows. Данные получаются и передаются в разметке XML.