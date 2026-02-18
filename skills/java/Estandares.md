# Estándares de Programación Java - Coppel

Este documento detalla las normas de codificación obligatorias para asegurar la uniformidad y calidad del software en Coppel.

## 1. Ciclo de Vida y Versiones
- **Política N-2**: Se soportan las últimas 3 versiones LTS oficiales (actualmente **11, 17 y 21**).
- **Soporte**: Se utiliza la distribución **Eclipse Temurin (Adoptium)** de OpenJDK.

## 2. Archivos y Formato
- **Nombre de archivo**: Debe coincidir exactamente con la clase de nivel superior; solo caracteres alfanuméricos (sin guiones bajos). Extensión `.java`.
- **Codificación**: UTF-8 con saltos de línea estilo **Unix**.
- **Líneas**: Una sentencia por línea. Límite de **80 o 100 caracteres** por línea.
- **Indentación**: **4 espacios** por cada bloque; prohibido el uso de tabuladores (ASCII 0x20 únicamente).

## 3. Estructura del Archivo e Importaciones
- **Orden de secciones**: 1. Licencia/Copyright, 2. `package`, 3. `import`, 4. Clase única. Separar cada sección con una línea en blanco.
- **Nomenclatura de Paquetes**: Todo en minúsculas, palabras concatenadas sin guiones (ej. `com.coppel.comprasropa.pedidos`).
- **Importaciones**: 
    - **Prohibido el uso de wildcards** (ej. `import java.util.*;`).
    - **Orden de Imports**: 1. Estáticos, 2. `com.coppel`, 3. Proveedores externos (orden alfa), 4. `java`, 5. `javax`.

## 4. Nomenclatura (Naming Convention)
- **Clases e Interfaces**: `UpperCamelCase`. Sustantivos descriptivos. Sin prefijos (no usar `I` para interfaces).
- **Pruebas**: `NombreClaseTest` o `NombreClaseIntegrationTest`. Ubicadas en paquete `test`.
- **Métodos y Parámetros**: `lowerCamelCase`. Los parámetros no deben ser de un solo carácter.
- **Variables Locales**: `lowerCamelCase`. Se permiten nombres cortos (i, j) solo en ciclos `for`.
- **Constantes**: `CONSTANT_CASE` (Mayúsculas con guion bajo).
- **Genéricos**: Una sola letra mayúscula (T, E) o nombre seguido de T (ej. `RequestT`).

## 5. Modificadores y Estructuras de Control
- **Orden de Modificadores**: `public`, `protected`, `private`, `abstract`, `static`, `final`, `transient`, `volatile`, `synchronized`, `native`, `strictfp`.
- **Bloques**: Las llaves `{}` son obligatorias siempre, incluso para una sola línea. Estilo **K&R (Egyptian braces)**.
- **Switch**: Siempre debe incluir el caso `default`, incluso si está vacío.

## 6. Sobrecarga, Excepciones y Estáticos
- **@Override**: Obligatorio siempre que sea legalmente posible.
- **Excepciones**: Prohibido silenciar excepciones. Prohibido el uso de `catch(Exception ex)` genérico; capturar la excepción específica.
- **Miembros Estáticos**: Deben llamarse usando el nombre de la clase, nunca a través de una instancia.

## 7. JavaDoc
- **Obligatoriedad**: En toda clase pública y miembro protegido.
- **Estructura**: Descripción clara + línea en blanco + anotaciones (`@param`, `@return`, `@throws`, `@author`).
- **Comentarios internos**: Evitar comentarios dentro de los métodos; la lógica debe explicarse en el JavaDoc.

## 8. Conexión a Bases de Datos (JDBC)
- **PreparedStatement**: Obligatorio sobre `Statement` para seguridad (SQL Injection) y rendimiento.
- **Credenciales**: Prohibido dejar IP, usuarios o passwords en código duro.
- **Optimización**: 
    - Inhabilitar `autoCommit` para transacciones pesadas.
    - Usar `addBatch()` y `executeBatch()` para inserciones múltiples.
- **ResultSet**: Acceder a columnas por **nombre** (String), nunca por índice numérico.
- **Cierre de Recursos**: Cerrar siempre `Connection` y `Statement` en el bloque `finally` o mediante `try-with-resources`.

## 9. REST en Java
- **Implementación**: Basado en **Jersey/JAX-RS**.
- **Consumo**: Uso de `ClientBuilder`, `WebTarget` y entidades para peticiones POST/GET.
- **Visibilidad**: Los recursos deben exponerse mediante la anotación `@Path`.

## 10. Memoria y Otros
- **Memory Management**: Liberación explícita de recursos y nulificación de objetos grandes cuando sea necesario para ayudar al GC.
- **Estructuras Struct**: Java no cuenta con ellas nativamente; se utilizan clases POJO o Records siguiendo la estructura lógica de miembros.