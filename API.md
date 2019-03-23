## Easy Notes API
### In English
Data is received and sending in XML markdown. Notes are converted to a sequence of x values + character number. For example, the word "Hello" is converted to "x72x101x108x108x111".

| Request | Request type | Description | Example |
| ------------- | ------------- | ------------- | ------------- |
| `IP/getnotes` | GET | Getting a list of identifier (Unix timestamp) and time notes (Unix timestamp with UTC offset). | &lt;notes&gt;&lt;note id="1553287432" datetime="1553301832"&gt;&lt;/note&gt;&lt;note id="1553287428" datetime="1553301828"&gt;&lt;/note&gt;&lt;/notes&gt; |
| `IP/getfullnotes` | GET | Getting a list of ID, notes and time notes. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;note id="1553248570" datetime="1553262970"&gt;Mg==&lt;/note&gt;&lt;/notes&gt; |
| `IP/getnote=ID` | GET | Getting a note by id. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;/notes&gt; |
| `IP/syncnotes` | POST | Sending created and modified notes by the client. | &lt;actions&gt;&lt;insert id="1553285632" datetime="1553300032"&gt;Mw==&lt;/insert&gt;&lt;update id="1553248570" datetime="1553262970"&gt;Mg==&lt;/update&gt;&lt;delete id="1553248570"&gt;&lt;/delete&gt;&lt;/actions&gt; |

IP is the address running the application for Windows. 

### На русском
Данные получаются и передаются в разметке XML. Заметки конвертируются в последовательность значений "x" + номер символа. Например, слово "Привет" конвертируется в "x1055x1088x1080x1074x1077x1090".

| Запрос | Тип запроса | Описание | Пример |
| ------------- | ------------- | ------------- | ------------- |
| `IP/getnotes` | GET | Получение списка идентификатора (Unix timestamp) и времени заметки (Unix timestamp с UTC смещением). | &lt;notes&gt;&lt;note id="1553287432" datetime="1553301832"&gt;&lt;/note&gt;&lt;note id="1553287428" datetime="1553301828"&gt;&lt;/note&gt;&lt;/notes&gt; |
| `IP/getfullnotes` | GET | Получение списка идентификатора, заметки и времени заметки. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;note id="1553248570" datetime="1553262970"&gt;Mg==&lt;/note&gt;&lt;/notes&gt; |
| `IP/getnote=ID` | GET | Получение содержимого заметки по идентификатору. | &lt;notes&gt;&lt;note id="1553285632" datetime="1553300032"&gt;Mw==&lt;/note&gt;&lt;/notes&gt; |
| `IP/syncnotes` | POST | Отправка созданных и измененных клиентом заметок. | &lt;actions&gt;&lt;insert id="1553285632" datetime="1553300032"&gt;Mw==&lt;/insert&gt;&lt;update id="1553248570" datetime="1553262970"&gt;Mg==&lt;/update&gt;&lt;delete id="1553248570"&gt;&lt;/delete&gt;&lt;/actions&gt; |

IP это адрес, с запущенным приложением для Windows.