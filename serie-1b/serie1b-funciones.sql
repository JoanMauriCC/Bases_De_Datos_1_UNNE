USE base_consorcio_2025
GO

----------------------------------
------------ SERIE 1B ------------
----------------------------------

--Ejercicio 1
SELECT persona_id, apellido_nombre, fecha_nacimiento 
FROM persona
WHERE MONTH(fecha_nacimiento) % 2 = 0

--Ejercicio 2
SELECT edificio_id, nombre, direccion 
FROM edificio
WHERE direccion LIKE '[0-9]%'

--Ejercicio 3
SELECT  * 
FROM persona
WHERE MONTH(fecha_nacimiento) = MONTH(GETDATE())

--Ejercicio 4
SELECT persona_id,apellido_nombre,telefono,LEN(apellido_nombre) AS 'long_ayn'
FROM persona
WHERE LEN(apellido_nombre) BETWEEN 20 AND 25
ORDER BY long_ayn DESC

--Ejercicio 5
SELECT * 
INTO tabla_aux
FROM gasto
WHERE importe >= 50000

SELECT * FROM tabla_aux

--Ejercicio 6
SELECT TOP 5 * FROM administrador

SELECT administrador_id,
CASE 
	WHEN vive_ahi = 'S' THEN 'Residente'
	WHEN vive_ahi = 'N' THEN 'No residente'
	ELSE NULL
END AS 'condicion_recidencial'
FROM administrador

--Ejercicio 7
SELECT persona_id, apellido_nombre
FROM persona
WHERE apellido_nombre LIKE '%LL%' OR apellido_nombre LIKE '%RR%'

--Ejercicio 8
SELECT * 
FROM gasto
WHERE DATEPART(WEEKDAY,fecha_pago) IN (7,1)

--Ejercicio 9
SELECT gasto_id,fecha_pago,importe,
	DATENAME(WEEKDAY,fecha_pago) AS 'Dia de la semana'
FROM gasto 
WHERE MONTH(fecha_pago) BETWEEN 1 AND 3
	AND importe > 20000
	AND DATEPART(WEEKDAY,fecha_pago) NOT IN (7,1)

--Ejercicio 10 
SELECT * 
FROM persona
--WHERE YEAR(GETDATE()) - YEAR(fecha_nacimiento) = 30
WHERE YEAR(GETDATE()) - YEAR(fecha_nacimiento) = 31 --4 rows

--Ejercicio 11
select top 5 * from persona

SELECT persona_id, TRIM(LOWER (apellido_nombre)) AS 'nombre_minuscula', apellido_nombre
FROM persona

--Ejercicio 12
SELECT top 4 *
FROM edificio

SELECT nombre, LEFT(nombre,4) AS 'prefijo' , SUBSTRING(direccion, 1 , 10) AS 'direccion_corta'
FROM edificio

--Ejercicio 13
SELECT persona_id, apellido_nombre, telefono
FROM persona 
WHERE LEFT(telefono, 2) <> '37'

--Ejercicio 14
SELECT top 4 *
FROM zona

SELECT zona_id, nombre , UPPER(LEFT(nombre,1))+LOWER(SUBSTRING(nombre,2,LEN(nombre))) AS 'nombre_formateado'
FROM zona

--Ejercicio 15
SELECT TOP 4 * FROM gasto

SELECT gasto_id, importe, ROUND(importe + importe * 0.125,2) AS 'importe_ajustado'
FROM gasto

--Ejercicio 16
INSERT INTO gasto(provincia_id,localidad_id,edificio_id,periodo,fecha_pago,tipo_gasto_id,importe)
VALUES(1,1,1,6,'2013-06-16 00:00:00.000',5,-600)--Prueba con valor negativo

DELETE FROM gasto WHERE importe < 0

SELECT gasto_id, importe, ROUND(ABS(importe),1) AS 'importe_absoluto'
FROM gasto
WHERE importe < 0 

--Ejercicio 17
SELECT gasto_id, YEAR(fecha_pago) AS 'año_gasto', MONTH(fecha_pago) AS 'mes_gasto', importe
FROM gasto

--Ejercicio 18
SELECT persona_id,apellido_nombre, DATEDIFF(YEAR, fecha_nacimiento, GETDATE())
FROM persona

--Ejercicio 19
SELECT gasto_id, fecha_pago, convert(varchar(10),fecha_pago,103) AS 'fecha_pago_formateada',importe
FROM gasto

SELECT gasto_id,fecha_pago,FORMAT(fecha_pago, 'dd/MM/yyyy') AS 'fecha_pago_formateada',importe
FROM gasto

--Ejercicio 20
SELECT ('Período ' + CAST(periodo AS VARCHAR) + ' - Importe ' + CONVERT(VARCHAR, importe) ) AS 'datos_concatenados'
FROM gasto

--Ejercicio 21
SELECT top 4 * from gasto

SELECT tipo_gasto_id, COUNT(tipo_gasto_id) AS 'cantidad', SUM(importe) AS 'total_importe'
FROM gasto
GROUP BY tipo_gasto_id

--Ejercicio 22
SELECT tipo_gasto_id, COUNT(*) AS 'cantidad', MIN(importe) AS 'minimo', MAX(importe) AS 'maximo', AVG(importe) AS 'promedio', SUM(importe) AS 'total' 
FROM gasto
GROUP BY tipo_gasto_id

--Ejercicio 23
SELECT top 4 * FROM gasto 

SELECT periodo, SUM(importe) AS 'total_periodo', AVG(importe) AS 'promedio_periodo'
FROM gasto
GROUP BY periodo

--Ejercicio 24
SELECT periodo, tipo_gasto_id, COUNT(*) AS 'cantidad', SUM(importe) AS 'total' 
FROM gasto
GROUP BY periodo, tipo_gasto_id


