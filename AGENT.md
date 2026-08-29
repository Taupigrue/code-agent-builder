# Guidelines de Développement - Code Agent Builder

## Description

Projet de construction d'images de conteneur d'exécution (sandbox runtime) multi-langages optimisées pour les agents de codage IA autonomes (OpenHands, etc.).

## Principes Directeurs

- **Compatibilité OpenHands** : L'image de base doit toujours conserver le serveur d'exécution OpenHands (`action_execution_server`), `micromamba`, et les dépendances système requises par OpenHands v0.59+.
- **Multi-langage pré-installé** : Fournir un environnement prêt à l'emploi pour Java 21, Kotlin, Gradle, Maven, TypeScript, JavaScript (Node.js 22, Bun, pnpm, yarn), et Python (uv, poetry, ruff, black).
- **Propreté Git** : Suivre un workflow de branches strict (`feature/<nom>`, `fix/<nom>`), ne jamais commiter directement sur `main`, valider la construction de l'image localement avant PR, et ouvrir les PRs via le CLI `gh`.
- **Test d'outillage** : Toute modification du `Dockerfile` doit être validée via le script `/usr/local/bin/verify-tools`.
