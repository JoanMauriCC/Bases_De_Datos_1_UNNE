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
