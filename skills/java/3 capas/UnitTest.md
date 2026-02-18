# API EDOCTA ORQUESTADOR - Testing Guide

## 0. Stack Tecnológico Obligatorio
* **Framework Base:** JUnit 5 (Jupiter API).
* **Mocks:** Mockito con la extensión `@ExtendWith(MockitoExtension.class)`.
* **Estilo de Aserciones:** `org.junit.jupiter.api.Assertions` (uso de `assertEquals`, `assertNotNull`, `assertTrue`, etc.).

## 1. Reglas de Generación de Código
* **Sin Comentarios:** El código debe ser limpio y autoexplicativo. Prohibido incluir líneas comentadas `//` o bloques `/* */`.
* **Formato de Salida:** Tras recibir el código, entrega exclusivamente el bloque de código Java. No incluyas explicaciones de texto antes o después.
* **Cobertura:** Debes cubrir el 100% de los flujos (Happy Path, Edge Cases, Excepciones).
* **Mocking:**
    * Usa `@Mock` para dependencias y `@InjectMocks` para la clase bajo prueba.
    * Usa `MockedStatic<T>` para simular métodos estáticos (ej. `LocalDateTime.now()` o utilerías).
    * Prefiere `Mockito.mockStatic` dentro de bloques `try-with-resources` o manejados en `setUp/tearDown`.

## 2. Patrones de Diseño de Tests (Basados en Ejemplos del Proyecto)

### A. Pruebas de Clases POJO/DTO (Referencia: `MetaTest.java`)
* Testear constructores (sin argumentos y con múltiples argumentos).
* Validar setters y getters.
* Incluir pruebas para métodos generados por Lombok (`equals`, `hashCode`, `toString`).
* **Uso de Fechas:** Si una clase usa marcas de tiempo, mockear `LocalDateTime` para asegurar predictibilidad.

### B. Pruebas de Seguridad/Criptografía (Referencia: `MyAesTest.java`)
* **Métodos Privados:** Si es necesario testear lógica privada, utiliza reflexión mediante un método auxiliar `callPrivateMethod`.
* **Manejo de Excepciones:** Usa `assertThrows` para validar que las entradas malformadas o errores de algoritmo se gestionen correctamente.
* **End-to-End Interno:** Probar el ciclo completo de cifrado y descifrado para validar la integridad de la lógica.

### C. Pruebas de Clases de Utilidad (Referencia: `MyUtilTest.java`)
* **Métodos Estáticos:** Probar cada método estático de forma aislada.
* **Validaciones:** Cubrir casos nulos, vacíos y valores límite (ej. `parseInt` con letras, `isAdmin` con valores negativos).
* **Nested Tests:** Organizar grupos de pruebas lógicas mediante la anotación `@Nested` para mejorar la legibilidad.
* **Parsing:** Validar detalladamente el manejo de JSON y propiedades (ej. usando `ObjectMapper`).

## 3. Restricciones Críticas
* **Prohibido:** No usar `@WebMvcTest`. Para capas web o controladores, utiliza Mockito puro para mockear el comportamiento.
* **Lenguaje:** Solo código Java compatible con la versión 17 (según pom.xml del proyecto).
* **Estructura de Aserción:** Seguir el patrón **Arrange-Act-Assert** de forma implícita mediante saltos de línea, manteniendo el código compacto.

## Dev environment tips
- Use `mvn dependency:tree` to analyze project dependencies instead of scanning manually.
- Run `mvn clean install` to build the project and ensure all dependencies are properly resolved.
- Use `mvn spring-boot:run` to start the Spring Boot application locally for development.
- Check the `pom.xml` file to confirm project configuration and dependencies—this is the main project descriptor.
- Use `mvn help:describe -Dplugin=<plugin-name>` to get information about specific Maven plugins.
- Run `mvn dependency:analyze` to identify unused or missing dependencies.

## Testing instructions
- Find the CI plan in the `.gitlab-ci.yml` file (currently configured for SonarQube analysis).
- Run `mvn test` to execute all unit tests in the project.
- From the project root, you can run `mvn clean test` to ensure a clean test execution.
- To focus on specific test classes, use: `mvn test -Dtest="<TestClassName>"`.
- To run a specific test method, use: `mvn test -Dtest="<TestClassName>#<methodName>"`.
- Use `mvn test -Dtest="*Controller*"` to run all controller tests using pattern matching.
- Run `mvn verify` to execute both unit tests and integration tests.
- Check test coverage with JaCoCo: `mvn jacoco:report` (reports generated in `target/site/jacoco/`).
- Fix any test failures or compilation errors until the whole suite passes.
- After moving files or changing imports, run `mvn compile` to ensure all dependencies resolve correctly.
- Add or update tests for the code you change, even if nobody asked.
- Use `@SpringBootTest` for integration tests and `@ExtendWith(MockitoExtension.class)` for unit tests.
- Follow the existing test structure: separate packages for controllers, services, repositories, and utilities.

## Code quality and analysis
- Run `mvn sonar:sonar` to perform SonarQube analysis (requires SonarQube server configuration).
- Use `mvn checkstyle:check` if Checkstyle is configured for code style validation.
- Run `mvn spotbugs:check` if SpotBugs is configured for static analysis.
- Ensure code coverage meets project standards (check JaCoCo reports).

## Build and packaging
- Run `mvn clean package` to create the application JAR file.
- Use `mvn spring-boot:build-image` to create a Docker image if needed.
- Run `mvn dependency:copy-dependencies` to copy all dependencies to target/dependency/.

## Testing best practices for this project
- **Controllers**: Use `@ExtendWith(MockitoExtension.class)` and mock service dependencies (NO usar @WebMvcTest).
- **Services**: Use `@ExtendWith(MockitoExtension.class)` and mock repository dependencies.
- **Repositories**: Use `@DataJpaTest` for JPA repository testing with in-memory database.
- **Configuration**: Test configuration classes with `@SpringBootTest` and verify bean creation.
- **Utilities**: Use standard JUnit 5 tests (`@Test`) for utility classes and static methods.
- **Integration**: Use `@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)` for full integration tests.
