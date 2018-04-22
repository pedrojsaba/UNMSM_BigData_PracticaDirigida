-- 1. Mostrar la mejor nota de Trabajo Práctico por cada curso.

SELECT C.NOMBRE CURSO, MAX(NOTA) MEJOR_NOTA_TP FROM NOTA N
INNER JOIN CURSO C ON N.CURSO = C.CURSO
WHERE TIPO = 3 -- TRABAJO PRACTICO
GROUP BY C.NOMBRE

-- 2. Mostrar el número de alumnos por curso.

SELECT C.NOMBRE CURSO, COUNT(1) CANTIDAD_ALUMNOS FROM ALUMNOCURSO A
INNER JOIN CURSO C ON C.CURSO = A.CURSO
GROUP BY C.NOMBRE
ORDER BY COUNT(1) DESC

-- 3. Mostrar los alumnos invictos.

SELECT NOMBRE INVICTOS FROM ALUMNO
WHERE ALUMNO NOT IN (
	SELECT ALUMNO FROM ALUMNOCURSO WHERE PROMEDIO <= 10
	)
ORDER BY NOMBRE

-- 4. Mostrar los alumnos que han aprobado al menos un curso.

SELECT A.NOMBRE TIENE_APROBADO FROM ALUMNOCURSO AC
INNER JOIN ALUMNO A ON AC.ALUMNO = A.ALUMNO
WHERE AC.PROMEDIO > 10
GROUP BY A.NOMBRE
ORDER BY A.NOMBRE

-- 5. Mostrar el menor promedio del curso ADM322.

SELECT C.NOMBRE CURSO, MIN(AC.PROMEDIO) MENOR_PROMEDIO FROM ALUMNOCURSO AC
INNER JOIN CURSO C ON AC.CURSO = C.CURSO
WHERE C.CURSO = 'ADM322'
GROUP BY C.NOMBRE

-- 6. ¿Cuántos alumnos hay aprobados en el curso ECO325?

SELECT C.NOMBRE CURSO, COUNT(1) CANTIDAD_APROBADOS FROM ALUMNOCURSO AC
INNER JOIN CURSO C ON AC.CURSO = C.CURSO
WHERE C.CURSO = 'ECO325'
AND AC.PROMEDIO > 10
GROUP BY C.NOMBRE

-- 7. Determinar la cantidad de desaprobados por curso.

SELECT C.NOMBRE CURSO, COUNT(1) CANTIDAD_DESAPROBADOS FROM ALUMNOCURSO AC
INNER JOIN CURSO C ON AC.CURSO = C.CURSO
WHERE AC.PROMEDIO <= 10
GROUP BY C.NOMBRE
ORDER BY C.NOMBRE

-- 8. Determinar los alumnos que tienen algún curso desaprobado.

SELECT A.NOMBRE TIENE_DESAPROBADO FROM ALUMNOCURSO AC
INNER JOIN ALUMNO A ON AC.ALUMNO = A.ALUMNO
WHERE AC.PROMEDIO <= 10
GROUP BY A.NOMBRE
ORDER BY A.NOMBRE

-- 9. Determinar qué curso tiene mejor relación número de aprobados/cantidad de alumnos.

SELECT C.NOMBRE CURSO, A.APROBADOS,T.TOTAL, A.APROBADOS/T.TOTAL RELACION FROM CURSO C 
LEFT JOIN (
    SELECT C.CURSO, COUNT(1) APROBADOS FROM ALUMNOCURSO AC
    INNER JOIN CURSO C ON C.CURSO = AC.CURSO
    WHERE AC.PROMEDIO > 10
    GROUP BY C.CURSO
    ) A ON C.CURSO = A. CURSO
LEFT JOIN (
    SELECT C.CURSO, COUNT(1) TOTAL FROM ALUMNOCURSO AC
    INNER JOIN CURSO C ON C.CURSO = AC.CURSO
    GROUP BY C.CURSO
    ) T ON C.CURSO = T. CURSO
ORDER BY A.APROBADOS/T.TOTAL DESC