USE base_consorcio_2025

---------------------------------
------------ SERIE 1 ------------
---------------------------------

--Ejercicio 1
SELECT *
FROM persona;   --220 filas

--Ejercicio 2
SELECT apellido_nombre AS [Apellido Nombre],
       fecha_nacimiento AS [Fecha Nacimiento]
FROM persona;   --220 filas

--Ejercicio 3
--Precedencia: primero * y /, después + y -.
SELECT 4 + 5 * 3 / 2 - 1;    
--Los paréntesis cambian el orden: se resuelven primero.
SELECT (4 + 5) * 3 / 2 - 1;   

--Ejercicio 4
SELECT importe,
       importe * 1.20 AS 'Sin formato',                              --Cálculo tal cual (4 decimales)
       ROUND(importe * 1.20, 1) AS 'Redondeado a 1 digito decimal',  --Redondea al más cercano (5 o más sube)
       ROUND(importe * 1.20, 1, 1) AS 'Truncado a 1 digito'          --El 3er dato (1) hace que corte sin redondear
FROM gasto;

--Ejercicio 5
SELECT nombre, poblacion
FROM provincia;   --24 filas, una por provincia

--Ejercicio 6
SELECT DISTINCT provincia_id
FROM edificio;

--Ejercicio 7
SELECT TOP 4 *
FROM persona
ORDER BY LEFT(apellido_nombre, 7);   --LEFT: toma solo las 7 primeras letras

--Ejercicio 8
SELECT TOP 4 WITH TIES *
FROM persona
ORDER BY LEFT(apellido_nombre, 7);

--Ejercicio 9

SELECT TOP 4 WITH TIES *
FROM persona
ORDER BY apellido_nombre;

--Ejercicio 10 
SELECT nombre, direccion
FROM edificio WHERE provincia_id = 2;

--Ejercicio 11
SELECT  * FROM edificio
SELECT nombre,direccion FROM edificio WHERE nombre LIKE 'EDIFICIO-3%';

--Ejercicio 12
SELECT apellido_nombre+ ' - ' + CAST(telefono AS varchar) + ' - ' + CONVERT(VARCHAR(11), fecha_nacimiento, 100) AS 'Datos personales'
FROM persona
WHERE sexo = 'f';

--Ejercicio 13
SELECT * FROM gasto WHERE importe >=10.00 AND importe <= 100.00


--Ejercicio 14
SELECT * 
FROM persona
WHERE YEAR(fecha_nacimiento) BETWEEN 1960 AND 1969
ORDER BY fecha_nacimiento DESC;

--Ejercicio 15
SELECT *
FROM localidad
WHERE provincia_id IN (1,2)
ORDER BY provincia_id, nombre;

--Ejercicio 16
SELECT *
FROM edificio
WHERE direccion LIKE '____N%'

--Ejercicio 17
SELECT TOP 237 * 
FROM gasto
ORDER BY importe ASC

--Ejercicio 18
SELECT TOP 237  WITH TIES *
FROM gasto
ORDER BY importe ASC


--Ejercicio 19
Select top 5 * FROM gasto

Select periodo, fecha_pago, importe, 
CASE
    WHEN importe <= 10000 THEN importe * 1.15
    WHEN importe BETWEEN 10000 AND 20000 THEN importe * 1.10
    ELSE importe * 1.05
END AS [Importe actualizado] 
FROM gasto
ORDER BY [Importe actualizado] DESC

--Ejercicio 20 
SELECT SUM(CASE WHEN estado_civil = 'C'THEN 1 ELSE 0 END ) AS 'Casado',
        SUM(CASE WHEN estado_civil = 'S' THEN 1 ELSE 0 END ) AS 'Soltero'
FROM persona

--Ejercicio 21
SELECT SUM(importe) AS 'sumatoria', COUNT(gasto_id) AS 'cantidad', AVG(importe) AS 'promedio' FROM gasto


