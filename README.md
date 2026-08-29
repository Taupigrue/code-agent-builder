# Code Agent Builder 🛠️🤖

Images de conteneur d'exécution (Sandbox Runtime) multi-langages optimisées pour les agents de codage IA autonomes comme **OpenHands**.

---

## 🎯 Objectif

Permettre aux agents IA d'exécuter, compiler, tester et packager du code immédiatement sans avoir à installer manuellement les compilateurs et gestionnaires de paquets au début de chaque session.

---

## 📦 Matrice des Outils & Écosystèmes

| Écosystème | Outils & Compilateurs inclus | Version cible |
|---|---|---|
| **Core & Agent** | OpenHands Action Execution Server, Micromamba, Git, GitHub CLI (`gh`), `jq`, `ripgrep`, `fd`, `build-essential` | Native v0.59.0 |
| **Java / JVM** | OpenJDK JDK & JRE, Maven | Java 21 LTS, Maven 3.9+ |
| **Kotlin & Gradle** | Compilateur Kotlin (`kotlinc`, `kotlin`), Gradle | Kotlin 2.1.20, Gradle 8.13 |
| **TypeScript / JS** | Node.js, npm, pnpm, yarn, bun, typescript (`tsc`), `ts-node`, `tsx` | Node.js 22 LTS, Bun latest |
| **Python** | Python, pip, `uv`, Poetry, pipx, pytest, ruff, black, mypy | Python 3.12 / 3.13 |

---

## 🚀 Utilisation avec OpenHands sur Kubernetes

Pour utiliser cette image dans votre déploiement OpenHands :

1. Définir la variable `SANDBOX_RUNTIME_CONTAINER_IMAGE` dans le manifest de déploiement :

```yaml
env:
  - name: RUNTIME
    value: "kubernetes"
  - name: SANDBOX_RUNTIME_CONTAINER_IMAGE
    value: "ghcr.io/taupigrue/openhands-runtime-multilang:latest"
```

2. OpenHands créera automatiquement chaque pod sandbox de session avec l'ensemble des compilateurs et outils prêts à l'emploi.

---

## 🔨 Construction Locale & Tests

### 1. Construire l'image localement :
```bash
./scripts/build.sh
```

### 2. Tester et vérifier la matrice d'outils :
```bash
./scripts/test.sh
```

---

## 🔄 Intégration Continue (CI/CD)

Le workflow GitHub Actions `.github/workflows/docker-build.yml` :
- Construit automatiquement l'image à chaque push sur `main` ou tag de version.
- Pousse l'image sur **GitHub Packages / Container Registry (GHCR)** : `ghcr.io/taupigrue/openhands-runtime-multilang:latest`.
