MariaDb 10
---

Serveur base de données MariaDb 10 sous ubuntu 16.04

# Utilisation

## Docker

```
    
    // Pour générer l'image
    make build
    
    // Pour lancer le container
    make run
    
    // Pour arrêter le container
    make stop
    
    // Pour accéder en ssh
    make bash
    
```

## Accès

```
    super:superpaswd@localhost:6706
```

## Divers

Les logs du serveur se retrouveront dans le répertoire docker-logs.
La base de données dans docker-db/mariadb
Ces répertoires sont à exlure de git (cf .gitignore)

Variables docker :
* USER : utilisateur à ajouter
* PASS : mot de passe de l'utilisateur
* DUMP : liste des dumps à monter séparés par :

### exemple :

```
        image: u16_mariadb10
        ports:
            - 6706:3306
        environment:
            DATABASE: test
            USER: *****
            PASS: ******
            DUMP: /dumps/test.dmp:/dumps/test2.dmp
        volumes:
            - ./docker-db/mysql/:/data
            - ./docker-dumps/:/dumps
```

--