# Bicyclette 3
---

# Map style
* afficher des pins bleus pour les villes
* ne pas afficher de pins pour les régions, mais une heatmap

# UI générale
* enlever la shadow du FanVC/le remplacer par un transitionVC?
* problèmes de feedback (dans le prompt de la navbar) sur iPad

# Prefs
* finir de rebrancher les prefs
* fixer ui quirks
* Afficher les explications des Geofences au premier fav

# Notifications
* gérer les groupes de favoris

# Add cities

* Bay Area


# LocalUpdateQueue redesign

##Concepts

* Updatable objects
* Locatable objects
* Reference Location
    * two modes : center of screen and current location
* Priority modes : 
    * by distance from reference location
    * high-priority list

* Requests that update a whole list of updatable in a single pass
    * Is it coalescing?


## Bugs

* crashes au lancement
* mise à jour bg ne se fait pas
* premier chargement dans une ville "with individual updates" ne fonctionne pas
