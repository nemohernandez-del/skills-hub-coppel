# Estándares de Programación PHP - Coppel

El objetivo de esta guía es aumentar la calidad de codificación y reducir la dificultad de lectura entre diferentes autores.

## 1. Archivos y Estructura
- **Nombre de archivo**: Formato `UpperCamelCase`. Si contiene una clase, debe llamarse igual que la clase.
- **Extensión**: Siempre `.php`.
- **Codificación**: UTF-8 sin BOM. Saltos de línea estilo Unix (LF).
- **Etiquetas**: Usar etiquetas largas `<?php ?>` o cortas de impresión `<?= ?>`. 
- **Cierre**: Omitir la etiqueta de cierre `?>` en archivos que solo contengan PHP.
- **Efectos secundarios**: Un archivo debe declarar estructuras (clases, funciones) O ejecutar lógica, pero NO ambas. Se debe evitar generar salidas o incluir archivos externos en el mismo archivo donde se declara una clase.

## 2. Nomenclatura (Nombramientos)
- **Variables y Funciones**: Formato `lowerCamelCase`. No usar notación húngara ni guiones bajos.
- **Clases, Traits y Traits**: Formato `UpperCamelCase`.
- **Interfaces**: Formato `I` + `UpperCamelCase` (ej. `ICliente`).
- **Idioma**: Usar español para lógica de negocio (`$cantidadTotal`) e inglés para contextos técnicos (`$db->getConnection()`).
- **Palabras reservadas**: Siempre en minúsculas, incluyendo `true`, `false` y `null`.

## 3. Formato y Estilo Visual
- **Indentación**: 4 espacios. Prohibido el uso de tabuladores.
- **Líneas**: Límite flexible de 120 caracteres. No debe haber espacios en blanco al final de las líneas.
- **Sentencias**: Solo una sentencia por línea.
- **Espacios de nombres**: Debe haber una línea en blanco después de `namespace` y después del bloque de declaraciones `use`.

## 4. Clases y Métodos
- **Declaración**: `extends` e `implements` en la misma línea que el nombre de la clase. La llave de apertura de la clase en la línea siguiente.
- **Propiedades**: La visibilidad (`public`, `protected`, `private`) es obligatoria. No usar `var`. No usar guion bajo como prefijo.
- **Métodos**: Visibilidad obligatoria. La llave de apertura en su propia línea. Sin espacio después del nombre del método.
- **Argumentos**: Espacio después de cada coma, no antes. Valores por defecto al final de la lista.
- **Modificadores**: `abstract` y `final` van antes de la visibilidad; `static` va después (ej. `final public static function`).

## 5. Estructuras de Control
- **General**: Espacio después de la palabra clave, sin espacios internos en los paréntesis, espacio antes de la llave de apertura. Las llaves son obligatorias.
- **if/elseif/else**: Usar `elseif` (una sola palabra).
- **switch**: `case` indentado una vez respecto al switch. `break` indentado al nivel del cuerpo del case. `default` es obligatorio.
- **Closures**: Espacio después de `function` y antes/después de `use`.

## 6. Base de Datos (PDO)
- **Componente**: Es obligatorio el uso de **PDO**.
- **Atributos**:
    - `PDO::ATTR_ERRMODE` => `PDO::ERRMODE_EXCEPTION`
    - `PDO::ATTR_DEFAULT_FETCH_MODE` => `PDO::FETCH_ASSOC`
- **Seguridad**: Prohibida la concatenación de strings en queries. Uso obligatorio de **Prepared Statements**.
- **Sanitización**: Filtrar toda información proveniente de `GET` o `POST`.
- **Conexiones**: Asignar `null` al objeto PDO y al `PreparedStatement` para cerrar la conexión explícitamente cuando ya no sea necesario.

## 7. SQL Server y Particularidades
- **Drivers**: En Windows se usa `sqlsrv`; en Linux se usa `dblib` (FreeTDS).
- **FreeTDS**: Los cursores no se cierran solos; es obligatorio llamar a `$statement->closeCursor()` de forma explícita después del fetch.

## 8. Arquitectura Sugerida
Se debe separar la interacción de base de datos de la lógica de presentación siguiendo un esquema MVC manual:
- **Modelo**: Clases que encapsulan el acceso a datos mediante PDO.
- **Vista**: Archivos PHP con lógica mínima (loops y echo) para mostrar datos.
- **Controlador**: Archivo que instancia el modelo y carga la vista.
