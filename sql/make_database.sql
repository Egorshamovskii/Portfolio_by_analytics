CREATE TABLE IF NOT EXISTS public."Statement"
(
    id_statement integer,
    id_student integer,
    id_lecturer integer,
    subject text COLLATE pg_catalog."default",
    control_form text COLLATE pg_catalog."default",
    id_group integer,
    id_specialty integer,
    id_ed_plan integer,
    grade text COLLATE pg_catalog."default",
    date_statement date,
    id bigint NOT NULL,
    CONSTRAINT "Statement_pkey" PRIMARY KEY (id),
    CONSTRAINT lecturer_pkey FOREIGN KEY (id_lecturer)
        REFERENCES public.lecturer (id_lecturer) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT student_pkey FOREIGN KEY (id_student)
        REFERENCES public.student (id_student) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Statement"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.education_plan
(
    id_ed_plan integer NOT NULL,
    subject text COLLATE pg_catalog."default",
    id_specialty integer,
    id_lecturer integer,
    id_group integer,
    plan integer,
    fact integer,
    control text COLLATE pg_catalog."default",
    semester integer,
    year_education integer,
    CONSTRAINT education_plan_pkey PRIMARY KEY (id_ed_plan),
    CONSTRAINT group_key FOREIGN KEY (id_group)
        REFERENCES public.study_group (id_group) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT speciality_key FOREIGN KEY (id_specialty)
        REFERENCES public.speciality (id_specialty) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.education_plan
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.lecturer
(
    id_lecturer integer NOT NULL,
    fio_lecturer text COLLATE pg_catalog."default",
    "position" text COLLATE pg_catalog."default",
    date_employment date,
    date_dismissal date,
    passport text COLLATE pg_catalog."default",
    dob date,
    CONSTRAINT lecturer_pkey PRIMARY KEY (id_lecturer)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.lecturer
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.speciality
(
    id_specialty integer NOT NULL,
    faculty text COLLATE pg_catalog."default",
    name_speciality text COLLATE pg_catalog."default",
    hours integer,
    CONSTRAINT speciality_pkey PRIMARY KEY (id_specialty)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.speciality
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.student
(
    id_student integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    fio_student text COLLATE pg_catalog."default",
    dob date,
    passport text COLLATE pg_catalog."default",
    student_pass text COLLATE pg_catalog."default",
    id_specialty integer,
    faculty text COLLATE pg_catalog."default",
    id_group integer,
    enrollment_date date,
    date_deduction date,
    scientific_director text COLLATE pg_catalog."default",
    CONSTRAINT student_pkey PRIMARY KEY (id_student)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.student
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.study_group
(
    id_specialty integer,
    id_group integer NOT NULL,
    name_group text COLLATE pg_catalog."default",
    "аcademic_year" integer,
    CONSTRAINT study_group_pkey PRIMARY KEY (id_group)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.study_group
    OWNER to postgres;
