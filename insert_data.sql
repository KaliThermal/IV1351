INSERT INTO system_setting (name, value) VALUES
  ('MAX_INSTANCES_PER_TEACHER_AND_PERIOD', 4);


INSERT INTO department (id, department_name, manager_emp) VALUES
  (1, 'Computer Science', NULL),
  (2, 'Mathematics', NULL);


INSERT INTO job_title (job_title_id, name) VALUES
  (1, 'Professor'),
  (2, 'Lecturer'),
  (3, 'Teaching Assistant'),
  (4, 'PhD Student');


INSERT INTO person (personal_number, first_name, last_name, phone_number, adress, email) VALUES
  (1001, 'Aria', 'Rahmazadi', '0701234567', 'Järfällavägen 3', 'aria@uni.se'),
  (1002, 'Björn', 'Berg', '0707654321', 'Kungsgatan 5', 'bjorn@uni.se'),
  (1003, 'Carla', 'Carlsson', '0709999999', 'Drottningg. 3', 'carla@uni.se'),
  (1004, 'David', 'Dahl', '0701111111', 'Lindhagensgatan 10', 'david@uni.se'),
  (1005, 'Eva', 'Ek', '0702222222', 'Odengatan 7', 'eva@uni.se'),
  (1006, 'Filip', 'Franzén', '0703333333', 'Vasagatan 15', 'filip@uni.se');


INSERT INTO employee (emp_id, supervisor_manager, department_id, job_title_id, personal_number) VALUES
  (1, NULL, 1, 1, 1001),  /* Professor Aria */
  (2, 1,    1, 2, 1002),  /* Lecturer Björn */
  (3, 1,    2, 2, 1003),  /* Lecturer Carla */
  (4, 1,    1, 2, 1004),  /* Lecturer David */
  (5, 1,    1, 3, 1005),  /* TA Eva */
  (6, 1,    1, 4, 1006);  /* PhD Filip */


UPDATE department SET manager_emp = 1 WHERE id = 1;


INSERT INTO skill (skill_id, emp_id, name, level) VALUES
  (1, 1, 'Databases', 5),
  (2, 2, 'Databases', 4),
  (3, 2, 'Programming', 3),
  (4, 3, 'Mathematics', 5),
  (5, 4, 'Databases', 4),
  (6, 4, 'Programming', 4),
  (7, 5, 'Teaching', 3),
  (8, 6, 'Databases', 3);


INSERT INTO salary_history (emp_id, valid_from, valid_to, hourly_rate) VALUES
  (1, '2024-01-01', '2024-12-31', 800),
  (1, '2025-01-01', NULL,          850),
  (2, '2024-01-01', NULL,          600),
  (3, '2024-01-01', NULL,          580),
  (4, '2024-01-01', NULL,          620),
  (5, '2024-01-01', NULL,          400),
  (6, '2024-01-01', NULL,          450);


INSERT INTO teaching_activity (teaching_activity_id, activity_name, factor) VALUES
  (1, 'Lecture',  3.6),
  (2, 'Lab',      2.4),
  (3, 'Tutorial', 2.4),
  (4, 'Seminar',  1.8),
  (5, 'Other',    NULL),
  (6, 'Admin',    1.5),
  (7, 'Exam',     2.0);


INSERT INTO course_layout
  (layout_id, course_code, course_name, min_students, max_students, hp, valid_from,   valid_to,   version_label)
VALUES
  (1, 'IV1351', 'Data Storage Paradigms',       50, 250, 7.5, '2025-01-01', '2025-07-31', 'v1'),
  (2, 'IV1351', 'Data Storage Paradigms',       50, 250, 15.0,'2025-08-01', NULL,         'v2'),
  (3, 'IX1500', 'Discrete Mathematics',         50, 150, 7.5, '2025-01-01', NULL,         'v1'),
  (4, 'EP2500', 'Network Security',             50, 200, 7.5, '2024-01-01', NULL,         'v1'),
  (5, 'IV1350', 'Introduction to Databases',    50, 250, 7.5, '2024-01-01', NULL,         'v1');


INSERT INTO course_instance (instance_id, num_students, study_period, study_year, layout_id) VALUES
  (101, 200, 'P1', 2025, 1),
  (102, 220, 'P2', 2025, 2),
  (201, 150, 'P1', 2025, 3),
  (202, 180, 'P2', 2025, 3),
  (301, 160, 'P2', 2025, 4),
  (302, 140, 'P2', 2024, 4),
  (401, 130, 'P3', 2025, 5),
  (402, 120, 'P1', 2024, 5);


