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
