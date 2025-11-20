DROP TABLE IF EXISTS allocation CASCADE;
DROP TABLE IF EXISTS planned_activity CASCADE;
DROP TABLE IF EXISTS course_instance CASCADE;
DROP TABLE IF EXISTS course_layout CASCADE;
DROP TABLE IF EXISTS salary_history CASCADE;
DROP TABLE IF EXISTS skill CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS job_title CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS teaching_activity CASCADE;
DROP TABLE IF EXISTS system_setting CASCADE;

CREATE TABLE system_setting (
    name  VARCHAR(100) PRIMARY KEY,
    value NUMERIC(10,2) NOT NULL
);

CREATE TABLE department (
    id              INT PRIMARY KEY,
    department_name VARCHAR(200) UNIQUE NOT NULL,
    manager_emp     INT
);

CREATE TABLE person (
    personal_number INT          PRIMARY KEY,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    phone_number    VARCHAR(20),
    adress          VARCHAR(200),
    email           VARCHAR(254) NOT NULL
);

CREATE TABLE job_title (
    job_title_id INT          PRIMARY KEY,
    name         VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE employee (
    emp_id             INT PRIMARY KEY,
    supervisor_manager INT,
    department_id      INT NOT NULL,
    job_title_id       INT NOT NULL,
    personal_number    INT NOT NULL UNIQUE,
    FOREIGN KEY (department_id) REFERENCES department(id),
    FOREIGN KEY (job_title_id) REFERENCES job_title(job_title_id),
    FOREIGN KEY (personal_number) REFERENCES person(personal_number),
    FOREIGN KEY (supervisor_manager) REFERENCES employee(emp_id)
);

CREATE TABLE skill (
    skill_id INT PRIMARY KEY,
    emp_id   INT NOT NULL,
    name     VARCHAR(100) NOT NULL,
    level    SMALLINT NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id),
    UNIQUE (emp_id, name)
);

CREATE TABLE salary_history (
    emp_id      INT NOT NULL,
    valid_from  DATE NOT NULL,
    valid_to    DATE,
    hourly_rate NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (emp_id, valid_from),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

CREATE TABLE teaching_activity (
    teaching_activity_id INT PRIMARY KEY,
    activity_name        VARCHAR(100) UNIQUE NOT NULL,
    factor               NUMERIC(6,2)
);

CREATE TABLE course_layout (
    layout_id     INT PRIMARY KEY,
    course_code   VARCHAR(32)  NOT NULL,
    course_name   VARCHAR(200) NOT NULL,
    min_students  INT NOT NULL,
    max_students  INT NOT NULL,
    hp            NUMERIC(4,1) NOT NULL,
    valid_from    DATE NOT NULL,
    valid_to      DATE,
    version_label VARCHAR(64)
);

CREATE TABLE course_instance (
    instance_id  INT PRIMARY KEY,
    num_students INT NOT NULL,
    study_period CHAR(2) NOT NULL,
    study_year   INT NOT NULL,
    layout_id    INT NOT NULL,
    FOREIGN KEY (layout_id) REFERENCES course_layout(layout_id)
);

CREATE TABLE planned_activity (
    instance_id          INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    planned_hours        NUMERIC(10) NOT NULL,
    PRIMARY KEY (instance_id, teaching_activity_id),
    FOREIGN KEY (instance_id) REFERENCES course_instance(instance_id),
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(teaching_activity_id)
);

CREATE TABLE allocation (
    allocation_id        INT PRIMARY KEY,
    instance_id          INT NOT NULL,
    emp_id               INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    allocated_hours      NUMERIC(10) NOT NULL,
    FOREIGN KEY (instance_id) REFERENCES course_instance(instance_id),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id),
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(teaching_activity_id),
    UNIQUE (emp_id, instance_id, teaching_activity_id)
);

ALTER TABLE department
ADD CONSTRAINT fk_department_manager_emp
FOREIGN KEY (manager_emp) REFERENCES employee(emp_id);
