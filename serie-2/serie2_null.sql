--Ejercicio 1
--Devuelve 0 filas, aunque hay personas sin teléfono.
--NULL significa "valor desconocido": compararlo con = da UNKNOWN (ni verdadero ni falso),
--y el WHERE solo deja pasar las filas verdaderas. Para buscar nulos se usa IS NULL.
SELECT * FROM persona WHERE telefono = NULL;

--Ejercicio 2
--IS NULL → trae los vacíos.
--IS NOT NULL → trae los que tienen dato.
--Lo mismo que antes: nunca <> NULL, porque también da UNKNOWN y te devuelve 0 filas. (<> distinto de)
SELECT persona_id, apellido_nombre, telefono FROM persona WHERE telefono IS NULL;

--Ejercicio 3
SELECT persona_id, apellido_nombre,telefono
FROM persona
WHERE telefono IS NOT NULL

--Ejercicio 4
SELECT persona_id, ISNULL(apellido_nombre,'(Sin dato)') AS 'apellido_nombre', ISNULL(telefono,'(Sin dato)') AS 'telefono'
FROM persona

--Ejercicio 5
SELECT * FROM provincia WHERE provincia_id = 7

SELECT COALESCE(nombre , capital,'(Desconocido)') AS 'nombre'
FROM provincia

--Ejercicio 6
SELECT gasto_id, periodo, importe 
FROM gasto
WHERE importe IS NULL

--Ejercicio 7
--Los registros con importe NULL dan NULL en el cálculo:
--cualquier operación con NULL da NULL, porque no se puede calcular el 10% de un valor desconocido.
SELECT gasto_id, importe, importe * 0.10 AS 'diez_por_ciento'
FROM gasto;

--Ejercicio 8
SELECT gasto_id,ISNULL(importe,0), ISNULL(importe, 0) * 0.10 AS 'diez_por_ciento'
FROM gasto

--Ejercicio 9
SELECT AVG(importe) AS 'promedio_sin_nulos', AVG(ISNULL(importe,0)) AS 'promedio_con_ceros'
FROM gasto

--Ejercicio 10
SELECT COUNT(*) AS 'cantidad_total', COUNT(importe) AS 'cantidad_no_null'
FROM gasto
--COUNT(*) cuenta todas las filas (8000).
--COUNT(importe) no cuenta los NULL (7000). La diferencia son los 1000 gastos sin importe.

--Ejercicio 11
--SQL Server trata los NULL como si fueran el valor más chico de todos.
SELECT persona_id, apellido_nombre, telefono
FROM persona
ORDER BY telefono ASC -->En ASC (de menor a mayor), NULL aparecen al principio.

SELECT persona_id, apellido_nombre, telefono
FROM persona
ORDER BY telefono DESC -->En DESC (de mayor a menor), NULL aparecen al final.

--Ejercicio 12
SELECT persona_id, apellido_nombre, ISNULL(LEN(telefono),0) AS 'longitud_telefono'
FROM persona

--Ejercicio 13
SELECT persona_id, apellido_nombre, fecha_nacimiento
FROM persona
WHERE fecha_nacimiento IS NULL

--Ejercicio 14
SELECT persona_id, apellido_nombre, ISNULL(DATEDIFF(YEAR,fecha_nacimiento,GETDATE()),0)
FROM persona

--Ejercicio 15
SELECT top 4 *
FROM persona

SELECT persona_id, apellido_nombre, ISNULL(telefono,'(sin_cargar)') AS 'telefono', ISNULL(estado_civil,'-') AS 'estado_civil'
FROM persona
WHERE telefono IS NULL OR estado_civil IS NULL

--Verificamos 
SELECT COUNT(*) AS 'cantidad'
FROM persona
WHERE telefono IS NULL OR estado_civil IS NULL -- 62 FILAS

--Ejercicio 16
SELECT top 4 *
FROM administrador

SELECT administrador_id, CASE
							WHEN vive_ahi = 'S' THEN 'residente'
						    WHEN vive_ahi = 'N' THEN 'no_residente'
							ELSE 'desconocido'
						END AS 'vive_ahi'

FROM administrador

--Ejercicio 17
SELECT TOP 4 * FROM gasto

SELECT gasto_id, CONVERT(varchar(10), ISNULL(fecha_pago, '1900/01/01'),103) AS 'fecha_pago_mostrar'
FROM gasto

--Ejercicio 18
SELECT top 4 *  FROM localidad

SELECT provincia_id, localidad_id, ISNULL(nombre, 'Sin nombre asignado') AS 'nombre_localidad'
FROM localidad

--Ejercicio 19
SELECT provincia_id,nombre,poblacion
FROM provincia
WHERE nombre IS NULL OR poblacion IS NULL


--Ejercicio 20
--Opción 1: DESC deja los NULL al final, pero los teléfonos quedan de mayor a menor.
SELECT persona_id, apellido_nombre, telefono
FROM persona
ORDER BY telefono DESC;

--Opción 2: teléfonos cargados primero (de menor a mayor) y NULL al final.
--El CASE le pone una etiqueta a cada fila: 0 si tiene teléfono, 1 si es NULL.
--Se ordena primero por la etiqueta (los 0 arriba) y, si empatan, por el teléfono.
SELECT persona_id, apellido_nombre, telefono
FROM persona
ORDER BY CASE WHEN telefono IS NULL THEN 1 ELSE 0 END, telefono;