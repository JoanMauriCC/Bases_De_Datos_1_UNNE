USE base_consorcio_2025
GO
/* =====================================================================
   TIPOS DE JOIN - con ejemplo completo
   =====================================================================

   Tabla EDIFICIO                    Tabla CONSERJE
   +----------+-------------+        +-------------+--------+
   | edificio | conserje_id |        | conserje_id | nombre |
   +----------+-------------+        +-------------+--------+
   | Torre A  | 1           |        | 1           | Juan   |
   | Torre B  | 2           |        | 2           | Pedro  |
   | Torre C  | NULL        |        | 3           | Luis   |
   +----------+-------------+        +-------------+--------+

   Torre A -> Juan  |  Torre B -> Pedro
   Torre C no tiene conserje  |  Luis no trabaja en ningún edificio

   ---------------------------------------------------------------------
   1) INNER JOIN -> SOLO los que tienen pareja en las dos tablas
   ---------------------------------------------------------------------
   SELECT e.edificio, c.nombre
   FROM edificio e
   INNER JOIN conserje c ON e.conserje_id = c.conserje_id

   +----------+--------+
   | edificio | nombre |
   +----------+--------+
   | Torre A  | Juan   |
   | Torre B  | Pedro  |
   +----------+--------+
   -> Torre C y Luis quedan AFUERA (no tienen pareja).

   ---------------------------------------------------------------------
   2) LEFT JOIN -> TODOS los de la izquierda (edificio), con o sin pareja
   ---------------------------------------------------------------------
   SELECT e.edificio, c.nombre
   FROM edificio e
   LEFT JOIN conserje c ON e.conserje_id = c.conserje_id

   +----------+--------+
   | edificio | nombre |
   +----------+--------+
   | Torre A  | Juan   |
   | Torre B  | Pedro  |
   | Torre C  | NULL   |  <- entra igual, sin conserje
   +----------+--------+
   -> Luis queda AFUERA.

   ---------------------------------------------------------------------
   3) RIGHT JOIN -> TODOS los de la derecha (conserje), con o sin pareja
   ---------------------------------------------------------------------
   SELECT e.edificio, c.nombre
   FROM edificio e
   RIGHT JOIN conserje c ON e.conserje_id = c.conserje_id

   +----------+--------+
   | edificio | nombre |
   +----------+--------+
   | Torre A  | Juan   |
   | Torre B  | Pedro  |
   | NULL     | Luis   |  <- entra igual, sin edificio
   +----------+--------+
   -> Torre C queda AFUERA.

   ---------------------------------------------------------------------
   4) FULL OUTER JOIN -> TODOS de los dos lados
   ---------------------------------------------------------------------
   SELECT e.edificio, c.nombre
   FROM edificio e
   FULL OUTER JOIN conserje c ON e.conserje_id = c.conserje_id

   +----------+--------+
   | edificio | nombre |
   +----------+--------+
   | Torre A  | Juan   |
   | Torre B  | Pedro  |
   | Torre C  | NULL   |
   | NULL     | Luis   |
   +----------+--------+
   -> No queda nadie afuera.

   ---------------------------------------------------------------------
   RESUMEN
   ---------------------------------------------------------------------
   INNER -> solo los que tienen pareja
   LEFT  -> todos los de la izquierda (la tabla del FROM)
   RIGHT -> todos los de la derecha (la tabla del JOIN)
   FULL  -> todos de los dos lados
   Donde no hay pareja, las columnas de la otra tabla salen en NULL.
   ===================================================================== */

  --Ejercicio 1
   SELECT tg.nombre, SUM(g.importe) AS [Importe Acumulado]
  FROM gasto g
  INNER JOIN tipo_gasto tg ON g.tipo_gasto_id = tg.tipo_gasto_id
  GROUP BY tg.nombre

  --Ejercicio 2
  SELECT p.nombre AS 'Provincia', l.nombre AS 'Localidad', e.nombre AS 'Consorcio'
  FROM provincia p
  INNER JOIN localidad l ON p.provincia_id = l.provincia_id
  INNER JOIN edificio e ON l.provincia_id = e.provincia_id AND l.localidad_id = e.localidad_id
  ORDER BY p.nombre , l.nombre , e.nombre

  --Ejercicio 3
  SELECT TOP 1 * FROM gasto
  SELECT TOP 1 * FROM tipo_gasto
  SELECT TOP 1 * FROM edificio
  SELECT TOP 1 * FROM provincia

  SELECT TOP 10 e.nombre AS 'Edificio', p.nombre AS 'Provincia', SUM(importe) AS [Total Gastos]
  FROM edificio e
  INNER JOIN provincia p ON p.provincia_id = e.provincia_id
  INNER JOIN gasto g ON g.edificio_id = e.edificio_id 
					 AND g.localidad_id = e.localidad_id 
					 AND g.provincia_id = p.provincia_id	
  GROUP BY e.nombre , p.nombre
  ORDER BY [Total Gastos] DESC


  





