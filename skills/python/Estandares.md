# Estándar de Desarrollo Python - Coppel

Este documento asegura la consistencia, legibilidad y seguridad del código Python en todos los proyectos de la organización, basándose en Python 3.12 y herramientas modernas de gestión.

## 1. Ciclo de Vida y Versiones
- **Lenguaje**: 
    - **Nuevos proyectos**: Python 3.12.x.
    - **Existentes**: Mantener compatibilidad con 3.10+.
- **Gestión de Versiones**: Usar `pyenv` para el entorno de desarrollo.
- **Dependencias**: **Poetry > 2.2.1** es la herramienta obligatoria.
    - El archivo `requirements.txt` solo se genera para compatibilidad legacy (Docker/CI-CD específicos) mediante: `poetry export -f requirements.txt --output requirements.txt`.

## 2. Estructura del Proyecto
Se debe seguir un diseño de carpeta `src/`:
- `src/nombre_paquete/`: Código fuente.
- `tests/`: Separar en `unit/` e `integration/`.
- **Archivos de Configuración**: `.env`, `.flake8`, `pyproject.toml`, `poetry.lock`, `README.md`.
- **Nombres de archivos**: Usar `snake_case` (ej. `gestion_usuarios.py`).

## 3. Estilo de Código (Linting y Formato)
- **Indentación**: 4 espacios (prohibido tabuladores).
- **Longitud de línea**: Máximo **88 caracteres** (estándar Black).
- **Líneas en blanco**: 
    - Dos líneas entre funciones/clases de alto nivel.
    - Una línea entre métodos dentro de una clase.
- **Herramientas**:
    - **Black**: Formateador automático.
    - **isort**: Ordenar imports (perfil black).
    - **Flake8**: Verificación de estilo.
    - **mypy**: Verificación estática de tipos.
    - **pre-commit**: Configurar hooks para ejecutar estas herramientas antes de cada commit.

## 4. Convenciones de Nombramiento
| Elemento | Estilo | Ejemplo |
| :--- | :--- | :--- |
| **Clases / Excepciones** | PascalCase (CapWords) | `ProcesadorPedido` |
| **Funciones / Variables** | snake_case | `calcular_total()` |
| **Constantes** | MAYÚSCULAS_CON_GUIONES | `API_TIMEOUT` |
| **Privados** | Prefijo guion bajo | `_metodo_interno` |
| **Protegidos** | Doble guion bajo | `__atributo_mangled` |

## 5. Programación y Tipado
- **Tipado Estático**: Uso obligatorio de **Type Hints** en todas las funciones y métodos.
- **Strings**: 
    - Comillas simples `'` para strings normales.
    - Comillas dobles `"` para docstrings.
    - Preferir **f-strings** para formateo.
- **Funciones**: Pequeñas, un solo propósito y con valores por defecto **inmutables**.
- **Clases**: 
    - Usar `@dataclass` para estructuras de datos simples.
    - Usar `@property` en lugar de getters/setters manuales.

## 6. Manejo de Errores y Concurrencia
- **Excepciones**: Levantar excepciones específicas. No usar `except: Exception`. Crear clases de error personalizadas si es necesario.
- **Contextos**: Usar `with` o `contextlib` para asegurar el cierre de recursos.
- **Concurrencia**: 
    - **I/O Bound**: Usar `asyncio` y `aiohttp`.
    - **CPU Bound**: Usar `ProcessPoolExecutor` de `concurrent.futures`.

## 7. Documentación y Pruebas
- **Docstrings**: Formato **Google Style**. Obligatorio para módulos, clases y funciones públicas.
- **Pruebas**: Usar **pytest**.
    - Prefijo `test_` en archivos y funciones.
    - Usar `fixtures` para setups de bases de datos o clientes.
    - Usar `unittest.mock` para aislar dependencias externas.

## 8. Seguridad
- **Secretos**: Prohibido hardcodear credenciales. Usar `.env` con `python-dotenv`.
- **Validación**: Sanitizar entradas de usuario con librerías como `bleach`.
- **Tokens**: Usar el módulo `secrets` para tokens de seguridad, nunca `random`.