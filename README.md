# Ecommerce-Builder – Super-Repository di Orchestrazione

Questo repository contiene tutta la logica di orchestrazione, i file di deploy, la documentazione e i riferimenti ai repository di backend e frontend per la piattaforma Ecommerce-Builder.

## Struttura del repository

- `deploy/` – File di orchestrazione Docker Compose, script di avvio/stop per dev e prod
- `docs/` – Documentazione tecnica, architetturale e diagrammi
- `ecommerce-builder-backend/` – Submodule: codice Django REST API ([repo backend](https://github.com/dariofugale95/ecommerce-builder-backend))
- `ecommerce-builder-frontend/` – Submodule: codice React/Vite ([repo frontend](https://github.com/dariofugale95/ecommerce-builder-frontend))
- `.gitignore` – Ignora file temporanei, ambienti virtuali, build, ecc.

## Come clonare il super-repo con i submodule

```sh
git clone --recurse-submodules https://github.com/dariofugale95/ecommerce-builder.git
```
Se hai già clonato senza submodule:
```sh
git submodule update --init --recursive
```

## Aggiornare i submodule
Per aggiornare i repository backend/frontend all’ultima versione:
```sh
git submodule update --remote
```

## Best practice
- **Non modificare direttamente il codice di backend/frontend qui:** lavora nei rispettivi repository e aggiorna i submodule.
- **Usa i file `.env` e gli script in `deploy/`** per gestire ambienti e variabili.
- **Aggiorna la documentazione in `docs/`** per ogni modifica strutturale.
- **Mantieni separati dati e configurazioni tra dev e prod.**
- **Non committare file sensibili o temporanei:** vedi `.gitignore`.

## Link ai repository principali
- **Backend Django:** [ecommerce-builder-backend](https://github.com/dariofugale95/ecommerce-builder-backend)
- **Frontend React/Vite:** [ecommerce-builder-frontend](https://github.com/dariofugale95/ecommerce-builder-frontend)

## Documentazione tecnica
- Architettura: `docs/architettura.md`
- Diagrammi e flussi: `docs/` e allegati

---
Per dubbi o aggiornamenti, fare riferimento ai file README e alla documentazione tecnica.