// Перевод, по умолчанию English
let IDS_MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
let IDS_DAYOFWEEK = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
let IDS_TODAY = 'Today';
let IDS_YESTERDAY = 'Yesterday';
let IDS_DAYSAGO = 'days ago';
let IDS_NEW_NOTE = 'New note';
let IDS_NOTES = 'Notes';
let IDS_SEARCH = 'Search...';

// Настройки
let IDS_SETTINGS = 'Settings';
let IDS_SYNC_ADDRESS = 'IP or domain';
let IDS_SYNC_PORT = 'Port';
let IDS_AUTOSEARCH_IP = 'Autosearch IP address';
let IDS_ABOUT_SYNC = 'IP and port or domain to sync notes with your PC or web server.';
let IDS_AUTO_SYNC = 'Sync at startup';
let IDS_ABOUT_AUTO_SYNC = 'Automatically sync on app launch.';

// Для всех
let IDS_FULL_RESET = 'Full reset';
let IDS_CONFIRM_FULL_RESET = 'Do you really want to reset everything? All notes and settings will be deleted.';
let IDS_DARK_THEME = 'Dark theme';
let IDS_THEME_TIME_DEPENDENT = 'Theme is time dependent';
let IDS_DARK_THEME_START = 'Dark theme start';
let IDS_DARK_THEME_END = 'Dark theme end';
let IDS_ABOUT_THEME_TIME = 'The dark theme is enabled automatically by time. Specify the time in 24-hour format.';
let IDS_CATEGORIES = 'Categories';
let IDS_CATEGORIES_LIST = '#Shopping\n#Ideas\n#Work\n#Projects\n#Family\n#Health\n#Finances\n#Education\n#Travel\n#Hobbies\n#Personal';
let IDS_LAST_UPDATE = 'Last update: ';
let IDS_LOCAL_STORAGE = 'Local storage: %s of 5000 KB';

// Уведомления
let IDS_DATE_UPDATE = 'Date will be update';
let IDS_DATE_NOT_UPDATE = 'Date will not be update';
let IDS_AUTH_REJECT = 'Authorization rejected';
let IDS_SYNC_SUCCESSFUL = 'Sync successful';
let IDS_SYNC_ERROR = 'Sync error';
let IDS_SYNC_NEED_CONNECT = 'Need connect to the network for sync';
let IDS_CONNECTION_FAILED = 'Connection failed';

