# ebezard – Guida Deploy & Struttura Ambiente

## 1. Struttura delle Cartelle

- `deploy/`
  - `dev/` – Ambiente di sviluppo
    - `docker-compose.dev.yml`
    - `scripts/`
      - `sh/` – Script bash (`start-dev.sh`, `stop-dev.sh`)
      - `ps/` – Script PowerShell (`start-dev.ps1`, `stop-dev.ps1`)
  - `prod/` – Ambiente di produzione
    - `docker-compose.prod.yml`
    - `scripts/`
      - `sh/` – Script bash (`start-prod.sh`, `stop-prod.sh`)
      - `ps/` – Script PowerShell (`start-prod.ps1`, `stop-prod.ps1`)
- `docs/` – Documentazione tecnica e architetturale

## 2. Logica di Separazione Dev/Prod

- **Servizi, container e volumi** hanno nomi distinti tra dev e prod (es: `backend-dev`, `frontend-prod`, `db-dev`, `db-prod`)
- **Variabili d’ambiente** e configurazioni dedicate per ogni ambiente
- **Script** separati per avvio/stop, con opzione di eliminazione volumi
- Nessuna sovrapposizione tra dati o risorse di dev e prod

## 3. Convenzioni di Naming

- Tutti i servizi/container/volumi seguono il suffisso `-dev` o `-prod` a seconda dell’ambiente
- I file Compose sono denominati `docker-compose.dev.yml` e `docker-compose.prod.yml`
- Gli script sono organizzati in sottocartelle `sh/` (Bash) e `ps/` (PowerShell)

## 4. Uso degli Script

### Sviluppo (dev)
- Bash: `./deploy/dev/scripts/sh/start-dev.sh` e `stop-dev.sh`
- PowerShell: `./deploy/dev/scripts/ps/start-dev.ps1` e `stop-dev.ps1`
- Opzione per eliminare volumi: `./start-dev.sh --purge` oppure `./start-dev.ps1 -Purge`

### Produzione (prod)
- Bash: `./deploy/prod/scripts/sh/start-prod.sh` e `stop-prod.sh`
- PowerShell: `./deploy/prod/scripts/ps/start-prod.ps1` e `stop-prod.ps1`
- Opzione per eliminare volumi: `./start-prod.sh --purge` oppure `./start-prod.ps1 -Purge`

### Note
- Gli script gestiscono in modo sicuro l’avvio/stop dei container e la pulizia dei volumi
- È consigliato usare sempre gli script e non i comandi Compose manualmente

## 5. Best Practice

- Mantenere separati i dati e le configurazioni tra dev e prod
- Aggiornare la documentazione in `docs/` in caso di modifiche strutturali
- Verificare sempre i nomi di servizi/container/volumi nei file Compose e negli script
- Per nuove variabili d’ambiente, aggiungerle nei rispettivi file `.env` e Compose

## 6. Documentazione Tecnica

- Architettura e dettagli: vedi `docs/architettura.md`
- Diagrammi e flussi: vedi `docs/` e allegati

---

Per dubbi o aggiornamenti, fare riferimento ai file README e alla documentazione tecnica.
