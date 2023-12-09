DROP DATABASE IF EXISTS surveymaker;
CREATE DATABASE surveymaker;
CREATE USER svmaker WITH PASSWORD 'svmaker';
ALTER USER svmaker WITH SUPERUSER;

\c surveymaker;


-- Crea la tabla de configuraciones generales
CREATE TABLE configurations (
	setting_name VARCHAR(20) NOT NULL PRIMARY KEY,
	setting_value TEXT
);

CREATE TABLE experiments (
	id SERIAL PRIMARY KEY,
	title TEXT,
	surveys TEXT,
	answers TEXT
);

CREATE TABLE survey_models (
	id SERIAL PRIMARY KEY,
	title TEXT,
	num_questions INTEGER,
	questions TEXT,
	questions_style TEXT,
	instructions TEXT
);

CREATE TABLE surveys (
	id VARCHAR(6) NOT NULL PRIMARY KEY,
	survey_model INTEGER,
	descriptor TEXT,
	FOREIGN KEY (survey_model) REFERENCES survey_models(id)
);

CREATE TABLE answers (
	id SERIAL PRIMARY KEY,
	survey VARCHAR(6),
	fill_date DATE,
	data TEXT,
	FOREIGN KEY (survey) REFERENCES surveys(id)
);

-- La clave es admin1 codificado en aes
INSERT INTO configurations VALUES ('admin_password','GmBdaXyYoDZJP663Ss/Jkg==');
INSERT INTO survey_models (title, num_questions, questions, questions_style,instructions) VALUES ('Informe previo','25','Nombre de la aplicación a usar::Fecha de inicio::Duración completa de toda la experiencia::Número de sesiones de gamificación::Duración de las sesiones de gamificación (minutos)::Recompensa (Sí/No), si sí, ¿cuál?::Centro::Curso::Asignatura/s::Profesores::Observadores::Número de participantes esperados::Número de participantes de altas capacidades::Número de participantes con necesidades educativas especiales::Observaciones (1)::Media académica de los participantes en la asignatura el curso anterior (2)::Método de evaluación principal usado en la asignatura (3)::¿Relación entre resultados de pruebas objetivas y métodos de evaluación? (4)::Actitud del alumno hacia el aprendizaje (5)::Carga de trabajo de la asignatura media (horas de trabajo en casa/semana) (6)::Media semanal de sanciones por comportamiento::Porcentaje mensual de asistencia a clase (cómputo global aproximado)::Integración del alumnado en actividades grupales (7)::Integración del alumnado con necesidades especiales o de altas capacidades (si los hubiera) (8)::Valoración general del docente de la convivencia (9)','text::date::text::int::int::text::text::text::text::text::text::int::int::int::text::float::text::text::int::float::text::text::int::int::int','(1)  Incluir en observaciones cualquier otro dato de los alumnos que se considere relevante. O cualquier comentario que quiera que se vea reflejado en este documento. Ejemplo: ""alumnado procedente de distintos centros con nivel muy heterogéneo"", ""algunos alumnos no han cursado asignaturas similares en años previos"".<br/>
(2)  Por ejemplo, si la asignatura experimental es Biología en unos participantes de 4º de ESO, indicar la media global de todos de Biología en 3º de ESO. Si ese dato no esta disponible, indicar la media de la última prueba de nivel realizada este curso.<br/>
(3)  Distinguir entre:<br/>
	A.- Prueba escrita<br/>
	B.- Prueba oral<br/>
	C.- Trabajo final<br/>
	D.- Otro (indique cuál)<br/>
(4) Responda:<br/>
	Sí: si cree que la media académica de los alumnos está directamente relacionada con el método de evaluación empleado (y cambiaría considerablemente si usara otro)<br/>
	No: si cree que independientemente del método de evaluación que utilizara la media de los alumnos permanecería inalterada.<br/>
(5)  Puntúe de 0 a 10 lo interesado que está el alumno en la asignatura y su contenido.<br/>
(6)  Tiempo que deberían dedicar en casa a la asignatura a juicio del profesor.<br/>
(7) (8)  (9)  Puntúe de 0 a 10. (<0 si no aplica)<br/>');
INSERT INTO survey_models (title, num_questions, questions, questions_style,instructions) VALUES ('Encuesta','43','Edad::Nacionalidad::Género::Curso::Me ha gustado el diseño estético de la aplicación::La paleta de colores y las animaciones eran de mi agrado::La herramienta se siente original y moderna::La herramienta cumple mis estándares para su uso::No he tenido problemas a la hora de navegar por la herramienta, he podido llegar donde quería de forma rápida::La distribución de los menús y pestañas es intuitiva y fácil de comprender::La herramienta es accesible de forma rápida y sencilla, sin necesidad de mucha preparación previa::La herramienta me ayuda a comprender la materia de la asignatura::El contenido que ofrece la herramienta se adecúa a la materia que estoy estudiando en clase::Me parece que los contenidos expuestos por la aplicación son útiles::Me parecen interesantes las cosas que he aprendido mediante la herramienta, ya que son prácticas en mi día a día.::El contenido enseñado en la herramienta es veraz y coincide con el que he obtenido en clase::No he encontrado contradicciones ni errores conceptuales mientras usaba la herramienta::No me he encontrado ejercicios que hayan bloqueado mi experiencia debido a su dificultad::La dificultad a lo largo de toda la experiencia ha sido progresiva, así como los conceptos que se enseñan::La duración de la experiencia a sido adecuada::(Opcional) ¿Cambiarías la duración? ¿Harías la expereiencia más larga o más corta?::La herramienta me ha parecido útil para mi aprendizaje::Creo que gracias a la herramienta he aprendido los conceptos de forma más sencilla::Estoy dispuesto a repetir una experiencia similar en otros cursos o asignaturas::Si pudiera usar esta herramienta en casa, para repasar, la usaría::Recomendaría esta herramienta a amigos o familiares, si tuvieran que aprender los conceptos que enseña::He disfrutado mientras usaba la herramienta::Las actividades que se proponen en la experiencia son divertidas y entretenidas::La materia que se enseña me motiva a continuar usando la herramienta.::Considero que he aprendido bastante sobre la materia::El uso de la herramienta me ha llevado a colaborar con otros compañeros::Colaborar con compañeros me ha ayudado a avanzar en la experiencia::Mientras usaba la herramienta he percibido competitividad con otros compañeros::Me motivaba competir con otros compañeros para ver quien obtenía mejores puntuaciones::Prefiero el uso de estas herramientas a la enseñanza tradicional::Creo que la frecuencia con la que se ha usado la herramienta es la adecuada::(Opcional) ¿Cambiarías la frecuencia? ¿Harías sesiones más juntas o más separadas?::Creo que los grupos de trabajo tienen un tamaño adecuado::(Opcional) ¿Cambiarías el tamaó de los grupos? ¿Te gustaría trabajar en grupos más grandes o más pequeños?::Considero que había suficientes profesores para gestionar todo el desarrollo de la actividad::Puntúe la experiencia del 0 al 10::Comente brevemente que le ha parecido la experiencia, justificando el punto anterior.::Indique que cosas mejoraría a nivel general así como los puntos fuertes de la experiencia.','int::text::text::text::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::text_opt::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::text_opt::int1-5::text_opt::int1-5::int0-10::text::text','Lea atentamente todas las preguntas y tómese el tiempo que considere necesario.');
INSERT INTO survey_models (title, num_questions, questions, questions_style,instructions) VALUES ('Entrevista','30','<u>¿Cree que la herramienta es útil para ayudar en la educación?</u> (0 totalmente inútil – 10 indispensable) ¿Por qué? ¿Qué puntos fuertes destacaría? ¿Y puntos débiles?::(Opcional) Desarrolle la respuesta::<u>¿Le ha parecido sencilla de usar?</u> (0 incomprensible – 10 sencillísima) Intuitiva, sin muchos requisitos, etc. Describa en general, el proceso que involucra el uso de la herramienta en el aula, si se producen pérdidas de tiempo y que incidentes ha vivido (si se ha dado el caso), que hayan alterado al funcionamiento de esta.::(Opcional) Desarrolle la respuesta::<u>¿Cree que utilizará la herramienta para impartir esta materia en próximas experiencias?</u> (0 definitivamente no – 10 obviamente sí) Razone su respuesta.::(Opcional) Desarrolle la respuesta::Durante la experiencia, <u>¿ha sentido en todo momento la situación bajo control? ¿sentía que tenía capacidad para moderar la actividad de forma fácil?</u> (0 no tenía ninguna forma de moderar -10 control total sobre la situación). Indique si le pareció que la herramienta incluye suficientes opciones de moderación (1) y en caso contrario describa alguna que le hubiese gustado encontrar.::(Opcional) Desarrolle la respuesta::<u>¿Le ha parecido que los medios tecnológicos que usa la herramienta son adecuados?</u> (0 definitivamente no – 1 es el medio perfecto) Describa su experiencia, que medios requiere y si sugeriría alguna mejora en este aspecto.::(Opcional) Desarrolle la respuesta::Describa, en general, el comportamiento de los alumnos durante la actividad. <u>¿Fue el comportamiento de los alumnos adecuado?</u> (0 desastroso, mucho peor de lo habitual – 10 excelente) ¿Mejor o peor que en una clase habitual? ¿Hubo algo que le llamara la atención? Si lo hubo descríbalo brevemente.::(Opcional) Desarrolle la respuesta::<u>¿Hubo mucho escándalo o alboroto durante el desarrollo de la actividad?</u> (0 mucho alboroto – 10 nada de alboroto) Si la respuesta es sí ¿cuáles fueron las causas?::(Opcional) Desarrolle la respuesta::<u>¿Percibió mejoras en la integración entre los alumnos?</u> (0 sin mejoras – 10 mejoras sobresalientes) Describa brevemente las experiencias que tuvo relativas a este tema.::(Opcional) Desarrolle la respuesta::<u>¿Percibió en los alumnos cambios en la sociabilidad? ¿Sentimientos de competitividad o colaboración?</u> (0 sin cambios – 10 incrementos notables) Describa brevemente las experiencias que observo entre sus alumnos relativas a este tema.::(Opcional) Desarrolle la respuesta::<u>¿Prefiere el uso de la herramienta a las clases tradicionales?</u> (0 absolutamente no – 10 si, sin duda) ¿Cree que hace la enseñanza más fácil o más compleja? ¿Cree que es algo que se podría incorporar a la enseñanza a largo plazo?::(Opcional) Desarrolle la respuesta::Durante el uso de la herramienta. <u>¿Ha visto la cantidad de partes de comportamiento necesarios cambiada para bien?</u> (0 no, nada – 10 sí, mucho) Si es así describa cuales cree que pueden ser los factores que lo provoquen.::(Opcional) Desarrolle la respuesta::<u>Valore la experiencia general.</u> (0 muy mala – 10 muy buena) Describa brevemente la experiencia y justifique la puntuación anterior. Describa cuales han sido los puntos fuertes de la experiencia y que cosas mejoraría.::(Opcional) Desarrolle la respuesta::<u>¿Crees que ha ayudado a que el alumno trabaje y aproveche la asignatura?</u> (0 para nada – 10 sí, considerablemente)::(Opcional) Desarrolle la respuesta::<u>¿Crees que los juegos están debidamente aplicados?</u> (0 para nada – 10 sí, considerablemente) ¿Permiten valorar el aprendizaje del aluno de forma eficaz y objetiva?::(Opcional) Desarrolle la respuesta::<u>¿Crees que ha sido útil para motivar a trabajar la asignatura?</u> (0 para nada – 10 sí, considerablemente).::(Opcional) Desarrolle la respuesta','int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt::int0-10::text_opt','Cada pregunta tiene dos respuestas, una numérica del 0 al 10 o <0 si considera que no aplica, y otra textual donde se le permite desarrollar, justificar y reflexionar sobre su pregunta anterior . Los enunciados contienen una pregunta principal (subrayada) y luego una serie de preguntas extras que invitan a que narre su experiencia y su punto de vista. Es obligatorio responder a las preguntas de forma numérica, la respuesta textual es opcional.');
