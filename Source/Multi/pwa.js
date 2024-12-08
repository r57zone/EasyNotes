// https://github.com/Oshanotter/offline-pwa-example/

const PRECACHE = 'precache-v1';

// A list of local resources we always want to be cached.
const PRECACHE_URLS = [
  'index.html',
  './', // Alias for index.html
  'langs.js',
  'style.css',
  'android.css',
  'ios.css',
  'images/back.png',
  'images/close.png',
  'images/done.png',
  'images/new.png',
  'images/rm.png',
  'images/settings.png',
  'images/sync.png',
  'pwa.js',
  'manifest.json',
  'icons/icon.png',
  'icons/icon-180.png'
];

// The install handler takes care of precaching the resources we always need.
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(PRECACHE)
    .then(cache => cache.addAll(PRECACHE_URLS))
    .then(self.skipWaiting())
  );
});

// The activate handler takes care of cleaning up old caches.
self.addEventListener('activate', event => {
  const currentCaches = [PRECACHE];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return cacheNames.filter(cacheName => !currentCaches.includes(cacheName));
    }).then(cachesToDelete => {
      return Promise.all(cachesToDelete.map(cacheToDelete => {
        return caches.delete(cacheToDelete);
      }));
    }).then(() => self.clients.claim())
  );
});

// On fetch, use cache but update the entry with the latest contents from the server.
self.addEventListener('fetch', function(evt) {
  // If the request doesn't come from the same origin as the referrer, don't store it
  if (!evt.request.url.includes(evt.request.referrer)){
    return; // You can also remove the return statement if you want every request to be cached
  }
  // You can use respondWith() to answer ASAP…
  evt.respondWith(fromCache(evt.request));
  // ...and waitUntil() to prevent the worker to be killed until the cache is updated.
  evt.waitUntil(
    update(evt.request)
  );
});

// Open the cache where the assets were stored and search for the requested resource. Notice that in case of no matching, the promise still resolves but it does with undefined as value.
function fromCache(request) {
  return caches.open(PRECACHE).then(function(cache) {
    return cache.match(request);
  });
}

// Update consists in opening the cache, performing a network request and storing the new response data.
function update(request) {
  return caches.open(PRECACHE).then(function(cache) {
    return fetch(request).then(function(response) {
      return cache.put(request, response.clone()).then(function() {
        return response;
      });
    });
  });
}