USE base_consorcio_2025
GO

/* =====================================================================
   SERIE 1B - Funciones de fila, agregación y agrupamiento
   =====================================================================

   ÍNDICE RÁPIDO (función -> ejercicios donde se usa)
   ---------------------------------------------------------------------
   FECHAS
     YEAR / MONTH ................ 1, 3, 9, 10, 17, 27, 28, 29, 31, 35
     GETDATE() (fecha de hoy) .... 3, 10, 18
     DATEPART / DATENAME ......... 8, 9
     DATEDIFF .................... 18
     CONVERT (estilo 103) / FORMAT 19
   TEXTO
     LIKE con % y [ ] ............ 2, 7
     LEN ......................... 4, 14
     LOWER / UPPER / TRIM ........ 11, 14
     LEFT / SUBSTRING ............ 12, 13, 14
     Concatenar con + y CAST ..... 20
   NÚMEROS
     % (módulo / resto) .......... 1
     ROUND ....................... 15, 16, 30, 31
     ABS (valor absoluto) ........ 16
   FILTROS
     BETWEEN ..................... 4, 9
     OR / AND .................... 7, 9, 33
     IN / NOT IN ................. 8, 9
     <> (distinto de) ............ 13
   OTROS
     SELECT ... INTO (tabla nueva) 5
     CASE WHEN ................... 6, 34
     INSERT / DELETE ............. 16
   AGREGACIÓN Y AGRUPAMIENTO
     COUNT / SUM / AVG / MIN / MAX 21, 22, 23, 24, 32
     GROUP BY una columna ........ 21, 22, 23, 30, 32
     GROUP BY dos columnas ....... 24, 28, 31
     GROUP BY con función/CASE ... 27, 28, 29, 31, 34, 35
     HAVING ...................... 25, 26, 29, 33, 35
     WHERE + HAVING juntos ....... 26, 35
   ===================================================================== */


/* =====================================================================
   EJERCICIOS 1 AL 4 - Filtros con funciones en el WHERE
   ---------------------------------------------------------------------
   Qué se esperaba: usar funciones DENTRO del WHERE para filtrar.
   - MONTH(fecha) saca el mes (1 a 12).
   - x % 2 = 0 -> número par (el resto de dividir por 2 es 0).
   - LIKE '[0-9]%' -> empieza con un número. [ ] = un carácter de la lista.
   - GETDATE() -> fecha y hora de hoy (paréntesis vacíos).
   - LEN(texto) -> cantidad de caracteres.
   - El alias se puede usar en el ORDER BY, pero NO en el WHERE:
     el WHERE se ejecuta antes que el SELECT, todavía no conoce el alias.
   ===================================================================== */

--Ejercicio 1: personas nacidas en meses pares
SELECT persona_id, apellido_nombre, fecha_nacimiento
FROM persona
WHERE MONTH(fecha_nacimiento) % 2 = 0

--Ejercicio 2: edificios cuya dirección empieza con un número
SELECT edificio_id, nombre, direccion
FROM edificio
WHERE direccion LIKE '[0-9]%'

--Ejercicio 3: personas que cumplen años este mes
SELECT  *
FROM persona
WHERE MONTH(fecha_nacimiento) = MONTH(GETDATE())

--Ejercicio 4: nombres de 20 a 25 caracteres, del más largo al más corto
SELECT persona_id,apellido_nombre,telefono,LEN(apellido_nombre) AS 'long_ayn'
FROM persona
WHERE LEN(apellido_nombre) BETWEEN 20 AND 25
ORDER BY long_ayn DESC


/* =====================================================================
   EJERCICIOS 5 Y 6 - Tablas auxiliares y CASE
   ---------------------------------------------------------------------
   Qué se esperaba:
   - SELECT ... INTO tabla_nueva -> crea una tabla con el resultado.
     El INTO va entre el SELECT y el FROM. La tabla no tiene que existir.
     Para borrarla: DROP TABLE tabla_nueva.
   - CASE WHEN ... THEN ... ELSE ... END -> el "if" de SQL.
     Se queda con el PRIMER WHEN que se cumple. El ELSE atrapa el resto,
     incluidos los NULL.
   ===================================================================== */

