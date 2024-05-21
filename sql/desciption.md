Источником данных является файл Данные(1). 

Учебный план:

•	ID

•	Предмет (text)

•	Специальность (int)

•	Преподаватель (int)

•	Группа (int)

•	План (кол-во часов) (int)

•	Факт (кол-во часов) (int)

•	Форма контроля (text)

•	Семестр (int)

•	Год (int)

Ведомость

•	ID

•	Студент (int)

•	Преподаватель (int)

•	Предмет (text)

•	Форма контроля (text)

•	Группа (int)

•	Специальность (int)

•	Учебный план (int)

•	Оценка (text)

•	Дата (date)

Студенты

•	ID

•	ФИО (text)

•	Год рождения (date)

•	Паспортные данные (text)

•	Номер студенческого (text)

•	Специальность (int)

•	Факультет (text)

•	Группа (int)

•	Дата зачисления (date)

•	Дата отчисления(date)

•	Научный руководитель (text)

Преподаватели

•	ID (int)

•	ФИО (text)

•	Должность (text)

•	Дата трудоустройства (date)

•	Дата увольнения (date)

•	Паспортные данные (text)

•	Дата рождения (date)
 

Специальности

•	ID (int)

•	Факультет (text)

•	Название (text)

•	Количество часов (int)

Группы

•	ID (int)

•	Название (text)

•	Специальность (int)

•	Учебный год (int)


### Задание 1

Оцените качество/корректность предоставленных сэмплов данных, приведите примеры по каждой из найденных проблем.

```sql
(удаляю дубликаты из таблицы study_group)
SELECT DISTINCT*
FROM study_group


(среднее значение в колонке fact 208.44, в то время как максимальное значение 6700, что является выбросом в данных)
SELECT avg(fact) FROM public.education_plan
SELECT max(fact) FROM public.education_plan

(В таблице lecturer присутсвуют пропущенные значения)
SELECT * FROM public.lecturer
WHERE id_lecturer is  null

(В таблице Student в колонке enrollment_date используется фиктивное значение 1022 год )
SELECT DATE_PART('year',enrollment_date)
FROM public.student 
ORDER BY enrollment_date ASC

В таблице Student в колонке passport используются некорректные паспортные данные, 14 символов вместо 11)
SELECT id_student, LENGTH(PASSPORT) as length_passport FROM public.student
WHERE LENGTH(PASSPORT) > 11 or LENGTH(PASSPORT) < 11



```
### Задание 2

Приложите текст sql-запросов, решающих следующие проблемы:
1.	Сформировать список студентов, поступивших в университет в 2022 году, даты рождения которых приходятся на 1 полугодие 2007 года. В список вывести ID студента, его ФИО, дату рождения, факультет и дату поступления.               
2.	Вывести список ведомостей 2022 календарного года в следующем формате: дата ведомости, ID ведомости, ФИО студента, ФИО преподавателя, сдаваемый предмет, форму контроля, оценка. В случае, если у студента оценка равна “не зачтено”, то необходимо изменить ее на ‘-’, “зачтено” на ‘+’, а “отл”, “хор”, “удовл” на 5, 4, 3 соответственно.
3.	Сформировать список групп обучения, в которых среднее фактическое количество часов больше 70 в рамках 1 семестра учебного года. В отчет вывести: название группы обучения, факультет, год, семестр, среднее фактическое количество часов. Список необходимо отсортировать по убыванию среднего фактического количества часов.

```sql
SELECT id_student, fio, dob,faculty, enrollment_date 
FROM public.student
WHERE date_part ('year', enrollment_date) = 2022 
and date_part('month', dob) between 1 and 6
and date_part('year', dob) = 2007


SELECT date_statement, id_statement, fio_student,fio_lecturer, subject, control_form,
CASE WHEN grade = 'не зачтено' then '-'
	when grade = 'зачтено' then '+'
	when grade = 'хор' then '4'
	when grade = 'отл' then '5'
	when grade = 'уд' then '3'
	end as оценка
FROM "Statement"
	join student on "Statement".id_student  = student.id_student
	join lecturer on "Statement".id_lecturer = lecturer.id_lecturer
WHERE DATE_PART('year',date_statement) = '2022'

SELECT name_group, faculty, year_education, semester,fact as mean_fact 
FROM education_plan
	join speciality on education_plan.id_specialty = speciality.id_specialty
	join study_group on education_plan.id_group = study_group.id_group
WHERE semester = 1  and  fact > 70
ORDER BY mean_fact desc

SELECT name_group, faculty, year_education, semester,avg(fact) as mean_fact 
FROM education_plan
	join speciality on education_plan.id_specialty = speciality.id_specialty
	join study_group on education_plan.id_group = study_group.id_group
WHERE semester = 1  
Group by name_group, faculty, year_education, semester
Having avg(fact)>70
ORDER BY mean_fact desc



```


