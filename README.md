# Bases de Datos I – UNNE

Ejercicios prácticos de **SQL Server** resueltos durante la cursada de **Bases de Datos I**, en la Licenciatura en Sistemas de Información (FaCENA – Universidad Nacional del Nordeste).

Cada consulta está comentada explicando qué hace y por qué, como material de estudio y práctica.

## Tecnologías

- **Motor:** Microsoft SQL Server (Express)
- **Herramienta:** SQL Server Management Studio (SSMS)
- **Lenguaje:** T-SQL
- **Base de datos:** `base_consorcio` (provista por la cátedra, no incluida en el repositorio)

## Estructura

```
Bases_De_Datos_1_UNNE/
├── README.md
└── serie-1/
    └── serie1_sentencias_basicas.sql
```

## Serie 1 – Sentencias SQL (DML)

Consultas básicas de selección, filtrado y ordenamiento.

| Ejercicio | Tema | Conceptos |
|---|---|---|
| 1 | Listar todo el contenido de una tabla | `SELECT *` |
| 2 | Seleccionar columnas puntuales | Columnas, alias con `AS` |
| 3 | Precedencia de operadores | Operadores aritméticos, división entera |
| 4 | Aumento del 20% en 3 formatos | Columnas calculadas, `ROUND` (redondeo y truncado) |
| 5 | Nombre y población de provincias | `SELECT` de columnas |
| 6 | Códigos de provincia sin repetir | `DISTINCT` |
| 7 | Primeras 4 personas ordenadas | `TOP`, `ORDER BY`, `LEFT` |
| 8 | Primeras 4 incluyendo empates | `WITH TIES` |
| 9 | Diferencia de empates según el criterio | `ORDER BY` por campo completo |
| 10 | Edificios de una provincia | `WHERE` |
| 11 | Edificios cuyo nombre empieza con un texto | `LIKE` con `%` |
| 12 | Varias columnas en una sola | Concatenación con `+`, `CAST`, `CONVERT` |
| 13 | Gastos dentro de un rango | `BETWEEN`, `AND` |
| 14 | Personas nacidas en los 60 | `YEAR`, `ORDER BY DESC` |
| 15 | Localidades de dos provincias | `IN`, orden por varios campos |
| 16 | Dirección con una letra en posición fija | `LIKE` con `_` |
| 17 | Los 237 gastos menos costosos | `TOP n` |
| 18 | Incluir importes repetidos | `TOP n WITH TIES` |
| 19 | Aumento según rango de importe | `CASE WHEN` |
| 20 | Casados y solteros en una fila | `SUM` + `CASE` |
| 21 | Total, cantidad y promedio de gastos | `SUM`, `COUNT`, `AVG` |

## Cómo usarlo

1. Restaurar la base `base_consorcio` en SQL Server.
2. Abrir el archivo `.sql` de la serie en SSMS.
3. Seleccionar la base en el desplegable y ejecutar cada consulta por separado (seleccionarla y presionar **F5**).

## Próximamente

- Serie 1B – Funciones de fila, agregación y agrupamiento
- Serie 2 – Manejo de valores `NULL`

## Autor

**Joan Mauri** – Estudiante de Licenciatura en Sistemas de Información, UNNE
GitHub: [@JoanMauriCC](https://github.com/JoanMauriCC)