--Ejercicio 5: tabla auxiliar con los gastos mayores a 50000
--OJO: "mayores a" es > (con >= también entra el 50000 justo)
SELECT *
INTO tabla_aux
FROM gasto
WHERE importe >= 50000

SELECT * FROM tabla_aux

--Ejercicio 6: condición de residencia del administrador
--OJO: el enunciado pide mostrar 'Sin dato' en el ELSE, no NULL
SELECT TOP 5 * FROM administrador

SELECT administrador_id,
CASE
	WHEN vive_ahi = 'S' THEN 'Residente'
	WHEN vive_ahi = 'N' THEN 'No residente'
	ELSE NULL
END AS 'condicion_recidencial'
FROM administrador


/* =====================================================================
   EJERCICIOS 7 AL 10 - Filtros combinados (OR, AND, NOT IN, días)
   ---------------------------------------------------------------------
   Qué se esperaba:
   - OR -> alcanza con que se cumpla una. AND -> se cumplen todas.
     Cada condición va COMPLETA: columna LIKE ... OR columna LIKE ...
   - LIKE '%LL%' -> CONTIENE "LL" en cualquier lugar.
   - DATEPART(WEEKDAY, fecha) -> número del día de la semana.
     En este SQL Server (en inglés) la semana arranca en domingo:
     1 = domingo ... 7 = sábado. Fin de semana = IN (7, 1).
   - DATENAME(WEEKDAY, fecha) -> nombre del día ('Saturday').
   - NOT IN (...) -> todo MENOS esos valores.
   ===================================================================== */

--Ejercicio 7: apellidos que contienen LL o RR
SELECT persona_id, apellido_nombre
FROM persona
WHERE apellido_nombre LIKE '%LL%' OR apellido_nombre LIKE '%RR%'

--Ejercicio 8: gastos pagados en fin de semana (2210 filas)
SELECT *
FROM gasto
WHERE DATEPART(WEEKDAY,fecha_pago) IN (7,1)

--Ejercicio 9: 1er trimestre, importe > 20000 y NO pagado en fin de semana
SELECT gasto_id,fecha_pago,importe,
	DATENAME(WEEKDAY,fecha_pago) AS 'Dia de la semana'
FROM gasto
WHERE MONTH(fecha_pago) BETWEEN 1 AND 3
	AND importe > 20000
	AND DATEPART(WEEKDAY,fecha_pago) NOT IN (7,1)

--Ejercicio 10: personas que cumplen 30 años este año
--En 2026 da 0 filas (nadie nació en 1996). Con 31 se ve el resultado de la guía (2025).
SELECT *
FROM persona
--WHERE YEAR(GETDATE()) - YEAR(fecha_nacimiento) = 30
WHERE YEAR(GETDATE()) - YEAR(fecha_nacimiento) = 31 --4 rows


/* =====================================================================
   EJERCICIOS 11 AL 14 - Funciones de texto
   ---------------------------------------------------------------------
   Qué se esperaba: transformar y cortar textos.
   - LOWER / UPPER -> minúscula / mayúscula.
   - TRIM -> saca espacios de los costados (LTRIM izq., RTRIM der.).
   - LEFT(texto, n) -> los primeros n caracteres.
   - SUBSTRING(texto, inicio, cantidad) -> desde una posición (arranca en 1).
   - <> -> distinto de.
   - Funciones anidadas: se resuelven de adentro hacia afuera.
   - Formato "Título": primera letra en mayúscula + resto en minúscula,
     pegados con +.
   ===================================================================== */

--Ejercicio 11: nombres en minúscula y sin espacios en los costados
select top 5 * from persona

SELECT persona_id, TRIM(LOWER (apellido_nombre)) AS 'nombre_minuscula', apellido_nombre
FROM persona

