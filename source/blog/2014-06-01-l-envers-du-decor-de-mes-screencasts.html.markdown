---
title: L'envers du décor de mes screencasts
date: 2014-06-01 09:50 CEST
tags: sysadm, linux, life
---
À l'occasion de la sortie de mon nouveau [screencast sur l'administration avec Ansible](https://hackademy.io/) je voulais partager quelques techniques utilisées dans les exemples donnés.

Vous avez remarqué que je me connectais à une bonne quinzaine de serveur tout au long de la video. Et si je vous disais que ces serveurs n'en sont pas vraiment ?!

En effet pour les besoins de l'exemple, je dois montrer des connexions SSH multiples et cela assez rapidement pour ne pas faire trainer en longueur la video. De plus je fonctionne avec 0 budget, donc or de question de taper dans des offres cloud (même si j'en fais illusion à un moment...).

C'est là que [Docker](https://docker.io) entre en scène.
