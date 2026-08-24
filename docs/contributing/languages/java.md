# Java notes

- **Build**: Maven (`pom.xml`) or Gradle (`build.gradle`, `build.gradle.kts`).
  Use the repo's wrapper (`./mvnw`, `./gradlew`) rather than a global
  install.
- **Formatting and lint**: the repo's formatter and static analysis (spotless,
  checkstyle, PMD, or similar) as configured.
- **Tests**: JUnit (4/5) under `src/test/`; run the targeted test class then
  the module suite.
- **Naming**: `camelCase` methods and fields, `PascalCase` classes, constants
  `UPPER_SNAKE_CASE`.
- **Immutability**: prefer immutable fields and records where the repo does.
- **Dependencies**: `pom.xml`/`build.gradle` pinned; don't add one for a
  one-line helper.

## Common traps for agents

- Wrapping everything in try/catch and swallowing errors.
- Using the wrong test framework for the repo.
- Formatting with a different tool than the repo's (style churn).