// Русский язык
if (navigator.language.toLowerCase() == 'ru-ru' || navigator.language == 'ru') { // В iOS языки прописными буквами, вторая проверка нужна для Edge
	IDS_MONTHS = ['янв.', 'фев.', 'мар.', 'апр.', 'май', 'июн.', 'июл.', 'авг.', 'сен.', 'окт.', 'ноя.', 'дек.'];
	IDS_DAYOFWEEK = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'];
	IDS_TODAY = 'Сегодня';
	IDS_YESTERDAY = 'Вчера';
	IDS_DAYSAGO = 'дн. назад';
	IDS_NEW_NOTE = 'Новая заметка';
	IDS_NOTES = 'Заметки';
	IDS_SEARCH = 'Поиск...';
	
	// Настройки
	IDS_SETTINGS = 'Настройки';
	IDS_SYNC_ADDRESS = 'IP или домен';
	IDS_SYNC_PORT = 'Порт';
	IDS_AUTOSEARCH_IP = 'Автопоиск IP адреса';
	IDS_ABOUT_SYNC = 'IP адрес и порт или домен для синхронизации заметок, с вашим ПК или веб-сервером.';
	IDS_AUTO_SYNC = 'Синхронизация при запуске';
	IDS_ABOUT_AUTO_SYNC = 'Автоматическая синхронизация при запуске приложения.';
	
	// Для всех
	IDS_FULL_RESET = 'Полный сброс';
	IDS_CONFIRM_FULL_RESET = 'Вы действительно хотите сбросить всё? Все заметки и настройки будут удалены.';
	IDS_DARK_THEME = 'Темная тема';
	IDS_THEME_TIME_DEPENDENT = 'Тема в зависимости от времени';
	IDS_DARK_THEME_START = 'Начало тёмной темы';
	IDS_DARK_THEME_END = 'Конец тёмной темы';
	IDS_ABOUT_THEME_TIME = 'Тёмная тема включается автоматически по времени. Укажите часы в 24-часовом формате.';
	IDS_CATEGORIES = 'Категории';
	IDS_CATEGORIES_LIST = '#Покупки\n#Идеи\n#Работа\n#Проекты\n#Семья\n#Здоровье\n#Финансы\n#Учеба\n#Путешествия\n#Хобби\n#Личное';
	IDS_LAST_UPDATE = 'Последнее обновление: ';
	IDS_LOCAL_STORAGE = 'Локальное хранилище: %s из 5000 Кб';
	
	// Уведомления
	IDS_DATE_UPDATE = 'Дата обновится';
	IDS_DATE_NOT_UPDATE = 'Дата не обновится';
	IDS_AUTH_REJECT = 'Авторизация отклонена';
	IDS_SYNC_SUCCESSFUL = 'Синхронизация успешно завершена';
	IDS_SYNC_ERROR = 'Ошибка синхронизации';
	IDS_SYNC_NEED_CONNECT = 'Для синхронизации нужно<br>подключиться к сети';
	IDS_CONNECTION_FAILED = 'Cоединение не удалось';

// Chinese
} else if (navigator.language.toLowerCase() == 'zh-cn' || navigator.language == 'zh-tw' || navigator.language == 'zh') {
	IDS_MONTHS = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'];
	IDS_DAYOFWEEK = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期天'];
	IDS_TODAY = '今天';
	IDS_YESTERDAY = '昨天';
	IDS_DAYSAGO = '天前';
	IDS_NEW_NOTE = '新笔记';
	IDS_NOTES = '笔记';
	IDS_SEARCH = '搜索...';
	
	// 设置
	IDS_SETTINGS = '设置';
	IDS_SYNC_ADDRESS = 'IP 或 域名';
	IDS_SYNC_PORT = '端口';
	IDS_AUTOSEARCH_IP = '自动搜索 IP 地址';
	IDS_ABOUT_SYNC = '用于同步笔记的 IP 地址和端口或域名，与你的 PC 或网站服务器同步。';
	IDS_AUTO_SYNC = '启动时同步';
	IDS_ABOUT_AUTO_SYNC = '在启动应用时自动同步。';
	
	// 对所有人
	IDS_FULL_RESET = '完全重置';
	IDS_CONFIRM_FULL_RESET = '你确定要重置所有内容吗？所有笔记和设置将被删除。';
	IDS_DARK_THEME = '黑暗主题';
	IDS_THEME_TIME_DEPENDENT = '根据时间设置主题';
	IDS_DARK_THEME_START = '黑暗主题开始';
	IDS_DARK_THEME_END = '黑暗主题结束';
	IDS_ABOUT_THEME_TIME = '黑暗主题会根据时间自动启用。请以 24 小时格式指定时间。';
	IDS_CATEGORIES = '类别';
	IDS_CATEGORIES_LIST = '#购物\n#创意\n#工作\n#项目\n#家庭\n#健康\n#财务\n#学习\n#旅行\n#爱好\n#个人';
	IDS_LAST_UPDATE = '最后更新时间：';
	IDS_LOCAL_STORAGE = '本地存储：%s / 5000 KB';
	
	// 通知
	IDS_DATE_UPDATE = '日期将更新';
	IDS_DATE_NOT_UPDATE = '日期不会更新';
	IDS_AUTH_REJECT = '授权被拒绝';
	IDS_SYNC_SUCCESSFUL = '同步成功';
	IDS_SYNC_ERROR = '同步错误';
	IDS_SYNC_NEED_CONNECT = '需要连接到网络才能同步';
	IDS_CONNECTION_FAILED = '连接失败';

// Spanish
} else if (navigator.language.toLowerCase() == 'es-es' || navigator.language == 'es') {
	IDS_MONTHS = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Set', 'Oct', 'Nov', 'Dic'];
	IDS_DAYOFWEEK = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
	IDS_TODAY = 'Hoy';
	IDS_YESTERDAY = 'Ayer';
	IDS_DAYSAGO = 'días atrás';
	IDS_NEW_NOTE = 'Nueva nota';
	IDS_NOTES = 'Notas';

	IDS_SETTINGS = 'Configuración';
	IDS_SYNC_ADDRESS = 'IP o dominio';
	IDS_SYNC_PORT = 'Puerto';
	IDS_AUTOSEARCH_IP = 'Buscar dirección IP automáticamente';
	IDS_ABOUT_SYNC = 'IP y puerto o dominio para sincronizar notas con tu PC o servidor web.';
	IDS_AUTO_SYNC = 'Sincronizar al inicio';
	IDS_ABOUT_AUTO_SYNC = 'Sincronizar automáticamente al iniciar la aplicación.';

	IDS_FULL_RESET = 'Restablecer';
	IDS_CONFIRM_FULL_RESET = 'Realmente deseas restablecer todo? Todas las notas y ajustes serán eliminados.';
	IDS_DARK_THEME = 'Tema oscuro';
	IDS_THEME_TIME_DEPENDENT = 'Tema es dependiente del tiempo';
	IDS_DARK_THEME_START = 'Inicio del tema oscuro';
	IDS_DARK_THEME_END = 'Fin del tema oscuro';
	IDS_ABOUT_THEME_TIME = 'El tema oscuro se activa automáticamente según la hora. Indique la hora en formato de 24 horas.';
	IDS_CATEGORIES = 'Categorías';
	IDS_CATEGORIES_LIST = '#Compras\n#Ideas\n#Trabajo\n#Proyectos\n#Familia\n#Salud\n#Finanzas\n#Estudios\n#Viajes\n#Aficiones\n#Personal';
	IDS_LAST_UPDATE = 'Última actualización: ';
	IDS_LOCAL_STORAGE = 'Almacenamiento local: %s de 5000 KB';

	IDS_DATE_UPDATE = 'La fecha se actualizará';
	IDS_DATE_NOT_UPDATE = 'La fecha no se actualizará';
	IDS_AUTH_REJECT = 'Autorización rechazada';
	IDS_SYNC_SUCCESSFUL = 'Sincronización exitosa';
	IDS_SYNC_ERROR = 'Error de sincronización';
	IDS_SYNC_NEED_CONNECT = 'Necesita conectarse a la red para sincronizar';
	IDS_CONNECTION_FAILED = 'Error de conexión';
	
// Portuguese (Brazilian Portuguese)
} else if (navigator.language.toLowerCase() == 'pt-br' || navigator.language == 'pt') {
	IDS_MONTHS = ['jan.', 'fev.', 'mar.', 'abr.', 'mai', 'jun.', 'jul.', 'ago.', 'set.', 'out.', 'nov.', 'dez.'];
	IDS_DAYOFWEEK = ['Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado', 'Domingo'];
	IDS_TODAY = 'Hoje';
	IDS_YESTERDAY = 'Ontem';
	IDS_DAYSAGO = 'dias atrás';
	IDS_NEW_NOTE = 'Nova nota';
	IDS_NOTES = 'Notas';
	IDS_SEARCH = 'Buscar...';
	
	// Configurações
	IDS_SETTINGS = 'Configurações';
	IDS_SYNC_ADDRESS = 'IP ou domínio';
	IDS_SYNC_PORT = 'Porta';
	IDS_AUTOSEARCH_IP = 'Busca automática de IP';
	IDS_ABOUT_SYNC = 'Endereço IP e porta ou domínio para sincronizar as notas com seu PC ou servidor web.';
	IDS_AUTO_SYNC = 'Sincronização ao iniciar';
	IDS_ABOUT_AUTO_SYNC = 'Sincronização automática ao iniciar o aplicativo.';
	
	// Para todos
	IDS_FULL_RESET = 'Redefinição total';
	IDS_CONFIRM_FULL_RESET = 'Você realmente deseja redefinir tudo? Todas as notas e configurações serão excluídas.';
	IDS_DARK_THEME = 'Tema escuro';
	IDS_THEME_TIME_DEPENDENT = 'Tema dependendo da hora';
	IDS_DARK_THEME_START = 'Início do tema escuro';
	IDS_DARK_THEME_END = 'Fim do tema escuro';
	IDS_ABOUT_THEME_TIME = 'O tema escuro é ativado automaticamente com base no horário. Informe a hora no formato de 24 horas.';
	IDS_CATEGORIES = 'Categorias';
	IDS_CATEGORIES_LIST = '#Compras\n#Ideias\n#Trabalho\n#Projetos\n#Família\n#Saúde\n#Finanças\n#Estudos\n#Viagens\n#Hobbies\n#Pessoal';
	IDS_LAST_UPDATE = 'Última atualização: ';
	IDS_LOCAL_STORAGE = 'Armazenamento local: %s de 5000 KB';
	
	// Notificações
	IDS_DATE_UPDATE = 'Data será atualizada';
	IDS_DATE_NOT_UPDATE = 'Data não será atualizada';
	IDS_AUTH_REJECT = 'Autenticação rejeitada';
	IDS_SYNC_SUCCESSFUL = 'Sincronização concluída com sucesso';
	IDS_SYNC_ERROR = 'Erro de sincronização';
	IDS_SYNC_NEED_CONNECT = 'Para sincronizar, é necessário<br>conectar à rede';
	IDS_CONNECTION_FAILED = 'Falha na conexão'; 

// French
} else if (navigator.language.toLowerCase() == 'fr' || navigator.language == 'fr-fr') {
	IDS_MONTHS = ['janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin', 'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.'];
	IDS_DAYOFWEEK = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
	IDS_TODAY = 'Aujourd\'hui';
	IDS_YESTERDAY = 'Hier';
	IDS_DAYSAGO = 'jours avant';
	IDS_NEW_NOTE = 'Nouvelle note';
	IDS_NOTES = 'Notes';
	IDS_SEARCH = 'Recherche...';
	
	// Paramètres
	IDS_SETTINGS = 'Paramètres';
	IDS_SYNC_ADDRESS = 'IP ou domaine';
	IDS_SYNC_PORT = 'Port';
	IDS_AUTOSEARCH_IP = 'Recherche automatique de l\'IP';
	IDS_ABOUT_SYNC = 'Adresse IP et port ou domaine pour synchroniser les notes avec votre PC ou serveur web.';
	IDS_AUTO_SYNC = 'Synchronisation au démarrage';
	IDS_ABOUT_AUTO_SYNC = 'Synchronisation automatique au démarrage de l\'application.';
	
	// Pour tous
	IDS_FULL_RESET = 'Réinitialisation complète';
	IDS_CONFIRM_FULL_RESET = 'Voulez-vous vraiment réinitialiser tout ? Toutes les notes et paramètres seront supprimés.';
	IDS_DARK_THEME = 'Thème sombre';
	IDS_THEME_TIME_DEPENDENT = 'Thème selon l\'heure';
	IDS_DARK_THEME_START = 'Début du thème sombre';
	IDS_DARK_THEME_END = 'Fin du thème sombre';
	IDS_ABOUT_THEME_TIME = 'Le thème sombre est activé automatiquement en fonction de l\'heure. Indiquez l\'heure au format 24 heures.';
	IDS_CATEGORIES = 'Catégories';
	IDS_CATEGORIES_LIST = '#Achats\n#Idées\n#Travail\n#Projets\n#Famille\n#Santé\n#Finances\n#Études\n#Voyages\n#Loisirs\n#Personnel';
	IDS_LAST_UPDATE = 'Dernière mise à jour : ';
	IDS_LOCAL_STORAGE = 'Stockage local : %s sur 5000 Ko';
	
	// Notifications
	IDS_DATE_UPDATE = 'La date sera mise à jour';
	IDS_DATE_NOT_UPDATE = 'La date ne sera pas mise à jour';
	IDS_AUTH_REJECT = 'Authentification rejetée';
	IDS_SYNC_SUCCESSFUL = 'Synchronisation réussie';
	IDS_SYNC_ERROR = 'Erreur de synchronisation';
	IDS_SYNC_NEED_CONNECT = 'Pour synchroniser, vous devez<br>vous connecter au réseau';
	IDS_CONNECTION_FAILED = 'Échec de la connexion'; 
	
// German
} else if (navigator.language.toLowerCase() == 'de-de' || navigator.language == 'de') {
	IDS_MONTHS = ['Jan.', 'Feb.', 'März', 'Apr.', 'Mai', 'Juni', 'Juli', 'Aug.', 'Sept.', 'Okt.', 'Nov.', 'Dez.'];
	IDS_DAYOFWEEK = ['Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag'];
	IDS_TODAY = 'Heute';
	IDS_YESTERDAY = 'Gestern';
	IDS_DAYSAGO = 'Tg. her';
	IDS_NEW_NOTE = 'Neue Notiz';
	IDS_NOTES = 'Notizen';
	IDS_SEARCH = 'Suche...';

	IDS_SETTINGS = 'Einstellungen';
	IDS_SYNC_ADDRESS = 'IP oder Domain';
	IDS_SYNC_PORT = 'Port';
	IDS_AUTOSEARCH_IP = 'IP-Adresse automatisch suchen';
	IDS_ABOUT_SYNC = 'IP-Adresse und Port oder Domain zur Synchronisierung von Notizen mit Ihrem PC oder Webserver.';
	IDS_AUTO_SYNC = 'Synchronisierung beim Start';
	IDS_ABOUT_AUTO_SYNC = 'Automatische Synchronisierung beim Start der Anwendung.';

	IDS_FULL_RESET = 'Komplett zurücksetzen';
	IDS_CONFIRM_FULL_RESET = 'Sind Sie sicher, dass Sie alles zurücksetzen möchten? Alle Notizen und Einstellungen werden gelöscht.';
	IDS_DARK_THEME = 'Dunkles Thema';
	IDS_THEME_TIME_DEPENDENT = 'Thema abhängig von der Zeit';
	IDS_DARK_THEME_START = 'Beginn des Dunkelmodus';
	IDS_DARK_THEME_END = 'Ende des Dunkelmodus';
	IDS_ABOUT_THEME_TIME = 'Das dunkle Design wird automatisch mit der Zeit aktiviert. Geben Sie die Uhrzeit im 24-Stunden-Format an.';
	IDS_CATEGORIES = 'Kategorien';
	IDS_CATEGORIES_LIST = '#Einkäufe\n#Ideen\n#Arbeit\n#Projekte\n#Familie\n#Gesundheit\n#Finanzen\n#Studium\n#Reisen\n#Hobbys\n#Persönlich';
	IDS_LAST_UPDATE = 'Letzte Aktualisierung: ';
	IDS_LOCAL_STORAGE = 'Lokaler Speicher: %s von 5000 KB';

	IDS_DATE_UPDATE = 'Datum wird aktualisiert';
	IDS_DATE_NOT_UPDATE = 'Datum wird nicht aktualisiert';
	IDS_AUTH_REJECT = 'Authentifizierung abgelehnt';
	IDS_SYNC_SUCCESSFUL = 'Synchronisierung erfolgreich abgeschlossen';
	IDS_SYNC_ERROR = 'Synchronisierungsfehler';
	IDS_SYNC_NEED_CONNECT = 'Zur Synchronisierung<br>müssen Sie sich verbinden';
	IDS_CONNECTION_FAILED = 'Verbindung fehlgeschlagen';

// Japanese
} else if (navigator.language.toLowerCase() == 'ja' || navigator.language == 'ja-jp') {
	IDS_MONTHS = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
	IDS_DAYOFWEEK = ['月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日', '日曜日'];
	IDS_TODAY = '今日';
	IDS_YESTERDAY = '昨日';
	IDS_DAYSAGO = '日前';
	IDS_NEW_NOTE = '新しいメモ';
	IDS_NOTES = 'メモ';
	IDS_SEARCH = '検索...';
	
	// 設定
	IDS_SETTINGS = '設定';
	IDS_SYNC_ADDRESS = 'IP または ドメイン';
	IDS_SYNC_PORT = 'ポート';
	IDS_AUTOSEARCH_IP = 'IPアドレスの自動検索';
	IDS_ABOUT_SYNC = 'ノートをPCまたはウェブサーバーと同期するためのIPアドレスとポートまたはドメイン。';
	IDS_AUTO_SYNC = '起動時同期';
	IDS_ABOUT_AUTO_SYNC = 'アプリケーション起動時に自動的に同期します。';
	
	// 全ての設定
	IDS_FULL_RESET = '完全リセット';
	IDS_CONFIRM_FULL_RESET = '本当にすべてリセットしますか？すべてのメモと設定が削除されます。';
	IDS_DARK_THEME = 'ダークテーマ';
	IDS_THEME_TIME_DEPENDENT = '時間帯によるテーマ';
	IDS_DARK_THEME_START = 'ダークテーマの開始';
	IDS_DARK_THEME_END = 'ダークテーマの終了';
	IDS_ABOUT_THEME_TIME = 'ダークテーマは自動的に時間に基づいて有効になります。24時間形式で時間を指定してください。';
	IDS_CATEGORIES = 'カテゴリー';
	IDS_CATEGORIES_LIST = '#買い物\n#アイデア\n#仕事\n#プロジェクト\n#家族\n#健康\n#財務\n#勉強\n#旅行\n#趣味\n#個人的';
	IDS_LAST_UPDATE = '最終更新: ';
	IDS_LOCAL_STORAGE = 'ローカルストレージ: %s / 5000 KB';
	
	// 通知
	IDS_DATE_UPDATE = '日付が更新されます';
	IDS_DATE_NOT_UPDATE = '日付は更新されません';
	IDS_AUTH_REJECT = '認証が拒否されました';
	IDS_SYNC_SUCCESSFUL = '同期が成功しました';
	IDS_SYNC_ERROR = '同期エラー';
	IDS_SYNC_NEED_CONNECT = '同期するには<br>ネットワークに接続する必要があります';
	IDS_CONNECTION_FAILED = '接続に失敗しました'; 

// Arabic
} else if (navigator.language.toLowerCase() == 'ar' || navigator.language == 'ar-sa') {
	IDS_MONTHS = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
	IDS_DAYOFWEEK = ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
	IDS_TODAY = 'اليوم';
	IDS_YESTERDAY = 'أمس';
	IDS_DAYSAGO = 'منذ أيام';
	IDS_NEW_NOTE = 'ملاحظة جديدة';
	IDS_NOTES = 'الملاحظات';
	IDS_SEARCH = 'بحث...';
	
	// الإعدادات
	IDS_SETTINGS = 'الإعدادات';
	IDS_SYNC_ADDRESS = 'IP أو نطاق';
	IDS_SYNC_PORT = 'المنفذ';
	IDS_AUTOSEARCH_IP = 'البحث التلقائي عن عنوان IP';
	IDS_ABOUT_SYNC = 'عنوان IP والمنفذ أو النطاق لمزامنة الملاحظات مع جهاز الكمبيوتر أو الخادم الويب الخاص بك.';
	IDS_AUTO_SYNC = 'المزامنة عند بدء التشغيل';
	IDS_ABOUT_AUTO_SYNC = 'المزامنة التلقائية عند تشغيل التطبيق.';
	
	// للجميع
	IDS_FULL_RESET = 'إعادة ضبط كاملة';
	IDS_CONFIRM_FULL_RESET = 'هل ترغب حقًا في إعادة ضبط كل شيء؟ سيتم حذف جميع الملاحظات والإعدادات.';
	IDS_DARK_THEME = 'السمة الداكنة';
	IDS_THEME_TIME_DEPENDENT = 'السمة حسب الوقت';
	IDS_DARK_THEME_START = 'بداية السمة الداكنة';
	IDS_DARK_THEME_END = 'نهاية السمة الداكنة';
	IDS_ABOUT_THEME_TIME = 'يتم تفعيل السمة الداكنة تلقائيًا وفقًا للوقت. حدد الساعة بتنسيق 24 ساعة.';
	IDS_CATEGORIES = 'الفئات';
	IDS_CATEGORIES_LIST = '#التسوق\n#أفكار\n#عمل\n#مشاريع\n#عائلة\n#صحة\n#المالية\n#دراسة\n#سفر\n#هوايات\n#شخصي';
	IDS_LAST_UPDATE = 'آخر تحديث: ';
	IDS_LOCAL_STORAGE = 'التخزين المحلي: %s من 5000 كيلوبايت';
	
	// الإشعارات
	IDS_DATE_UPDATE = 'سيتم تحديث التاريخ';
	IDS_DATE_NOT_UPDATE = 'لن يتم تحديث التاريخ';
	IDS_AUTH_REJECT = 'تم رفض المصادقة';
	IDS_SYNC_SUCCESSFUL = 'تمت المزامنة بنجاح';
	IDS_SYNC_ERROR = 'خطأ في المزامنة';
	IDS_SYNC_NEED_CONNECT = 'لإجراء المزامنة، يجب<br>الاتصال بالشبكة';
	IDS_CONNECTION_FAILED = 'فشل الاتصال'; 

// Italian
} else if (navigator.language.toLowerCase() == 'it' || navigator.language == 'it-it') {
	IDS_MONTHS = ['gen.', 'feb.', 'mar.', 'apr.', 'mag.', 'giu.', 'lug.', 'ago.', 'set.', 'ott.', 'nov.', 'dic.'];
	IDS_DAYOFWEEK = ['Lunedì', 'Martedì', 'Mercoledì', 'Giovedì', 'Venerdì', 'Sabato', 'Domenica'];
	IDS_TODAY = 'Oggi';
	IDS_YESTERDAY = 'Ieri';
	IDS_DAYSAGO = 'giorni fa';
	IDS_NEW_NOTE = 'Nuova nota';
	IDS_NOTES = 'Note';
	IDS_SEARCH = 'Cerca...';
	
	// Impostazioni
	IDS_SETTINGS = 'Impostazioni';
	IDS_SYNC_ADDRESS = 'IP o dominio';
	IDS_SYNC_PORT = 'Porta';
	IDS_AUTOSEARCH_IP = 'Ricerca automatica IP';
	IDS_ABOUT_SYNC = 'Indirizzo IP e porta o dominio per sincronizzare le note con il tuo PC o server web.';
	IDS_AUTO_SYNC = 'Sincronizzazione all\'avvio';
	IDS_ABOUT_AUTO_SYNC = 'Sincronizzazione automatica all\'avvio dell\'applicazione.';
	
	// Per tutti
	IDS_FULL_RESET = 'Ripristino completo';
	IDS_CONFIRM_FULL_RESET = 'Vuoi davvero ripristinare tutto? Tutte le note e le impostazioni verranno eliminate.';
	IDS_DARK_THEME = 'Tema scuro';
	IDS_THEME_TIME_DEPENDENT = 'Tema in base all\'ora';
	IDS_DARK_THEME_START = 'Inizio tema scuro';
	IDS_DARK_THEME_END = 'Fine tema scuro';
	IDS_ABOUT_THEME_TIME = 'Il tema scuro si attiva automaticamente in base all\'ora. Inserisci l\'ora nel formato 24 ore.';
	IDS_CATEGORIES = 'Categorie';
	IDS_CATEGORIES_LIST = '#Shopping\n#Idee\n#Lavoro\n#Progetti\n#Famiglia\n#Salute\n#Finanze\n#Studio\n#Viaggi\n#Hobby\n#Personale';
	IDS_LAST_UPDATE = 'Ultimo aggiornamento: ';
	IDS_LOCAL_STORAGE = 'Archiviazione locale: %s su 5000 KB';
	
	// Notifiche
	IDS_DATE_UPDATE = 'La data verrà aggiornata';
	IDS_DATE_NOT_UPDATE = 'La data non verrà aggiornata';
	IDS_AUTH_REJECT = 'Autenticazione rifiutata';
	IDS_SYNC_SUCCESSFUL = 'Sincronizzazione riuscita';
	IDS_SYNC_ERROR = 'Errore di sincronizzazione';
	IDS_SYNC_NEED_CONNECT = 'Per sincronizzare, è necessario<br>connettersi alla rete';
	IDS_CONNECTION_FAILED = 'Connessione fallita'; 

// Korean
} else if (navigator.language.toLowerCase() == 'ko' || navigator.language == 'ko-kr') {
	IDS_MONTHS = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
	IDS_DAYOFWEEK = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
	IDS_TODAY = '오늘';
	IDS_YESTERDAY = '어제';
	IDS_DAYSAGO = '일 전';
	IDS_NEW_NOTE = '새 메모';
	IDS_NOTES = '메모';
	IDS_SEARCH = '검색...';
	
	// 설정
	IDS_SETTINGS = '설정';
	IDS_SYNC_ADDRESS = 'IP 또는 도메인';
	IDS_SYNC_PORT = '포트';
	IDS_AUTOSEARCH_IP = 'IP 자동 검색';
	IDS_ABOUT_SYNC = '노트를 PC 또는 웹 서버와 동기화하기 위한 IP 주소와 포트 또는 도메인.';
	IDS_AUTO_SYNC = '시작 시 동기화';
	IDS_ABOUT_AUTO_SYNC = '앱 시작 시 자동 동기화.';
	
	// 모두
	IDS_FULL_RESET = '전체 초기화';
	IDS_CONFIRM_FULL_RESET = '정말 모든 것을 초기화하시겠습니까? 모든 메모와 설정이 삭제됩니다.';
	IDS_DARK_THEME = '어두운 테마';
	IDS_THEME_TIME_DEPENDENT = '시간에 따른 테마';
	IDS_DARK_THEME_START = '어두운 테마 시작';
	IDS_DARK_THEME_END = '어두운 테마 종료';
	IDS_ABOUT_THEME_TIME = '어두운 테마는 자동으로 시간에 맞춰 활성화됩니다. 24시간 형식으로 시간을 지정하세요.';
	IDS_CATEGORIES = '카테고리';
	IDS_CATEGORIES_LIST = '#쇼핑\n#아이디어\n#일\n#프로젝트\n#가족\n#건강\n#재정\n#학습\n#여행\n#취미\n#개인';
	IDS_LAST_UPDATE = '마지막 업데이트: ';
	IDS_LOCAL_STORAGE = '로컬 저장소: %s / 5000 KB';
	
	// 알림
	IDS_DATE_UPDATE = '날짜가 업데이트됩니다';
	IDS_DATE_NOT_UPDATE = '날짜가 업데이트되지 않습니다';
	IDS_AUTH_REJECT = '인증 거부';
	IDS_SYNC_SUCCESSFUL = '동기화 성공';
	IDS_SYNC_ERROR = '동기화 오류';
	IDS_SYNC_NEED_CONNECT = '동기화를 위해서는<br>네트워크에 연결해야 합니다';
	IDS_CONNECTION_FAILED = '연결 실패'; 
}