INSERT INTO planned_activity (instance_id, teaching_activity_id, planned_hours) VALUES
  /* IV1351, instance 101 (P1 2025) */
  (101, 1, 20),   /* Lecture */
  (101, 2, 40),   /* Lab */
  (101, 4, 80),   /* Seminar */
  (101, 5, 10),   /* Other */
  (101, 6, 15),   /* Admin */
  (101, 7, 8),    /* Exam */

  /* IV1351, instance 102 (P2 2025) */
  (102, 1, 24),   /* Lecture */
  (102, 2, 60),   /* Lab */
  (102, 4, 40),   /* Seminar */
  (102, 5, 8),    /* Other */
  (102, 6, 10),   /* Admin */

  /* IX1500, instance 201 (P1 2025) */
  (201, 1, 44),   /* Lecture */
  (201, 2, 20),   /* Lab */
  (201, 4, 64),   /* Seminar */
  (201, 5, 5),    /* Other */
  (201, 7, 6),    /* Exam */

  /* IX1500, instance 202 (P2 2025) */
  (202, 1, 30),   /* Lecture */
  (202, 3, 20),   /* Tutorial */
  (202, 4, 40),   /* Seminar */
  (202, 6, 12),   /* Admin */
  (202, 7, 6),    /* Exam */

  /* EP2500, instance 301 (P2 2025) */
  (301, 1, 16),   /* Lecture */
  (301, 2, 20),   /* Lab */
  (301, 5, 10),   /* Other */
  (301, 7, 5),    /* Exam */

  /* EP2500, instance 302 (P2 2024) */
  (302, 1, 12),   /* Lecture */
  (302, 3, 18),   /* Tutorial */
  (302, 4, 20),   /* Seminar */

  /* IV1350, instance 401 (P3 2025) */
  (401, 1, 18),   /* Lecture */
  (401, 3, 20),   /* Tutorial */
  (401, 4, 10),   /* Seminar */
  (401, 6, 8),    /* Admin */
  (401, 7, 4),    /* Exam */

  /* IV1350, instance 402 (P1 2024) */
  (402, 1, 10),   /* Lecture */
  (402, 4, 8),    /* Seminar */
  (402, 5, 6);    /* Other */


INSERT INTO allocation (allocation_id, instance_id, emp_id, teaching_activity_id, allocated_hours) VALUES
  /* IV1351, instance 101 */
  (1, 101, 1, 1, 10),   /* Aria, Lecture */
  (2, 101, 2, 1, 10),   /* Björn, Lecture */
  (3, 101, 2, 2, 40),   /* Björn, Lab */
  (6, 101, 3, 4, 15),   /* Carla, Seminar */
  (7, 101, 3, 5, 5),    /* Carla, Other */
  (8, 101, 4, 6, 8),    /* David, Admin */
  (9, 101, 5, 7, 4),    /* Eva, Exam */

  /* IV1351, instance 102 */
  (10, 102, 1, 1, 12),  /* Aria, Lecture */
  (11, 102, 2, 2, 30),  /* Björn, Lab */
  (12, 102, 4, 4, 20),  /* David, Seminar */
  (13, 102, 5, 6, 6),   /* Eva, Admin */

  /* IX1500, instance 201 */
  (4, 201, 3, 1, 30),   /* Carla, Lecture */
  (5, 201, 2, 4, 20),   /* Björn, Seminar */
  (14, 201, 1, 1, 10),  /* Aria, Lecture (extra) */
  (15, 201, 4, 2, 15),  /* David, Lab */
  (16, 201, 5, 7, 5),   /* Eva, Exam */

  /* IX1500, instance 202 */
  (17, 202, 2, 1, 20),  /* Björn, Lecture */
  (18, 202, 5, 3, 25),  /* Eva, Tutorial */
  (19, 202, 5, 4, 10),  /* Eva, Seminar */

  /* EP2500, instance 301 (P2 2025) */
  (20, 301, 3, 1, 16),  /* Carla, Lecture */
  (21, 301, 6, 2, 20),  /* Filip, Lab */
  (22, 301, 6, 6, 10),  /* Filip, Admin */

  /* EP2500, instance 302 (P2 2024) */
  (23, 302, 2, 1, 10),  /* Björn, Lecture */
  (24, 302, 3, 4, 12),  /* Carla, Seminar */

  /* IV1350, instance 401 (P3 2025) */
  (25, 401, 4, 1, 18),  /* David, Lecture */
  (26, 401, 5, 3, 20),  /* Eva, Tutorial */
  (27, 401, 5, 7, 5),   /* Eva, Exam */

  /* IV1350, instance 402 (P1 2024) */
  (28, 402, 1, 1, 8),   /* Aria, Lecture */
  (29, 402, 4, 3, 9);   /* David, Tutorial */
