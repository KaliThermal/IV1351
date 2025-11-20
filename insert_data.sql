INSERT INTO system_setting (name, value) VALUES
  ('MAX_INSTANCES_PER_TEACHER_AND_PERIOD', 4);

INSERT INTO department (id, department_name, manager_emp) VALUES
  (1, 'Computer Science', NULL),
  (2, 'Mathematics', NULL);

INSERT INTO job_title (job_title_id, name) VALUES
  (1, 'Professor'),
  (2, 'Lecturer');

INSERT INTO person (personal_number, first_name, last_name, phone_number, adress, email) VALUES
  (1001, 'Anna', 'Andersson', '0701234567', 'Sveavägen 1', 'anna@uni.se'),
  (1002, 'Björn', 'Berg', '0707654321', 'Kungsgatan 5', 'bjorn@uni.se'),
  (1003, 'Carla', 'Carlsson', '0709999999', 'Drottningg. 3', 'carla@uni.se');

INSERT INTO employee (emp_id, supervisor_manager, department_id, job_title_id, personal_number) VALUES
  (1, NULL, 1, 1, 1001),
  (2, 1, 1, 2, 1002),
  (3, 1, 2, 2, 1003);

UPDATE department SET manager_emp = 1 WHERE id = 1;

INSERT INTO skill (skill_id, emp_id, name, level) VALUES
  (1, 1, 'Databases', 5),
  (2, 2, 'Databases', 4),
  (3, 2, 'Programming', 3),
  (4, 3, 'Mathematics', 5);

INSERT INTO salary_history (emp_id, valid_from, valid_to, hourly_rate) VALUES
  (1, '2024-01-01', '2024-12-31', 800),
  (1, '2025-01-01', NULL, 850),
  (2, '2024-01-01', NULL, 600),
  (3, '2024-01-01', NULL, 580);

INSERT INTO teaching_activity (teaching_activity_id, activity_name, factor) VALUES
  (1, 'Lecture', 3.6),
  (2, 'Lab', 2.4),
  (3, 'Tutorial', 2.4),
  (4, 'Seminar', 1.8),
  (5, 'Other', NULL);

INSERT INTO course_layout
  (layout_id, course_code, course_name, min_students, max_students, hp, valid_from, valid_to, version_label)
VALUES
  (1, 'IV1351', 'Data Storage Paradigms', 50, 250, 7.5, '2025-01-01', '2025-07-31', 'v1'),
  (2, 'IV1351', 'Data Storage Paradigms', 50, 250, 15.0, '2025-08-01', NULL, 'v2'),
  (3, 'IX1500', 'Discrete Mathematics', 50, 150, 7.5, '2025-01-01', NULL, 'v1');

INSERT INTO course_instance (instance_id, num_students, study_period, study_year, layout_id) VALUES
  (101, 200, 'P1', 2025, 1),
  (102, 220, 'P2', 2025, 2),
  (201, 150, 'P1', 2025, 3);

INSERT INTO planned_activity (instance_id, teaching_activity_id, planned_hours) VALUES
  (101, 1, 20),
  (101, 2, 40),
  (101, 4, 80),
  (102, 1, 24),
  (102, 2, 60),
  (201, 1, 44),
  (201, 4, 64);

INSERT INTO allocation (allocation_id, instance_id, emp_id, teaching_activity_id, allocated_hours) VALUES
  (1, 101, 1, 1, 10),
  (2, 101, 2, 1, 10),
  (3, 101, 2, 2, 40),
  (4, 201, 3, 1, 30),
  (5, 201, 2, 4, 20);
