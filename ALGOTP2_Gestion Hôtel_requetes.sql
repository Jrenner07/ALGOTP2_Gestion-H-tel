--Nombre de clients
SELECT count(CLI_ID) as 'Nombre de clients'
FROM T_CLIENT
--Les clients triés sur le titre et le nom
SELECT *
FROM T_CLIENT
ORDER BY TIT_CODE,CLI_NOM ASC 
--Les clients triés sur le libellé du titre et le nom
SELECT *
FROM T_CLIENT
WHERE TIT_CODE in(SELECT TIT_CODE
				FROM T_TITRE
				ORDER BY TIT_LIBELLE ASC)
ORDER BY CLI_NOM ASC
--Les clients commençant par 'B'
SELECT *
FROM T_CLIENT
WHERE upper(CLI_NOM) like 'B%'
--Les clients homonymes

--Nombre de titres différents
SELECT count(rowid) as 'Nombre de titres différents'
FROM T_TITRE
--Nombre d'enseignes
SELECT count(CLI_ENSEIGNE) as 'Nombres d enseigne differentes'
FROM T_CLIENT
--Les clients qui représentent une enseigne 
SELECT *
FROM T_CLIENT
WHERE CLI_ENSEIGNE is not NULL
--Les clients qui représentent une enseigne de transports
SELECT *
FROM T_CLIENT
WHERE upper(CLI_ENSEIGNE) like upper('TRANSPORTS%')
--Nombre d'hommes,Nombres de femmes, de demoiselles, Nombres de sociétés
SELECT count(TIT_CODE)as 'Nombre de personnes portant le titres',TIT_CODE as 'Intitulé du titre'
FROM T_CLIENT
GROUP BY TIT_CODE
--Nombre d''emails
SELECT count(rowid) as 'Nombre d email'
FROM T_EMAIL
--Client sans email 
SELECT count(CLI_ID) as 'Nombre d email non renseigné'
FROM T_CLIENT
WHERE CLI_ID not in (SELECT CLI_ID FROM T_EMAIL)
--Clients sans téléphone 
SELECT count(CLI_ID) as 'Nombre de numero non renseigné'
FROM T_CLIENT
WHERE CLI_ID not in (SELECT CLI_ID FROM T_TELEPHONE)
--Les phones des clients
SELECT *
FROM T_TELEPHONE
WHERE TYP_CODE like 'TEL'
--Répartition des phones par catégorie
SELECT *
FROM T_TELEPHONE
ORDER BY TYP_CODE ASC
--Les clients ayant plusieurs téléphones

--Clients sans adresse:
SELECT count(CLI_ID) as 'Client sans adresses'
FROM T_CLIENT
WHERE CLI_ID not in(SELECT CLI_ID
					FROM T_ADRESSE)
--Clients sans adresse mais au moins avec mail ou phone 

--Dernier tarif renseigné
SELECT *
FROM T_TARIF
ORDER BY TRF_DATE_DEBUT DESC
--Tarif débutant le plus tôt 
SELECT *
FROM T_TARIF
ORDER BY TRF_DATE_DEBUT ASC
--Différentes Années des tarifs

--Nombre de chambres de l'hotel 
SELECT count(CHB_ID) as 'Nombre de chambres'
FROM T_CHAMBRE
--Nombre de chambres par étage
SELECT count(CHB_ID) as 'Nombre de chambres par étage',CHB_ETAGE as 'Etage'
FROM T_CHAMBRE
GROUP BY CHB_ETAGE
--Chambres sans telephone
SELECT count(CHB_ID) as 'Nombre de chambres sans téléphones'
FROM T_CHAMBRE
WHERE CHB_POSTE_TEL is NULL
--Existence d'une chambre n°13 ?
SELECT *
FROM T_CHAMBRE
WHERE CHB_ETAGE = 13
--Chambres avec sdb
SELECT CHB_NUMERO as 'Numero de chambre avec salle de bain'
FROM T_CHAMBRE
WHERE CHB_BAIN not like 0
--Chambres avec douche
SELECT CHB_NUMERO as 'Numero de chambre avec douche'
FROM T_CHAMBRE
WHERE CHB_DOUCHE not like 0
--Chambres avec WC
SELECT CHB_NUMERO as 'Numero de chambre avec toilette séparer'
FROM T_CHAMBRE
WHERE CHB_WC not like 0
--Chambres sans WC séparés
SELECT CHB_NUMERO as 'Numero de chambre avec toilette non separer'
FROM T_CHAMBRE
WHERE CHB_WC like 0
--Quels sont les étages qui ont des chambres sans WC séparés ?
SELECT CHB_ETAGE as 'Etage avec des chambres sans WC séparés'
FROM T_CHAMBRE
WHERE CHB_WC like 0
--Nombre d'équipements sanitaires par chambre trié par ce nombre d'équipement croissant
SELECT sum(CHB_DOUCHE+CHB_BAIN+CHB_WC) as 'Nombre d appareils sanitaires',CHB_NUMERO as 'Numero de chambre'
FROM T_CHAMBRE
GROUP BY CHB_NUMERO
ORDER BY sum(CHB_DOUCHE+CHB_BAIN+CHB_WC) DESC
--Chambres les plus équipées et leur capacité
SELECT sum(CHB_DOUCHE+CHB_BAIN+CHB_WC) as 'Nombre d appareils sanitaires',CHB_NUMERO as 'Numero de chambre',CHB_COUCHAGE as 'Nombre de couchage'
FROM T_CHAMBRE
GROUP BY CHB_NUMERO
ORDER BY sum(CHB_DOUCHE+CHB_BAIN+CHB_WC)  DESC
--Repartition des chambres en fonction du nombre d'équipements et de leur capacité

--Nombre de clients ayant utilisé une chambre

--Clients n'ayant jamais utilisé une chambre (sans facture)

--Nom et prénom des clients qui ont une facture
SELECT CLI_NOM as 'Nom du client',CLI_PRENOM as 'Prenim du client',CLI_ID as 'Numéro du client'
FROM T_CLIENT
WHERE CLI_ID IN (SELECT CLI_ID
				FROM T_FACTURE)
--Nom, prénom, telephone des clients qui ont une facture
SELECT CLI_NOM as 'Nom du client',CLI_PRENOM as 'Prenim du client',CLI_ID as 'Numéro du client'
FROM T_CLIENT
WHERE CLI_ID IN (SELECT CLI_ID
FROM T_FACTURE)
AND (SELECT TEL_NUMERO
FROM T_TELEPHONE)
--Attention si email car pas obligatoire : jointure externe

--Adresse où envoyer factures aux clients

--Répartition des factures par mode de paiement (libellé)

--Répartition des factures par mode de paiement 

--Différence entre ces 2 requêtes ? 

--Factures sans mode de paiement 
SELECT * 
FROM T_FACTURE
WHERE PMT_CODE like ''
--Repartition des factures par Années

--Repartition des clients par ville
SELECT * 
FROM T_CLIENT,T_ADRESSE
ORDER BY ADR_VILLE ASC
--Montant TTC de chaque ligne de facture (avec remises)

--Classement du montant total TTC (avec remises) des factures

--Tarif moyen des chambres par années croissantes

--Tarif moyen des chambres par étage et années croissantes

--Chambre la plus cher et en quelle année

--Chambre la plus cher par année 

--Clasement décroissant des réservation des chambres 

--Classement décroissant des meilleurs clients par nombre de réservations

--Classement des meilleurs clients par le montant total des factures

--Factures payées le jour de leur édition

--Facture dates et Délai entre date de paiement et date d'édition de la facture