--Ejercicio 12: 4 primeras letras del nombre y 10 primeros caracteres de la dirección
SELECT top 4 *
FROM edificio

SELECT nombre, LEFT(nombre,4) AS 'prefijo' , SUBSTRING(direccion, 1 , 10) AS 'direccion_corta'
FROM edificio

--Ejercicio 13: teléfonos que NO empiezan con 37
--(los teléfonos NULL no aparecen: comparar con NULL da "desconocido", ver Serie 2)
SELECT persona_id, apellido_nombre, telefono
FROM persona
WHERE LEFT(telefono, 2) <> '37'

--Ejercicio 14: nombre de zona en formato "Título"
SELECT top 4 *
FROM zona

SELECT zona_id, nombre , UPPER(LEFT(nombre,1))+LOWER(SUBSTRING(nombre,2,LEN(nombre))) AS 'nombre_formateado'
FROM zona


/* =====================================================================
   EJERCICIOS 15 Y 16 - Funciones numéricas
   ---------------------------------------------------------------------
   Qué se esperaba:
   - Aumento del X%: importe * 1.X  (o importe + importe * 0.X).
     12,5% = 0.125 (el porcentaje se divide por 100, decimal con punto).
   - ROUND(valor, decimales) -> redondea. ROUND(valor, d, 1) -> trunca.
   - ABS(numero) -> valor absoluto (sin el signo).
   - INSERT INTO tabla (columnas) VALUES (valores) -> agrega una fila.
     Fechas y textos entre comillas.
   - DELETE FROM tabla WHERE ... -> borra filas. SIEMPRE con WHERE.
   ===================================================================== */

--Ejercicio 15: importe con 12,5% de aumento redondeado a 2 decimales
SELECT TOP 4 * FROM gasto

SELECT gasto_id, importe, ROUND(importe + importe * 0.125,2) AS 'importe_ajustado'
FROM gasto

--Ejercicio 16: importes negativos en positivo, redondeados a 1 decimal
--Orden de ejecución: 1) INSERT de prueba  2) SELECT  3) DELETE para limpiar
INSERT INTO gasto(provincia_id,localidad_id,edificio_id,periodo,fecha_pago,tipo_gasto_id,importe)
VALUES(1,1,1,6,'2013-06-16 00:00:00.000',5,-600)--Prueba con valor negativo

SELECT gasto_id, importe, ROUND(ABS(importe),1) AS 'importe_absoluto'
FROM gasto
WHERE importe < 0

DELETE FROM gasto WHERE importe < 0


/* =====================================================================
   EJERCICIOS 17 AL 20 - Funciones de fecha y conversión
   ---------------------------------------------------------------------
   Qué se esperaba:
   - YEAR / MONTH en el SELECT como columnas calculadas.
   - DATEDIFF(unidad, fecha_vieja, fecha_nueva) -> tiempo entre dos fechas.
     OJO: con YEAR solo resta los años, no mira si ya pasó el cumpleaños.
   - CONVERT(VARCHAR(10), fecha, 103) -> fecha a texto dd/mm/aaaa.
   - FORMAT(fecha, 'dd/MM/yyyy') -> MM en mayúscula = mes (mm = minutos).
   - Concatenar: los números se convierten a texto con CAST o CONVERT,
     porque + entre números SUMA en vez de pegar.
   ===================================================================== */

--Ejercicio 17: año y mes de pago junto al importe
SELECT gasto_id, YEAR(fecha_pago) AS 'año_gasto', MONTH(fecha_pago) AS 'mes_gasto', importe
FROM gasto

--Ejercicio 18: edad actual de cada persona
SELECT persona_id,apellido_nombre, DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) AS 'edad'
FROM persona

--Ejercicio 19: fecha de pago en formato DD/MM/YYYY (dos formas)
SELECT gasto_id, fecha_pago, convert(varchar(10),fecha_pago,103) AS 'fecha_pago_formateada',importe
FROM gasto

SELECT gasto_id,fecha_pago,FORMAT(fecha_pago, 'dd/MM/yyyy') AS 'fecha_pago_formateada',importe
FROM gasto

