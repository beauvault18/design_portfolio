'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "9cd0d1188a810955a4b16e6c01702d76",
"version.json": "1c49251ee500ff8ee068b794e59fa676",
"index.html": "be5fab3704e3c3e205f21710c2ef44f7",
"/": "be5fab3704e3c3e205f21710c2ef44f7",
"main.dart.js": "cea391331ef3741066fbbbad8f838c85",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "2af83129cec0348cdebf5b4d37212bf0",
"assets/AssetManifest.json": "ce3850a5cf56b48fa99dafdc255a0a4e",
"assets/NOTICES": "02c5ef5734ce5afd392c5e8cb9a12221",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "662fb8dfe2930ad390fd045cc0a3593a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "4b2a0d8369987ae89c7f76b7af16abc8",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/feature1.png": "c77ba7fd86a70705194cca12ea0fc23e",
"assets/assets/images/feature3.png": "eee7c647e61a8d05e7a2f8ad421abfa4",
"assets/assets/images/feature2.png": "7220fbb44ffd17312d741f56dd4a1211",
"assets/assets/images/feature4.png": "39169f8d58260ff5ffe1b0f41a12ce24",
"assets/assets/images/feature1_test.png": "5dcef449791fa27946b3d35ad8803796",
"assets/assets/videos/voice_entered_vitals.mov": "2bc516144406bec1debf1954f9a48642",
"assets/assets/videos/bluetooth_vitals_capture.mov": "dfead6bd9c092bc7f7f9c81b19b28252",
"assets/assets/videos/transcription_intelligence.mov": "52894c07a56593e4db7688979aecaac0",
"assets/assets/videos/billing_code_review.mov": "78def5e14fba1038c2068d6ca5d5654b",
"assets/assets/news/story4_content.md": "c594bddd6a44fe0943b4ac3da027c808",
"assets/assets/news/story7_header.txt": "65f466764a15e8da75a66fcd3ff377c7",
"assets/assets/news/story1_content.md": "cbabac230b26f002e1794ae671c741aa",
"assets/assets/news/story2_header.txt": "9c7ffb71af09bb1a2c130ccd6f1e2019",
"assets/assets/news/images/nurse/story_1_image.png": "97bcabfa6a4440be14f9bb07487aa52b",
"assets/assets/news/images/nurse/story_6_image.png": "0f9801f852bef869fddf278f2b9074a8",
"assets/assets/news/images/nurse/story_3_image.png": "6bd6adb528aa0d9f08c581ac43aadb6a",
"assets/assets/news/images/nurse/story_5_image.png": "9cdde8de89d0cda274e8df53a371f16b",
"assets/assets/news/images/nurse/story_2_image.png": "1a8542f8925e53f2ee967d525466a618",
"assets/assets/news/images/nurse/story_4_image.png": "767f9a902075576245b505fc6603a33d",
"assets/assets/news/images/story_1_image.jpg": "23a56ef324944a5512167ccc50bd1096",
"assets/assets/news/images/story_7_image.jpg": "60fa055866c5bd47358fa31916b15b7f",
"assets/assets/news/images/provider/story_1_image.png": "e4e871977270e200f83f7e7c84506cc6",
"assets/assets/news/images/provider/story_7_image.png": "7d705bfbd24b77ebc7a0f186125e88c8",
"assets/assets/news/images/provider/story_6_image.png": "e4e871977270e200f83f7e7c84506cc6",
"assets/assets/news/images/provider/story_3_image.png": "dfffc80f4177d64a88c8a55768e6eed1",
"assets/assets/news/images/provider/story_5_image.png": "1ba53e66651f2f6381590df96bb38a01",
"assets/assets/news/images/provider/story_2_image.png": "eab78256b34569001adc5ac07ca0a1a3",
"assets/assets/news/images/provider/story_4_image.png": "1ba53e66651f2f6381590df96bb38a01",
"assets/assets/news/images/leader/story_1_image.png": "08ed00c0feda062375bab64e48c1e3e3",
"assets/assets/news/images/leader/story_7_image.png": "89f042a682e63669c4b58c138b082d97",
"assets/assets/news/images/leader/story_6_image.png": "9314eaf611022d135302e2c44ab16564",
"assets/assets/news/images/leader/story_3_image.png": "1553d4c42a38453d11a235c63b5b65b8",
"assets/assets/news/images/leader/story_5_image.png": "71e59d71450baf993089aba51b1944dd",
"assets/assets/news/images/leader/story_2_image.png": "944dd89d2fb54bf6a2de29fe90c846f2",
"assets/assets/news/images/leader/story_4_image.png": "76a8f7e19997aaa78c97052f3ae16964",
"assets/assets/news/images/story_6_image.jpg": "dcb92926c88d7d65936e461fd3a2a670",
"assets/assets/news/images/story_3_image.jpg": "39d92efb8fdf07f340b87f383abbdf42",
"assets/assets/news/images/story_5_image.jpg": "3405200a7337ffdce763c5125c767c2f",
"assets/assets/news/images/consumer/story_1_image.png": "737355a2b67f2a552bc2ed7ba8958b6a",
"assets/assets/news/images/consumer/story_6_image.png": "bbb04580feea4606ca2ef2540ad6a22c",
"assets/assets/news/images/consumer/story_3_image.png": "3ecddf951beafbaafca88534e2b4d1bd",
"assets/assets/news/images/consumer/story_5_image.png": "a8b68f24742ad03f6926c27f6c451007",
"assets/assets/news/images/consumer/story_2_image.png": "8d1022d639826574c3e4f5d1b8562d61",
"assets/assets/news/images/consumer/story_7_images.png": "6a62829d51ea3833da9f86db49e6079b",
"assets/assets/news/images/consumer/story_4_image.png": "e07beb00608aa56ea28e16975f183964",
"assets/assets/news/images/story_2_image.jpg": "5d550200323d2470d79e0744e0efda92",
"assets/assets/news/images/tech/story_1_image.png": "e927432f1db3548c03145b7cdbea0311",
"assets/assets/news/images/tech/story_7_image.png": "44d7812e65019bf4d26f13ea7b69ed11",
"assets/assets/news/images/tech/story_6_image.png": "d6f1c1abd0513ce0e4b76f4cfb58e9dc",
"assets/assets/news/images/tech/story_3_image.png": "d5d6f6e70d89ac174b1c3a510d54ac6c",
"assets/assets/news/images/tech/story_5_image.png": "cacf8b008b3601e356a6e7c5c2079306",
"assets/assets/news/images/tech/story_2_image.png": "78f5a69c5ade767c0d77a9f94dd337eb",
"assets/assets/news/images/tech/story_4_image.png": "8e6dd47f182ccc0dcacfae997ed4ff76",
"assets/assets/news/images/story_4_image.jpg": "b4ae906f0bf06da90ebfaf9a41570058",
"assets/assets/news/story5_header.txt": "fed350bb4ac56b4ff280ccd23e73246a",
"assets/assets/news/story6_content.md": "a01d02e7a68a9c8570d4c95a9eab0c18",
"assets/assets/news/story3_content.md": "e2ddd6aa160eb3dc3b1105d84a61aded",
"assets/assets/news/story3_header.txt": "97c61cd26d426cfea48ad9284f83a775",
"assets/assets/news/story5_content.md": "bca43d684107baeeab0c85efc9964979",
"assets/assets/news/story6_header.txt": "204dd5e12816c9287807bcbff3a1d0b8",
"assets/assets/news/story1_header.txt": "24bc387b0726e0c9cc0cea3a3ec8940b",
"assets/assets/news/story2_content.md": "4ab1df2b3dfa71ba6739128a6363d8bd",
"assets/assets/news/story4_header.txt": "df54fbfbd22eee1282e10f02142f2c9c",
"assets/assets/news/story7_content.md": "a19d428e59aa007b177401b84370a771",
"assets/assets/logo.png": "a6e6e7373fd2bd490c6c799025560aeb",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
