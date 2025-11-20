--
-- PostgreSQL database dump
--

\restrict 9RyMkplY4Lbb5kzeaCVNJdbUu6fjm0rYEqCPHMhe18tta5irSf8sf6foZM22iFE

-- Dumped from database version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: allocation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.allocation (
    allocation_id integer NOT NULL,
    instance_id integer NOT NULL,
    emp_id integer NOT NULL,
    teaching_activity_id integer NOT NULL,
    allocated_hours numeric(10,0) NOT NULL
);


ALTER TABLE public.allocation OWNER TO postgres;

--
-- Name: course_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_instance (
    instance_id integer NOT NULL,
    num_students integer NOT NULL,
    study_period character(2) NOT NULL,
    study_year integer NOT NULL,
    layout_id integer NOT NULL
);


ALTER TABLE public.course_instance OWNER TO postgres;

--
-- Name: course_layout; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_layout (
    layout_id integer NOT NULL,
    course_code character varying(32) NOT NULL,
    course_name character varying(200) NOT NULL,
    min_students integer NOT NULL,
    max_students integer NOT NULL,
    hp numeric(4,1) NOT NULL,
    valid_from date NOT NULL,
    valid_to date,
    version_label character varying(64)
);


ALTER TABLE public.course_layout OWNER TO postgres;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    department_name character varying(200) NOT NULL,
    manager_emp integer
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    emp_id integer NOT NULL,
    supervisor_manager integer,
    department_id integer NOT NULL,
    job_title_id integer NOT NULL,
    personal_number integer NOT NULL
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: job_title; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_title (
    job_title_id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.job_title OWNER TO postgres;

--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    personal_number integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone_number character varying(20),
    adress character varying(200),
    email character varying(254) NOT NULL
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: planned_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planned_activity (
    instance_id integer NOT NULL,
    teaching_activity_id integer NOT NULL,
    planned_hours numeric(10,0) NOT NULL
);


ALTER TABLE public.planned_activity OWNER TO postgres;

--
-- Name: salary_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salary_history (
    emp_id integer NOT NULL,
    valid_from date NOT NULL,
    valid_to date,
    hourly_rate numeric(10,2) NOT NULL
);


ALTER TABLE public.salary_history OWNER TO postgres;

--
-- Name: skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill (
    skill_id integer NOT NULL,
    emp_id integer NOT NULL,
    name character varying(100) NOT NULL,
    level smallint NOT NULL
);


ALTER TABLE public.skill OWNER TO postgres;

--
-- Name: system_setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_setting (
    name character varying(100) NOT NULL,
    value numeric(10,2) NOT NULL
);


ALTER TABLE public.system_setting OWNER TO postgres;

--
-- Name: teaching_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teaching_activity (
    teaching_activity_id integer NOT NULL,
    activity_name character varying(100) NOT NULL,
    factor numeric(6,2)
);


ALTER TABLE public.teaching_activity OWNER TO postgres;

--
-- Data for Name: allocation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.allocation (allocation_id, instance_id, emp_id, teaching_activity_id, allocated_hours) FROM stdin;
1	101	1	1	10
2	101	2	1	10
3	101	2	2	40
4	201	3	1	30
5	201	2	4	20
\.


--
-- Data for Name: course_instance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_instance (instance_id, num_students, study_period, study_year, layout_id) FROM stdin;
101	200	P1	2025	1
102	220	P2	2025	2
201	150	P1	2025	3
\.


--
-- Data for Name: course_layout; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_layout (layout_id, course_code, course_name, min_students, max_students, hp, valid_from, valid_to, version_label) FROM stdin;
1	IV1351	Data Storage Paradigms	50	250	7.5	2025-01-01	2025-07-31	v1
2	IV1351	Data Storage Paradigms	50	250	15.0	2025-08-01	\N	v2
3	IX1500	Discrete Mathematics	50	150	7.5	2025-01-01	\N	v1
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id, department_name, manager_emp) FROM stdin;
2	Mathematics	\N
1	Computer Science	1
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (emp_id, supervisor_manager, department_id, job_title_id, personal_number) FROM stdin;
1	\N	1	1	1001
2	1	1	2	1002
3	1	2	2	1003
\.


--
-- Data for Name: job_title; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_title (job_title_id, name) FROM stdin;
1	Professor
2	Lecturer
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (personal_number, first_name, last_name, phone_number, adress, email) FROM stdin;
1001	Anna	Andersson	0701234567	Sveavägen 1	anna@uni.se
1002	Björn	Berg	0707654321	Kungsgatan 5	bjorn@uni.se
1003	Carla	Carlsson	0709999999	Drottningg. 3	carla@uni.se
\.


--
-- Data for Name: planned_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planned_activity (instance_id, teaching_activity_id, planned_hours) FROM stdin;
101	1	20
101	2	40
101	4	80
102	1	24
102	2	60
201	1	44
201	4	64
\.


