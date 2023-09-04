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
	questions_style TEXT
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
INSERT INTO survey_models (title, num_questions, questions, questions_style) VALUES ('Informe previo','23','Nombre de la aplicación::Fecha de inicio::Duración estimada::Centro::Curso::Asignatura/s::Profesores::Observadores::Número de alumnos::Observaciones::Número de participantes de altas capacidades::Número de participantes con necesidades educativas especiales::Media académica global de los participantes (en la/s asignatura/s)::Métodos de evaluación usados::¿Relación entre resultados de pruebas objetivas y métodos de evaluación?::Actitud del alumno hacia el aprendizaje (general)::Evaluación personal del docente de la actitud académica de los alumnos::Media semanal de deberes::Media semanal de sanciones por comportamiento::Porcentaje mensual de asistencia a clase (cómputo global aproximado)::Integración del alumnado en actividades grupales::Integración del alumnado con necesidades especiales o de altas capacidades (si los hubiera)::Valoración general del docente de la convivencia','text::date::text::text::text::text::text::text::int::text::int::int::float::text::text::text::text::text::text::text::text::text::text');
INSERT INTO survey_models (title, num_questions, questions, questions_style) VALUES ('Encuesta','40','Edad::Nacionalidad::Género::Curso::Me ha gustado el diseño estético de la aplicación::La paleta de colores y las animaciones eran de mi agrado::La herramienta se siente original y moderna::La herramienta NO se percibe anticuada y obsoleta::No he tenido problemas a la hora de navegar por la herramienta, he podido llegar donde quería de forma rápido::La distribución de los menús y pestañas es intuitiva y fácil de comprender::La herramienta es accesible de forma rápida y sencilla, sin necesidad de mucha preparación previa::La herramienta me ayuda a comprender la materia que aprender::El contenido que ofrece la herramienta se adecúa a la materia que estoy estudiando en clase::Me parece que los contenidos expuestos por la aplicación son útiles::Me parecen interesantes las cosas que he aprendido mediante la herramienta, ya que son prácticas en mi día a día.::El contenido enseñado en la herramienta es veraz y coincide con el que he obtenido en clase::No he encontrado contradicciones ni errores conceptuales mientras usaba la herramienta::No me he encontrado ejercicios que hayan bloqueado mi experiencia debido a su dificultad::La dificultad a lo largo de toda la experiencia ha sido progresiva, así como los conceptos que se enseñan::La duración de la experiencia a sido adecuada::La herramienta me ha parecido útil para mi aprendizaje::Creo que gracias a la herramienta he aprendido los conceptos de forma más sencilla::Estoy dispuesto a repetir una experiencia similar en otros cursos o asignaturas::Si pudiera usar esta herramienta en casa, para repasar, la usaría::Recomendaría esta herramienta a amigos o familiares, si tuvieran que aprender los conceptos que enseña::He disfrutado mientras usaba la herramienta::Las actividades que se proponen en la experiencia son divertidas y entretenidas::La materia que se enseña me motiva a continuar usando la herramienta.::Considero que he aprendido bastante sobre la materia::El uso de la herramienta me ha llevado a colaborar con otros compañeros::Colaborar con compañeros me ha ayudado a avanzar en la experiencia::Mientras usaba la herramienta he percibido competitividad con otros compañeros::Me motivaba competir con otros compañeros para ver quien obtenía mejores puntuaciones::Prefiero el uso de estas herramientas a la enseñanza tradicional::Creo que la frecuencia con la que se ha usado la herramienta es la adecuada::Creo que los grupos de trabajo tienen un tamaño adecuado::Considero que había suficientes profesores para gestionar todo el desarrollo de la actividad::Puntúe la experiencia del 0 al 10::Comente brevemente que le ha parecido la experiencia, justificando el punto anterior.::Indique que cosas mejoraría a nivel general así como los puntos fuertes de la experiencia.','int::text::text::text::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int1-5::int0-10::text::text');
INSERT INTO survey_models (title, num_questions, questions, questions_style) VALUES ('Entrevista','19','¿Cree que la herramienta es útil para ayudar en la educación? ¿Por qué? ¿Qué puntos fuertes destacaría? ¿Y puntos débiles?::¿Le ha parecido sencilla de usar? Intuitiva, sin muchos requisitos, etc. Describa en general, el proceso que involucra el uso de la herramienta en el aula, si se producen perdidas de tiempo y que incidentes ha vivido (si se ha dado el caso), que hayan alterado al funcionamiento de esta.::¿Cree que utilizará la herramienta para impartir esta materia el año que viene? Razone su respuesta.::Durante la experiencia, ¿ha sentido en todo momento la situación bajo control? ¿sentía que tenía capacidad para moderar la actividad de forma fácil? Indique si le pareció que la herramienta incluye suficientes opciones de moderación y en caso contrario describa alguna que le hubiese gustado encontrar.::En cuanto al contenido que incluye la herramienta, ¿vio algún contenido inadecuado, en contra de los derechos humanos, o las leyes de copyright? Si la respuesta es afirmativa, describa brevemente la sección o escena donde tiene lugar.::¿Respeta la aplicación la privacidad de sus alumnos? ¿Ha observado alguna sección donde se violen las leyes de protección de datos? Si la respuesta es afirmativa, describa brevemente la sección o escena.::¿Le ha parecido que los medios tecnológicos que usa la herramienta son adecuados? Describa su experiencia, que medios requiere y si sugeriría alguna mejora en este aspecto.::Describa, en general, el comportamiento de los alumnos durante la actividad. ¿Fue adecuado? ¿Mejor o peor que en una clase habitual? ¿Hubo algo que le llamara la atención? Si lo hubo descríbalo brevemente.::¿Se formó escándalo o alboroto durante el desarrollo de la actividad? Si la respuesta es sí ¿cuáles fueron las causas?::¿Percibió mejoras en la integración entre los alumnos? Describa brevemente las experiencias que tuvo relativas a este tema.::¿Percibió en los alumnos cambios en la sociabilidad? ¿Sentimientos de competitividad o colaboración? Describa brevemente las experiencias que observo entre sus alumnos relativas a este tema.::¿Prefiere el uso de la herramienta a las clases tradicionales? ¿Cree que hace la enseñanza más fácil o mas compleja? ¿Cree que es algo que se podría incorporar a la enseñanza a largo plazo?::Durante el uso de la herramienta. ¿Ha visto la cantidad de partes de comportamiento necesarios cambiada? ¿Para bien o para mal?::Valore la experiencia general del 0 al 10::Describa brevemente la experiencia y justifique la puntuación anterior.::Describa cuales han sido los puntos fuertes de la experiencia y que cosas mejoraría.::¿Crees que ha ayudado a que el alumno trabaje y aproveche la asignatura?::¿Crees que los juegos están debidamente aplicados? ¿Permiten valorar el aprendizaje del aluno de forma eficaz y objetiva?::¿Crees que ha sido útil para motivar a trabajar la asignatura?','text::text::text::text::text::text::text::text::text::text::text::text::text::int0-10::text::text::text::text::text');