--Ejercicio 20: período e importe en una sola descripción
SELECT ('Período ' + CAST(periodo AS VARCHAR) + ' - Importe ' + CONVERT(VARCHAR, importe) ) AS 'datos_concatenados'
FROM gasto


/* =====================================================================
   EJERCICIOS 21 AL 24 - GROUP BY
   ---------------------------------------------------------------------
   Qué se esperaba: pasar de ver filas sueltas a RESUMIRLAS por grupos.
   - GROUP BY columna -> arma una "pila" por cada valor distinto
     y calcula UNA fila por pila.
   - COUNT(*) cuenta filas | SUM suma | AVG promedio | MIN el menor | MAX el mayor.
   - COUNT(*) cuenta todas las filas; COUNT(columna) no cuenta los NULL.
   - REGLA DE ORO: toda columna del SELECT que no esté dentro de una
     función de agregado TIENE que estar en el GROUP BY.
   - GROUP BY con 2 columnas -> cada pila es una combinación (24: 12 x 5 = 60 filas).
   ===================================================================== */

--Ejercicio 21: cantidad y suma de importes por tipo de gasto
SELECT top 4 * from gasto

SELECT tipo_gasto_id, COUNT(tipo_gasto_id) AS 'cantidad', SUM(importe) AS 'total_importe'
FROM gasto
GROUP BY tipo_gasto_id

--Ejercicio 22: cantidad, mínimo, máximo, promedio y total por tipo de gasto
SELECT tipo_gasto_id, COUNT(*) AS 'cantidad', MIN(importe) AS 'minimo', MAX(importe) AS 'maximo', AVG(importe) AS 'promedio', SUM(importe) AS 'total'
FROM gasto
GROUP BY tipo_gasto_id

--Ejercicio 23: total y promedio por período (12 filas)
SELECT top 4 * FROM gasto

SELECT periodo, SUM(importe) AS 'total_periodo', AVG(importe) AS 'promedio_periodo'
FROM gasto
GROUP BY periodo

--Ejercicio 24: total y cantidad por período y tipo de gasto (60 filas)
SELECT periodo, tipo_gasto_id, COUNT(*) AS 'cantidad', SUM(importe) AS 'total'
FROM gasto
GROUP BY periodo, tipo_gasto_id


/* =====================================================================
   EJERCICIOS 25 AL 27 - HAVING y GROUP BY por año
   ---------------------------------------------------------------------
   Qué se esperaba: entender la diferencia entre WHERE y HAVING.
   - WHERE  -> filtra FILAS sueltas, ANTES de armar las pilas.
   - HAVING -> filtra PILAS, DESPUÉS de calcularlas. Usa SUM, AVG, COUNT...
   - En el WHERE no se pueden usar funciones de agregado.
   - Orden de las cláusulas:
     SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY
   - Agrupar por una función: se repite la función en el GROUP BY
     (no el alias).
   ===================================================================== */

--Ejercicio 25: períodos cuyo total supera 5000000 (10 filas)
SELECT periodo, sum(importe) AS 'total_periodo'
FROM gasto
GROUP BY periodo
HAVING SUM(importe) > 5000000

--Ejercicio 26: períodos con promedio > 25000, contando solo importes > 4000 (2 filas)
SELECT periodo, AVG(importe) AS 'promedio_periodo'
FROM gasto
WHERE importe > 4000           --filtra cada gasto (antes de agrupar)
GROUP BY periodo
HAVING AVG(importe) > 25000    --filtra cada pila (después de agrupar)

--Ejercicio 27: total de gastos por año de pago (5 filas)
SELECT YEAR(fecha_pago) AS 'anio_pago', SUM(IMPORTE) AS 'total_anual'
FROM gasto
GROUP BY YEAR(fecha_pago)


