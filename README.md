# VintGo — photos & annonces

VintGo réunit dans une page ce qu'il faut pour préparer des annonces de seconde main : le détourage des photos sur fond uni, et le carnet des annonces qui va avec.

**Le site : https://cbcht40.github.io/atelier-fond-uni/**

Tout se passe dans le navigateur du visiteur : aucune photo n'est envoyée, aucun serveur, aucune API. C'est ce qui rend l'hébergement gratuit de façon permanente — GitHub Pages ne sert qu'un fichier statique.

## Le carnet d'annonces

Depuis l'onglet Photos, « Créer une annonce » enregistre les photos détourées dans une fiche : titre avec compteur de caractères, description, mesures, prix de vente et prix d'achat (la marge se calcule seule), marque, taille, état, notes, et un statut — brouillon, à publier, en ligne, vendue. Les boutons « Copier » servent à coller directement dans Vinted.

Le bas de la liste tient les comptes : nombre d'annonces par statut, total encaissé et marge cumulée sur les ventes.

## Compte et synchronisation

L'accès demande une connexion par mail et mot de passe. Les annonces sont rattachées au compte, pas à l'appareil : saisies sur le téléphone, retrouvées sur l'ordinateur.

Chaque compte ne voit que ses propres annonces, et la règle est posée sur le serveur, pas dans la page — un compte qui tente de lire ou d'écrire les lignes d'un autre est refusé par la base elle-même. Les photos sont rangées dans un espace privé, un dossier par compte, soumis aux mêmes règles.

Le carnet local (IndexedDB) sert de cache : l'outil reste utilisable sans réseau et rattrape son retard au retour de la connexion. Un bandeau en haut indique « À jour », « Synchronisation… » ou « Hors ligne — N en attente ».

La liste s'affiche instantanément grâce à une miniature stockée avec la fiche ; les photos en pleine taille ne se téléchargent qu'à l'ouverture de l'annonce.

**Sur iPhone, Safari efface les données locales d'un site après sept jours sans visite.** Le cache local disparaît alors, mais pas les annonces : elles sont sur le serveur et reviennent à la connexion suivante. Ajouter le site à l'écran d'accueil (Partager → Sur l'écran d'accueil) évite la purge.

### Mise en place côté serveur

Le schéma est dans `supabase.sql`, à lancer dans l'éditeur SQL de Supabase **en deux fois** : d'abord la partie table, ensuite la partie stockage. L'éditeur exécute tout en une transaction, donc une erreur sur la fin annulerait aussi la table créée avant.

## L'onglet Reprise

Reprendre une annonce, c'est lui refaire des visuels et un titre à partir de ce qui est déjà enregistré, sans ressortir le vêtement. On choisit une annonce, on change la couleur de fond, on incline légèrement, on passe en miroir, on resserre le cadrage, on prend une variante de titre, et on enregistre le tout comme une nouvelle annonce au statut « à publier ». L'originale n'est pas touchée.

Les visuels sont refaits à partir des photos enregistrées : le fond de celles-ci étant déjà uni, il se remplace proprement par une autre couleur.

**À savoir avant de s'en servir.** Republier une annonce pour la faire remonter est contraire aux règles de Vinted et peut valoir une restriction de compte. Par ailleurs, changer le fond et l'orientation ne suffit pas à rendre deux annonces étrangères l'une à l'autre : les modèles de similarité visuelle actuels résistent au miroir, au recadrage et au changement de fond, et le rapprochement se fait aussi sur le vendeur, le prix, les mesures et le texte. Cet onglet sert à refaire une présentation, pas à passer inaperçu — aucune altération destinée à tromper une empreinte n'y est faite.

## Comment ça marche

L'arrière-plan est détecté par **croissance de région** depuis les bords de l'image :

1. On échantillonne le pourtour de la photo et on regroupe ces pixels en quelques couleurs de référence (le drap, une zone d'ombre, un bout de sol…).
2. On propage de proche en proche à partir des bords, en acceptant un pixel s'il ressemble à une des couleurs de référence — avec une tolérance de proche en proche pour suivre les dégradés d'ombre, plafonnée pour éviter que la sélection ne déborde sur le vêtement.
3. Le masque obtenu est érodé d'un pixel puis flouté, pour un contour adouci plutôt qu'un découpage aux ciseaux.
4. On compose : la couleur unie remplace le fond, le vêtement est laissé intact.

Une zone de fond enclavée (entre une manche et le corps, par exemple) n'est pas reliée aux bords : **toucher cette zone dans l'aperçu** l'ajoute aux amorces.

Les aperçus sont calculés en 640 px pour que les curseurs restent réactifs ; l'export refait le calcul à la taille choisie.

## Modifier le site

Tout tient dans `index.html` — pas de dépendance, pas de compilation, pas d'installation.

- **Depuis n'importe quel appareil** : ouvrir `index.html` sur github.com, cliquer sur le crayon, modifier, valider. Le site se met à jour tout seul en une minute environ.
- **En local** : ouvrir le fichier dans un éditeur de code, puis un double-clic dessus le lance dans le navigateur pour tester. Sur Mac, ne pas utiliser TextEdit en mode texte enrichi, il abîme le fichier.

Repères dans le fichier :

| À changer | Où |
|---|---|
| Les 5 couleurs de fond proposées | les lignes `data-color="#…"` — le code couleur y figure deux fois, changer les deux |
| Sensibilité par défaut | l'attribut `value` de `<input id="tol">` et `tol:` dans l'objet `opts` |
| Adoucissement par défaut | `<input id="feather">` et `feather:` dans `opts` |
| Taille d'export par défaut | `maxSide:` dans `opts` |
| Titre affiché | le `<h1>` |

## Limites connues

Fond chargé (parquet à motifs, tapis, autres vêtements en arrière-plan), ou vêtement de la même couleur que le fond : la détection échoue, et la page l'annonce plutôt que de rendre une image ratée. Dans ce cas, refaire la photo sur fond uni.

## Le nom

VintGo est un outil personnel. Il n'a aucun lien avec Vinted, n'en est pas un service officiel ou affilié, et ne se connecte jamais à un compte Vinted : la publication des annonces reste manuelle, par copier-coller.

## Licence

Usage personnel. Aucun lien avec Vinted.
