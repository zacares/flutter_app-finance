'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"manifest.json": "45a3f1e8a23817e9bf752339034f6320",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"version.json": "a35f26c3beac3dd320536995d7a8387d",
"favicon.png": "6eb0f694702967bb15c471e8c8d3cb12",
"index.html": "72c8db899ec7c1998bb6f1b6ecb1f5ae",
"/": "72c8db899ec7c1998bb6f1b6ecb1f5ae",
"icons/Icon-maskable-512.png": "7d1365a199f68916503a15ecc4c8f5a0",
"icons/Icon-192.png": "7d1365a199f68916503a15ecc4c8f5a0",
"icons/Icon-maskable-192.png": "7d1365a199f68916503a15ecc4c8f5a0",
"icons/Icon-512_fz.png": "04dae777b7599834ee94fa0abbcb3291",
"icons/Icon-512.png": "d0a7ddaee9f1d4b7ed2a95ba8e5e50e6",
"assets/FontManifest.json": "c330ec2cddeda2575a852ddaf6af789d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/NOTICES": "aa72a9cc2f8b86da81ca9205beea5a95",
"assets/AssetManifest.json": "8e5373ba84fd4e552c46d739c6e73f6f",
"assets/AssetManifest.bin.json": "7c1fda209cffea68c69fba874541466a",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/assets/l10n/help_metrics_bill_pt_BR.md": "45dd5b5070f888c735c33c64b3f7041d",
"assets/assets/l10n/terms_of_use_be.md": "c20a1b9abb08758a386e30a11f7ff35d",
"assets/assets/l10n/help_metrics_budget_be_EU.md": "3ec38110f0883daa7eb0e32b310a9402",
"assets/assets/l10n/help_metrics_bill_uk.md": "49cf44c385aa8a9a4b7dfeeaf293cc73",
"assets/assets/l10n/help_metrics_bill_be_EU.md": "58185be2eef8cb94d5fcaa39a31b9f23",
"assets/assets/l10n/terms_of_use_pt_BR.md": "6b17b504e6d6baaac73b2e06b3e161c8",
"assets/assets/l10n/help_metrics_budget_en.md": "bc464a8bb0ca6e01a1b898487b8b2953",
"assets/assets/l10n/privacy_policy_uk.md": "ae87093994c68ded6281a7d941d28693",
"assets/assets/l10n/privacy_policy_pl.md": "7a80c55ebe16d41bff83ced2af0d8239",
"assets/assets/l10n/help_metrics_account_fr.md": "90fee6a2a4def5dff75fd25cc01521f3",
"assets/assets/l10n/privacy_policy_fr.md": "9c33ac77caaa234bd9c2d91213e1541f",
"assets/assets/l10n/help_metrics_account_uk.md": "adc054830cc3b6afe3c0d56bf8c73f95",
"assets/assets/l10n/terms_of_use_be_EU.md": "d1c2f93f6b0e6ec35a967c8c08b15c40",
"assets/assets/l10n/privacy_policy_pt_BR.md": "02c8a6aeb61bed0137a462507ada62a7",
"assets/assets/l10n/terms_of_use_fr.md": "16b2965749cd8ad92c9cecd5bc7269aa",
"assets/assets/l10n/terms_of_use_de.md": "437be661f43acbb7b4f7f9ca341082b0",
"assets/assets/l10n/help_metrics_budget_uk.md": "7f11932a74bc81ad36fb444fd30c2ffc",
"assets/assets/l10n/privacy_policy_pt.md": "8e352de0ee7563fda33f10124dc9aa04",
"assets/assets/l10n/help_metrics_account_de.md": "1240363a21c5e9f75cfaa622a8a27c48",
"assets/assets/l10n/help_metrics_budget_pt.md": "8fb14dfd839050f5c42ce0d681dfcb45",
"assets/assets/l10n/terms_of_use_pt.md": "a4c2f5a49973b0118bf9039cd1c61cc9",
"assets/assets/l10n/help_metrics_budget_fr.md": "e76ded4f523e243ef7514291c1e715d5",
"assets/assets/l10n/help_metrics_bill_en.md": "c813c89ce576596b753c04451bbb3500",
"assets/assets/l10n/help_metrics_account_pt_BR.md": "a55dc39748d19c5d3f3665b8b01bdb74",
"assets/assets/l10n/help_metrics_account_pt.md": "8814fbb29a6a3114ca59a98ab6234b88",
"assets/assets/l10n/privacy_policy_be.md": "cf59b8f4044a4bab58a61a33b1d0af6a",
"assets/assets/l10n/help_metrics_budget_pl.md": "bfd43e7978078ba393396fb76e56705c",
"assets/assets/l10n/help_metrics_bill_pt.md": "27a100de4d3cf8116040c18b5680e675",
"assets/assets/l10n/privacy_policy_be_EU.md": "fba1de0b5675a96bac48c16c3efd5c55",
"assets/assets/l10n/help_metrics_bill_pl.md": "63c1597d1df63a52958c795cc4e016cf",
"assets/assets/l10n/help_metrics_budget_pt_BR.md": "defb022c5f41e4de35bacbe7250cecb6",
"assets/assets/l10n/help_metrics_budget_de.md": "064072726c75e8e62b92f2072ebf0124",
"assets/assets/l10n/privacy_policy_de.md": "53fea5afd588051aa50c55b7efb55992",
"assets/assets/l10n/help_metrics_account_en.md": "8aaef28b0a529ed28acb2a484e0ff990",
"assets/assets/l10n/help_metrics_budget_be.md": "82fbf83dc5e2c938573c7cd8fd3d650f",
"assets/assets/l10n/terms_of_use_en.md": "62d0ba13966492ada8bb6207c489a4af",
"assets/assets/l10n/help_metrics_account_be.md": "adfe1c7614a3e236eae8a55202215af4",
"assets/assets/l10n/help_metrics_bill_fr.md": "d8482c28211c58b55647aa34b932ec85",
"assets/assets/l10n/terms_of_use_uk.md": "1ecbaf1ade60cc9b7e42b283e29ccf63",
"assets/assets/l10n/help_metrics_account_pl.md": "acb4e201e998a2fa9b5d32b4b699c9d3",
"assets/assets/l10n/help_metrics_bill_be.md": "5e410ae927d87136d980a658ca8490b7",
"assets/assets/l10n/help_metrics_account_be_EU.md": "975b9c9917edb33c60f2ab69069775e8",
"assets/assets/l10n/terms_of_use_pl.md": "4f84363f90c0b7c9ab4164deac292116",
"assets/assets/l10n/help_metrics_bill_de.md": "b328f32da0f61f12251c3717a087e6ca",
"assets/assets/l10n/privacy_policy_en.md": "1f7c0dd7e1a89806b900b84298f7e4ad",
"assets/assets/images/logo.png": "a24d3e5a52e8fe25914740a809e07b92",
"assets/assets/images/sub_tiny.png": "9ac6c3fad91eecfb28b92f25d218e3fb",
"assets/assets/images/coffee.png": "ab52a69150c64690d234f3d180303e3b",
"assets/assets/images/coin.png": "3f7219c1c4f87de5bacb3902aa3169a8",
"assets/assets/images/app_icon.ico": "bf485737a5371b3468dd5d7d69cfaa35",
"assets/assets/images/dinner.png": "cc10f9e9e38b0aeda40152e7c0ee355a",
"assets/assets/images/fingrom.svg": "7e17903d3a6d6fb5bb5f533eebe6428b",
"assets/assets/fonts/Abel-Regular.ttf": "bde79f6eb992e9138d91ba2194d1b56d",
"assets/assets/fonts/RobotoCondensed-Regular.ttf": "bde79f6eb992e9138d91ba2194d1b56d",
"assets/AssetManifest.bin": "5efc388cc68cb4ac39b0699ca4764547",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"main.dart.js": "14ead15cc2f6b96214e27880b9c340e9"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