/* =====================================================================
   EJERCICIOS 28 AL 31 - GROUP BY por fechas y filtros con HAVING
   ---------------------------------------------------------------------
   Qué se esperaba:
   - Agrupar por año Y mes: las dos funciones en el GROUP BY.
   - "No supera" = <=   |  "Supera" / "mayor a" = >
   - ROUND(AVG(...), n) -> primero promedia la pila, después redondea.
   - "Considerando solo..." = condición sobre cada fila -> WHERE.
   ===================================================================== */

--Ejercicio 28: total y promedio por año y mes (51 filas)
SELECT YEAR(fecha_pago) AS 'anio_pago', MONTH(fecha_pago) AS 'mes_pago', SUM(importe) AS 'total_pago', AVG(importe) AS 'promedio_pago'
FROM gasto
GROUP BY YEAR(fecha_pago) , MONTH(fecha_pago)

--Ejercicio 29: años cuyo total NO supera 15000000
SELECT YEAR(fecha_pago) AS 'anio_pago', SUM(importe) AS 'total_anual'
FROM gasto
GROUP BY YEAR(fecha_pago)
HAVING SUM(importe) <= 15000000

--Ejercicio 30: promedio por tipo de gasto redondeado a 1 decimal
SELECT tipo_gasto_id, ROUND(AVG(importe),1) AS 'promedio_redondeado'
FROM gasto
GROUP BY tipo_gasto_id

--Ejercicio 31: promedio mensual (solo importes > 5000) redondeado a 2 decimales (51 filas)
SELECT YEAR(fecha_pago) AS 'anio_pago', MONTH(fecha_pago) AS 'mes_pago', ROUND(AVG(importe),2) AS 'promedio_mensual'
FROM gasto
WHERE importe > 5000
GROUP BY YEAR(fecha_pago), MONTH(fecha_pago)


/* =====================================================================
   EJERCICIOS 32 AL 35 - Repaso de agregación y agrupamiento
   ---------------------------------------------------------------------
   Qué se esperaba: combinar todo lo anterior.
   - HAVING con dos condiciones: se unen con AND.
   - Agrupar por un CASE (columna "inventada"): el CASE va DOS veces,
     en el SELECT con alias (para mostrarlo) y en el GROUP BY completo
     y sin alias (para agrupar). En el ORDER BY sí se puede usar el alias.
   - Truco de lectura: si hay una aclaración entre comas, tachala
     y leé la oración sin ella para ver a qué se refiere cada número.
   ===================================================================== */

--Ejercicio 32: cantidad, total, promedio, máximo y mínimo por período
SELECT periodo , COUNT(*) AS 'cantidad', SUM(importe) AS 'total', AVG(importe) AS 'promedio', MAX(importe) AS 'maximo', MIN(importe) AS 'minimo'
FROM gasto
GROUP BY periodo

--Ejercicio 33: tipos con menos de 1600 registros y promedio mayor a 5000
SELECT tipo_gasto_id, COUNT(*) AS 'cantidad',AVG(importe) AS 'Promedio'
FROM gasto
GROUP BY tipo_gasto_id
HAVING COUNT(*) < 1600 AND AVG(importe) > 5000

--Ejercicio 34: cantidad y promedio por rango de importe (bajo, medio, alto)
SELECT
CASE
	WHEN importe < 5000 THEN 'bajo'
	WHEN importe < 20000 THEN 'medio'
	ELSE 'alto'
END AS 'rango_importe',
COUNT(*) AS 'cantidad' ,AVG(importe) AS 'promedio'
FROM gasto
GROUP BY CASE
	WHEN importe < 5000 THEN 'bajo'
	WHEN importe < 20000 THEN 'medio'
	ELSE 'alto'
END
ORDER BY rango_importe ASC

--Ejercicio 35: años con promedio <= 22000, contando solo importes > 4000
--OJO: la guía ordena por el promedio de mayor a menor: ORDER BY promedio DESC
SELECT YEAR(fecha_pago) AS 'anio_pago', AVG(importe) AS 'promedio'
FROM gasto
WHERE importe > 4000
GROUP BY YEAR(fecha_pago)
HAVING AVG(importe) <= 22000
ORDER BY anio_pago ASC