--
-- Data for Name: salary_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salary_history (emp_id, valid_from, valid_to, hourly_rate) FROM stdin;
1	2024-01-01	2024-12-31	800.00
1	2025-01-01	\N	850.00
2	2024-01-01	\N	600.00
3	2024-01-01	\N	580.00
\.


--
-- Data for Name: skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skill (skill_id, emp_id, name, level) FROM stdin;
1	1	Databases	5
2	2	Databases	4
3	2	Programming	3
4	3	Mathematics	5
\.


--
-- Data for Name: system_setting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_setting (name, value) FROM stdin;
MAX_INSTANCES_PER_TEACHER_AND_PERIOD	4.00
\.


--
-- Data for Name: teaching_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teaching_activity (teaching_activity_id, activity_name, factor) FROM stdin;
1	Lecture	3.60
2	Lab	2.40
3	Tutorial	2.40
4	Seminar	1.80
5	Other	\N
\.


--
-- Name: allocation allocation_emp_id_instance_id_teaching_activity_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT allocation_emp_id_instance_id_teaching_activity_id_key UNIQUE (emp_id, instance_id, teaching_activity_id);


--
-- Name: allocation allocation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT allocation_pkey PRIMARY KEY (allocation_id);


--
-- Name: course_instance course_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_instance
    ADD CONSTRAINT course_instance_pkey PRIMARY KEY (instance_id);


--
-- Name: course_layout course_layout_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_layout
    ADD CONSTRAINT course_layout_pkey PRIMARY KEY (layout_id);


--
-- Name: department department_department_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_department_name_key UNIQUE (department_name);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: employee employee_personal_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_personal_number_key UNIQUE (personal_number);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (emp_id);


--
-- Name: job_title job_title_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_title
    ADD CONSTRAINT job_title_name_key UNIQUE (name);


--
-- Name: job_title job_title_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_title
    ADD CONSTRAINT job_title_pkey PRIMARY KEY (job_title_id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (personal_number);


--
-- Name: planned_activity planned_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planned_activity
    ADD CONSTRAINT planned_activity_pkey PRIMARY KEY (instance_id, teaching_activity_id);


--
-- Name: salary_history salary_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salary_history
    ADD CONSTRAINT salary_history_pkey PRIMARY KEY (emp_id, valid_from);


--
-- Name: skill skill_emp_id_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill
    ADD CONSTRAINT skill_emp_id_name_key UNIQUE (emp_id, name);


--
-- Name: skill skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (skill_id);


--
-- Name: system_setting system_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_setting
    ADD CONSTRAINT system_setting_pkey PRIMARY KEY (name);


--
-- Name: teaching_activity teaching_activity_activity_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaching_activity
    ADD CONSTRAINT teaching_activity_activity_name_key UNIQUE (activity_name);


--
-- Name: teaching_activity teaching_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaching_activity
    ADD CONSTRAINT teaching_activity_pkey PRIMARY KEY (teaching_activity_id);


--
-- Name: allocation allocation_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT allocation_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES public.employee(emp_id);


--
-- Name: allocation allocation_instance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT allocation_instance_id_fkey FOREIGN KEY (instance_id) REFERENCES public.course_instance(instance_id);


--
-- Name: allocation allocation_teaching_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT allocation_teaching_activity_id_fkey FOREIGN KEY (teaching_activity_id) REFERENCES public.teaching_activity(teaching_activity_id);


--
-- Name: course_instance course_instance_layout_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_instance
    ADD CONSTRAINT course_instance_layout_id_fkey FOREIGN KEY (layout_id) REFERENCES public.course_layout(layout_id);


--
-- Name: employee employee_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: employee employee_job_title_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_job_title_id_fkey FOREIGN KEY (job_title_id) REFERENCES public.job_title(job_title_id);


--
-- Name: employee employee_personal_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_personal_number_fkey FOREIGN KEY (personal_number) REFERENCES public.person(personal_number);


--
-- Name: employee employee_supervisor_manager_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_supervisor_manager_fkey FOREIGN KEY (supervisor_manager) REFERENCES public.employee(emp_id);


--
-- Name: department fk_department_manager_emp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT fk_department_manager_emp FOREIGN KEY (manager_emp) REFERENCES public.employee(emp_id);


--
-- Name: planned_activity planned_activity_instance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planned_activity
    ADD CONSTRAINT planned_activity_instance_id_fkey FOREIGN KEY (instance_id) REFERENCES public.course_instance(instance_id);


--
-- Name: planned_activity planned_activity_teaching_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planned_activity
    ADD CONSTRAINT planned_activity_teaching_activity_id_fkey FOREIGN KEY (teaching_activity_id) REFERENCES public.teaching_activity(teaching_activity_id);


--
-- Name: salary_history salary_history_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salary_history
    ADD CONSTRAINT salary_history_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES public.employee(emp_id);


--
-- Name: skill skill_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill
    ADD CONSTRAINT skill_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES public.employee(emp_id);


--
-- PostgreSQL database dump complete
--

\unrestrict 9RyMkplY4Lbb5kzeaCVNJdbUu6fjm0rYEqCPHMhe18tta5irSf8sf6foZM22iFE

