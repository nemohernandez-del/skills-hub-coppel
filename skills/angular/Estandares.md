# Estándares de Programación Angular - Coppel

Esta guía establece las convenciones y la estructura necesaria para asegurar aplicaciones escalables, mantenibles y consistentes dentro de Coppel.

## 1. Stack Tecnológico
- **Framework**: Angular 16 o superior.
- **Lenguajes**: TypeScript (lógica) y SCSS (estilos).
- **Pruebas**: Jest (Unitarias), Playwright (E2E) y Selenium (Integración).
- **Monitoreo**: Sentry y DebugTracingFeature.
- **UI Components**: PrimeNG.
- **Herramientas**: Uso obligatorio del **Angular CLI** para generar elementos.

## 2. Reglas Generales de Calidad (Regla de Uno)
- **Singularidad**: Definir solo un elemento (servicio, componente, etc.) por archivo.
- **Límites**:
    - **Archivos**: Máximo 400 líneas de código.
    - **Funciones**: Máximo 75 líneas de código.
- **Clasificación de Guías**:
    - **Do**: Seguir siempre (salvo casos extremadamente inusuales).
    - **Consider**: Seguir regularmente, salvo que exista una razón técnica de peso.
    - **Avoid**: Práctica prohibida o casi nunca recomendada.

## 3. Estructura y Scaffolding (Convención Coppel)
La aplicación se organiza por **Características (Features)**, cada una en su propia carpeta con su propio `NgModule`.

### Árbol de Directorio General (`src/app/`):
- `containers/`: Layouts base de la aplicación.
- `modules/`: Código por funcionalidad específica (ámbito concreto).
- `shared/`: Componentes y módulos reutilizables en toda la app.
- `services/`: Servicios de uso genérico o consumo HTTP.
- `models/`: Interfaces y clases genéricas (`.interface.ts`).
- `guards/`, `interceptors/`, `pipes/`, `directives/`, `state/`: Carpetas dedicadas por tipo de utilidad.

### Estructura de un Módulo (`app/modules/feature-a/`):
Cada módulo debe contener su archivo de configuración `[nombre].module.ts` y su routing `[nombre]-routing.module.ts`. Los componentes del módulo residen en su propia subcarpeta `components/`.

## 4. Nomenclatura (Denominación)
- **Archivos**:
    - Usar guiones para separar palabras y puntos para el tipo: `feature.type.ts`.
    - Tipos convencionales: `.service`, `.component`, `.pipe`, `.module`, `.directive`, `.guard`, `.interceptor`.
- **Clases**: Usar `PascalCase` coincidiendo exactamente con el nombre del archivo.
- **Servicios**: Sufijo `Service` (ej. `HeroService`).
- **Selectores de Componentes**: kebab-case con **prefijo personalizado** (ej. `admin-users`).
- **Pipes**: Nombre de clase en `PascalCase` y propiedad `name` en `lowerCamelCase` (sin guiones).

## 5. Componentes y Lógica
- **Archivos Externos**: Extraer plantillas (HTML) y estilos (SCSS) a sus propios archivos si tienen más de 3 líneas.
- **Delegación de Lógica**: 
    - El componente solo debe tener lógica de **presentación**.
    - La lógica de negocio compleja o reutilizable debe delegarse a **Servicios**.
- **Templates**: No poner lógica de negocio dentro del HTML.
- **Propiedades Output**: No anteponer el prefijo `on` (ej. usar `changed` en lugar de `onChanged`).
- **Entradas**: Inicializar siempre los `@Input()` o marcarlos como opcionales con `?`.

## 6. Pipes, Directivas y Servicios de Datos
- **Pipes**: Prohibido agregar lógica de filtrado o clasificación pesada dentro de un Pipe (degrada el rendimiento). Calcular estos datos en el componente/servicio.
- **Directivas**: Usar `@HostListener` y `@HostBinding` en lugar de la propiedad `host` del decorador.
- **Servicios de Datos**: Son los únicos responsables de llamadas XHR (HttpClient), almacenamiento local o en memoria. El componente nunca habla directamente con el servidor.