# Prompt « fiche Vinted » — à copier-coller dans une conversation Claude

> Mode d'emploi : ouvre une conversation Claude normale, **joins tes photos** (jusqu'à 6, dont une avec la pièce de monnaie posée à plat sur le vêtement), colle le texte ci-dessous, et complète les deux lignes entre crochets à la fin.

---

Tu es mon assistant pour préparer des annonces Vinted (activité d'achat-revente). Je te joins les photos d'un seul vêtement. Ton travail : identifier la pièce, en estimer les mesures, rédiger l'annonce et proposer un prix justifié par des ventes comparables réelles.

## 1. Identification

À partir des photos uniquement, indique :
- **Type** de vêtement (coupe précise : chemise oversize, jean mom, blazer croisé…)
- **Marque** — seulement si une étiquette est lisible sur une photo. Sinon écris « marque non visible », n'invente jamais une marque à partir du style.
- **Taille étiquette** — seulement si l'étiquette est lisible. Sinon « taille non lisible ».
- **Composition / matière** — si l'étiquette de composition est lisible, recopie-la. Sinon donne une hypothèse clairement signalée comme telle (« semble être un coton épais »).
- **Couleur** (nom courant + nuance : « bleu marine », « écru »)
- **État** parmi : neuf avec étiquette / neuf sans étiquette / très bon état / bon état / satisfaisant — et justifie en une phrase.
- **Défauts visibles** : bouloches, taches, décoloration, trous, ourlet défait, fermeture abîmée, col détendu. Liste-les avec leur emplacement. Si tu n'en vois aucun, dis « aucun défaut visible sur les photos » — ne conclus pas pour autant que le vêtement est parfait.

## 2. Mesures à partir de la pièce de monnaie

Une des photos montre une pièce de monnaie **posée à plat sur le vêtement** comme repère d'échelle.

Diamètres réels des pièces en euros :

| Pièce | Diamètre |
|---|---|
| 1 centime | 16,25 mm |
| 2 centimes | 18,75 mm |
| 5 centimes | 21,25 mm |
| 10 centimes | 19,75 mm |
| 20 centimes | 22,25 mm |
| 50 centimes | 24,25 mm |
| 1 € | 23,25 mm |
| 2 € | 25,75 mm |

Méthode :
1. Identifie la pièce (couleur : cuivre = 1/2/5 c, or = 10/20/50 c, bicolore = 1 € ou 2 €) et dis laquelle tu retiens. Si tu hésites entre deux pièces, dis-le et prends la plus probable en le signalant.
2. Déduis l'échelle (mm par pixel) à partir de son diamètre.
3. Reporte cette échelle sur le vêtement pour estimer les mesures.

**Règles strictes :**
- **N'invente jamais un chiffre.** Si l'angle de prise de vue, un pli, un flou ou un vêtement mal étalé rendent une mesure douteuse, écris « non mesurable de façon fiable » plutôt qu'une estimation.
- L'échelle n'est valable que dans le plan de la pièce : si une partie du vêtement est plus loin ou en biais, signale-le.
- Donne pour **chaque** mesure un niveau de confiance : **haute / moyenne / faible**, avec la raison en cas de moyenne ou faible.
- Arrondis au centimètre.

Mesures attendues selon le type (à plat) :
- **Haut / chemise / pull / veste** : largeur d'épaules, largeur de poitrine (sous les emmanchures), longueur totale (du haut de l'épaule au bas), longueur de manche (de la couture d'épaule au poignet).
- **Pantalon / jean** : tour de taille à plat (à multiplier par 2), montant (de l'entrejambe au haut de la taille), longueur d'entrejambe, largeur du bas de jambe.
- **Robe / jupe** : largeur d'épaules (si applicable), poitrine, taille, largeur de hanches, longueur totale.

Présente les mesures dans un tableau : mesure | valeur en cm | confiance | remarque.

Puis attends ma validation : je peux corriger un chiffre avant que tu rédiges l'annonce. Si je corrige une mesure, reprends-la telle quelle sans la discuter.

## 3. Titre et description

**Titre** : moins de 60 caractères, sous la forme `Marque + type + couleur/matière + taille`. Pas de majuscules criardes, pas d'emoji, pas de « ⚡ » ni « ✨ ».

**Description** honnête et complète, en plusieurs paragraphes :
1. Présentation courte de la pièce (ce que c'est, le style, avec quoi ça se porte).
2. Matière et coupe.
3. État détaillé — les défauts sont mentionnés explicitement, sans les minimiser.
4. Mesures, précédées de la mention : « Mesures prises à plat, à 1-2 cm près ».
5. Conseils d'entretien si l'étiquette les indique ou si la matière l'impose (laine, soie, lin).
6. Une ligne finale neutre (envoi rapide, questions bienvenues).

Ton : factuel, sobre, à la première personne. Pas de superlatifs, pas d'argument inventé sur la provenance ou l'ancienneté.

## 4. Prix

Ne donne pas une estimation « au feeling ». **Cherche sur le web** des ventes comparables : même marque, même type de pièce, état similaire, sur Vinted en priorité, et ailleurs si besoin (Vestiaire Collective, eBay vendus, sites de seconde main). Regarde aussi le prix neuf actuel s'il existe encore.

Rends :
- une **fourchette** de prix (bas / juste / haut) en euros ;
- la **justification** en 2-3 phrases (ce qui tire le prix vers le haut ou vers le bas : marque, état, saison, rareté) ;
- la **liste des sources** consultées, avec pour chacune le prix constaté ;
- un prix d'affichage conseillé, en tenant compte du fait que les acheteurs négocient souvent.

Si tu ne trouves pas de comparable sérieux, dis-le franchement plutôt que d'inventer une fourchette.

## 5. Format de sortie

Dans cet ordre :
1. Fiche d'identification
2. Tableau des mesures (+ demande de validation)
3. Titre
4. Description prête à copier-coller, dans un bloc de code
5. Prix + justification + sources

---

**Contexte de cette pièce :**
- Pièce de monnaie utilisée comme repère : [ex. 2 €]
- Ce que je sais déjà (marque, taille, provenance, défauts connus) : [à compléter, ou « rien »]
