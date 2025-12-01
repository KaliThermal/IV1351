Q1: Planned hours per course instance for current year



SELECT
    cl.course_code,
    ci.instance_id                AS course_instance_id,
    cl.hp,
    ci.study_period               AS period,
    ci.num_students               AS num_students,

    SUM(CASE WHEN ta.activity_name = 'Lecture'
             THEN pa.planned_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN ta.activity_name = 'Tutorial'
             THEN pa.planned_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS tutorial_hours,
    SUM(CASE WHEN ta.activity_name = 'Lab'
             THEN pa.planned_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN ta.activity_name = 'Seminar'
             THEN pa.planned_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS seminar_hours,
    SUM(CASE WHEN ta.activity_name = 'Other'
             THEN pa.planned_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS other_overhead_hours,
    SUM(CASE WHEN ta.activity_name = 'Admin'
             THEN pa.planned_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS admin_hours,
    SUM(CASE WHEN ta.activity_name = 'Exam'
             THEN pa.planned_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS exam_hours,

    SUM(pa.planned_hours * COALESCE(ta.factor, 1)) AS total_hours
FROM course_instance ci
JOIN course_layout cl
  ON cl.layout_id = ci.layout_id
LEFT JOIN planned_activity pa
  ON pa.instance_id = ci.instance_id
LEFT JOIN teaching_activity ta
  ON ta.teaching_activity_id = pa.teaching_activity_id
WHERE ci.study_year = EXTRACT(YEAR FROM CURRENT_DATE)  
GROUP BY
    cl.course_code,
    ci.instance_id,
    cl.hp,
    ci.study_period,
    ci.num_students
ORDER BY
    cl.course_code,
    ci.instance_id;




\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Q2: Allocated hours per teacher per course instance (current year)



SELECT
    cl.course_code,
    ci.instance_id                         AS course_instance_id,
    cl.hp,
    (p.first_name || ' ' || p.last_name)   AS teacher_name,
    jt.name                                AS designation,

    SUM(CASE WHEN ta.activity_name = 'Lecture'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN ta.activity_name = 'Tutorial'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS tutorial_hours,
    SUM(CASE WHEN ta.activity_name = 'Lab'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN ta.activity_name = 'Seminar'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS seminar_hours,
    SUM(CASE WHEN ta.activity_name = 'Other'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS other_overhead_hours,
    SUM(CASE WHEN ta.activity_name = 'Admin'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS admin_hours,
    SUM(CASE WHEN ta.activity_name = 'Exam'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS exam_hours,

    SUM(a.allocated_hours * COALESCE(ta.factor, 1)) AS total_hours
FROM allocation a
JOIN course_instance ci
  ON ci.instance_id = a.instance_id
JOIN course_layout cl
  ON cl.layout_id = ci.layout_id
JOIN teaching_activity ta
  ON ta.teaching_activity_id = a.teaching_activity_id
JOIN employee e
  ON e.emp_id = a.emp_id
JOIN person p
  ON p.personal_number = e.personal_number
JOIN job_title jt
  ON jt.job_title_id = e.job_title_id
WHERE ci.study_year = EXTRACT(YEAR FROM CURRENT_DATE)   

GROUP BY
    cl.course_code,
    ci.instance_id,
    cl.hp,
    teacher_name,
    jt.name
ORDER BY
    cl.course_code,
    ci.instance_id,
    teacher_name;


\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Q3: Teacher load per period (current year, per teacher)


SELECT
    cl.course_code,
    ci.instance_id                         AS course_instance_id,
    cl.hp,
    ci.study_period                        AS period,
    (p.first_name || ' ' || p.last_name)   AS teacher_name,

    SUM(CASE WHEN ta.activity_name = 'Lecture'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN ta.activity_name = 'Tutorial'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS tutorial_hours,
    SUM(CASE WHEN ta.activity_name = 'Lab'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN ta.activity_name = 'Seminar'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS seminar_hours,
    SUM(CASE WHEN ta.activity_name = 'Other'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS other_overhead_hours,
    SUM(CASE WHEN ta.activity_name = 'Admin'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS admin_hours,
    SUM(CASE WHEN ta.activity_name = 'Exam'
             THEN a.allocated_hours * COALESCE(ta.factor, 1) ELSE 0 END) AS exam_hours,

    SUM(a.allocated_hours * COALESCE(ta.factor, 1)) AS total_hours
FROM allocation a
JOIN course_instance ci
  ON ci.instance_id = a.instance_id
JOIN course_layout cl
  ON cl.layout_id = ci.layout_id
JOIN teaching_activity ta
  ON ta.teaching_activity_id = a.teaching_activity_id
JOIN employee e
  ON e.emp_id = a.emp_id
JOIN person p
  ON p.personal_number = e.personal_number
WHERE ci.study_year = EXTRACT(YEAR FROM CURRENT_DATE)   

GROUP BY
    cl.course_code,
    ci.instance_id,
    cl.hp,
    ci.study_period,
    teacher_name
ORDER BY
    teacher_name,
    ci.study_period,
    cl.course_code,
    ci.instance_id;


\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Q4: Teachers allocated to more than :N course instances in a given period (current year)



SELECT
    e.emp_id                               AS employment_id,
    (p.first_name || ' ' || p.last_name)   AS teacher_name,
    ci.study_period                        AS period,
    COUNT(DISTINCT ci.instance_id)         AS num_courses
FROM allocation a
JOIN employee e
  ON e.emp_id = a.emp_id
JOIN person p
  ON p.personal_number = e.personal_number
JOIN course_instance ci
  ON ci.instance_id = a.instance_id
WHERE ci.study_year = EXTRACT(YEAR FROM CURRENT_DATE)     
  AND ci.study_period = 'P1'                              
GROUP BY
    e.emp_id,
    teacher_name,
    ci.study_period
HAVING COUNT(DISTINCT ci.instance_id) > 1                 
ORDER BY
    num_courses DESC,
    teacher_name;


\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

