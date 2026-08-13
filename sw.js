/* Service worker de l'Atelier.
 *
 * Son seul vrai rôle : que l'application ouverte depuis l'écran d'accueil
 * affiche toujours la dernière version publiée, sans vider le cache à la main.
 * La page est donc cherchée sur le réseau d'abord, le cache ne servant que de
 * filet quand il n'y a pas de connexion.
 */

const CACHE = "atelier-v1";
const ESSENTIELS = ["./", "./manifest.webmanifest", "./icone-192.png", "./icone-512.png", "./icone-180.png"];

self.addEventListener("install", (e) => {
  e.waitUntil(
    caches.open(CACHE)
      .then((c) => c.addAll(ESSENTIELS))
      .catch(() => {})           // un fichier manquant ne doit pas bloquer l'installation
      .then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys()
      .then((noms) => Promise.all(noms.filter((n) => n !== CACHE).map((n) => caches.delete(n))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", (e) => {
  const req = e.request;
  if (req.method !== "GET") return;

  const url = new URL(req.url);
  // Tout ce qui part vers la base d'annonces file directement au réseau.
  if (url.origin !== self.location.origin) return;

  const estLaPage = req.mode === "navigate"
    || url.pathname.endsWith("/")
    || url.pathname.endsWith("/index.html");

  if (estLaPage) {
    e.respondWith(
      fetch(req, { cache: "no-store" })
        .then((r) => {
          const copie = r.clone();
          caches.open(CACHE).then((c) => c.put("./", copie)).catch(() => {});
          return r;
        })
        .catch(() => caches.match("./").then((r) => r || caches.match("./index.html")))
    );
    return;
  }

  // Icônes et manifeste : le cache d'abord, ils ne bougent presque jamais.
  e.respondWith(
    caches.match(req).then((enCache) => enCache || fetch(req).then((r) => {
      const copie = r.clone();
      caches.open(CACHE).then((c) => c.put(req, copie)).catch(() => {});
      return r;
    }))
  );
});
