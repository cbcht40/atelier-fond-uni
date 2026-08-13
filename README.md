# Atelier — fond uni

Outil qui remplace l'arrière-plan des photos de vêtements par une couleur unie, pour préparer des annonces de seconde main.

**Le site : https://cbcht40.github.io/atelier-fond-uni/**

Tout le traitement se fait dans le navigateur du visiteur : aucune photo n'est envoyée, aucun serveur, aucune API. C'est ce qui rend l'hébergement gratuit de façon permanente — GitHub Pages ne sert qu'un fichier statique.

## Comment ça marche

L'arrière-plan est détecté par **croissance de région** depuis les bords de l'image :

1. On échantillonne le pourtour de la photo et on regroupe ces pixels en quelques couleurs de référence (le drap, une zone d'ombre, un bout de sol…).
2. On propage de proche en proche à partir des bords, en acceptant un pixel s'il ressemble à une des couleurs de référence — avec une tolérance de proche en proche pour suivre les dégradés d'ombre, plafonnée pour éviter que la sélection ne déborde sur le vêtement.
3. Le masque obtenu est érodé d'un pixel puis flouté, pour un contour adouci plutôt qu'un découpage aux ciseaux.
4. On compose : la couleur unie remplace le fond, le vêtement est laissé intact.

Une zone de fond enclavée (entre une manche et le corps, par exemple) n'est pas reliée aux bords : **toucher cette zone dans l'aperçu** l'ajoute aux amorces.

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

## Licence

Usage personnel. Aucun lien avec Vinted.
