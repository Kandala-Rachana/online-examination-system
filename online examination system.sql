
CREATE DATABASE IF NOT EXISTS CollegeExam;
USE CollegeExam;

-- 1. Create Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    department VARCHAR(30),
    year_of_study INT
);
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50),
    max_marks INT DEFAULT 100
);
CREATE TABLE Exams (
    exam_id INT PRIMARY KEY,
    exam_name VARCHAR(50),
    exam_date DATE
);
CREATE TABLE Marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    exam_id INT,
    marks_obtained INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    FOREIGN KEY (exam_id) REFERENCES Exams(exam_id)
);
INSERT INTO Students VALUES
(101, 'Ravi', 'CSE', 3),
(102, 'Priya', 'CSE', 3),
(103, 'Kiran', 'ECE', 3);
INSERT INTO Subjects VALUES
(1, 'Python', 100),
(2, 'DBMS', 100),
(3, 'Java', 100);
INSERT INTO Exams VALUES
(1, 'Mid Examination', '2026-10-20'),
(2, 'Semester Examination', '2026-11-15');
INSERT INTO Marks (student_id, subject_id, exam_id, marks_obtained)
VALUES
(101, 1, 1, 85),
(101, 2, 1, 78),
(101, 3, 1, 90),
(102, 1, 1, 92),
(102, 2, 1, 88),
(102, 3, 1, 81),
(103, 1, 1, 65),
(103, 2, 1, 72),
(103, 3, 1, 69);
SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    e.exam_name,
    m.marks_obtained
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Subjects sub ON m.subject_id = sub.subject_id
JOIN Exams e ON m.exam_id = e.exam_id;
SELECT
    s.student_id,
    s.student_name,
    e.exam_name,
    SUM(m.marks_obtained) AS total_marks,
    SUM(sub.max_marks) AS maximum_marks,
    ROUND(
        SUM(m.marks_obtained) * 100.0 / SUM(sub.max_marks), 2
    ) AS percentage
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Subjects sub ON m.subject_id = sub.subject_id
JOIN Exams e ON m.exam_id = e.exam_id
GROUP BY s.student_id, s.student_name, e.exam_id, e.exam_name;
SELECT
    s.student_name,
    sub.subject_name,
    m.marks_obtained,
    CASE
        WHEN m.marks_obtained >= 35 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Subjects sub ON m.subject_id = sub.subject_id;
SELECT
    s.student_name,
    e.exam_name,
    SUM(m.marks_obtained) AS total_marks
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Exams e ON m.exam_id = e.exam_id
GROUP BY s.student_id, s.student_name, e.exam_id, e.exam_name
ORDER BY e.exam_id, total_marks DESC;
UPDATE Marks
SET marks_obtained = 95
WHERE student_id = 101
  AND subject_id = 1
  AND exam_id = 1;
  DELETE FROM Marks
WHERE mark_id = 1;