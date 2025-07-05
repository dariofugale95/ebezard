# Ecommerce-Builder – Documento Architetturale

## 1. Overview

Ecommerce-Builder è una piattaforma automatizzata per la generazione di siti e-commerce multi-tenant, con frontend e backend separati, automazione CI/CD e deploy su Azure. Supporta personalizzazione, automazione processi, pagamenti, spedizioni e scalabilità.

## 2. Architettura Generale

- **Frontend**: Next.js (App Router) + Express.js custom server
- **Backend**: Django (REST API/GraphQL)
- **Database**: Azure MySQL Flexible Server
- **CI/CD**: GitHub Actions
- **Hosting**: Azure Web App (Node.js per frontend, Python per backend)
- **Altri servizi**: Stripe/PayPal, Shippo/Sendcloud, SMTP, OpenAI API

## 3. Diagramma Architetturale

![Diagramma Architetturale](./ecommerce-architecture-diagram.png)

## 4. Flusso Principale

1. Utente si registra e seleziona categoria
2. Inserisce dati aziendali e carica prodotti
3. Sistema genera sito statico e backend dedicato
4. Integrazione pagamenti e spedizioni
5. Sito live su sottodominio

## 5. Dettaglio Componenti

### Frontend
- Next.js (SSR/SSG)
- Express.js per API custom/proxy
- Dashboard utente, configuratore sito, editor visuale

### Backend
- Django (REST API/GraphQL)
- Gestione utenti, prodotti, ordini, multi-tenant
- Integrazione servizi esterni (pagamenti, spedizioni)

### Database
- MySQL (Azure Flexible Server)
- Tabelle: Users, Stores, Products, Orders, Templates, SiteConfigs

### CI/CD
- GitHub Actions per build, test, deploy automatico
- Secrets gestiti in GitHub e .env

### Hosting
- Azure Web App (Node.js per frontend, Python per backend)
- Siti generati su sottodomini

## 6. Sicurezza
- SSL, JWT/sessioni, gestione secrets, protezione API

## 7. Scalabilità
- Docker/Kubernetes (futuro)
- Modularità e separazione frontend/backend

---

## 8. Struttura, Deploy e Best Practice

### Struttura delle cartelle

- `docs/` – Documentazione tecnica e architetturale
- `deploy/` – Script e file Compose per dev/prod
  - `deploy/dev/` e `deploy/prod/`: compose, script shell (`sh/ps1`), env separati
- `ecommerce-builder-backend/` – Codice Django, Dockerfile, env
- `ecommerce-builder-frontend/` – Codice React/Vite, Dockerfile, env

### Naming convention

- Tutti i servizi/container/volumi Docker hanno suffisso `-dev` o `-prod` a seconda dell’ambiente
- Chiarezza e coerenza tra nomi in Compose, script e variabili

### Gestione ambienti e variabili

- Separazione netta tra dev/prod: file Compose, env, script e volumi dedicati
- Variabili d’ambiente gestite tramite `.env` e Compose, coerenti tra backend/frontend
- CORS e ALLOWED_HOSTS configurati per networking sicuro tra container e browser

### Networking Docker e CORS

- Verifica reachability tra container (es. `curl`)
- Prefisso `/api/` fisso per tutte le chiamate frontend → backend

### Script di avvio/stop

- Script separati per dev/prod, sia bash (`.sh`) che PowerShell (`.ps1`)
- Opzione per eliminare i volumi (`--volumes`)
- Esempio: `deploy/dev/scripts/sh/start-dev.sh`, `deploy/prod/scripts/ps/stop-prod.ps1`

### Documentazione deploy

- Vedi `deploy/README.md` per dettagli su struttura, naming, uso script e best practice operative

---

## Allegato: Diagramma Architetturale

Vedi file `ecommerce-architecture-diagram.png`.
