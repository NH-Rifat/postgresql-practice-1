create table students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50),
    age int,
    email VARCHAR(50),
    frontend_mark int,
    backend_mark int,
    status VARCHAR(50)
);
create table courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50),
    credits int
);

create table enrollment(
    enrollment_id SERIAL PRIMARY KEY,
    student_id int REFERENCES students(student_id),
    course_id int REFERENCES courses(course_id)
);

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) VALUES
    ( 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
    ( 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
    ( 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
    ('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
    ( 'Sophia', 22, 'sophia@example.com', 50, 52, NULL),
    ( 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

INSERT INTO courses (course_name, credits) VALUES
( 'Next.js', 3),
( 'React.js', 4),
( 'Databases', 3),
( 'Prisma', 3);

INSERT INTO enrollment ( student_id, course_id)
 VALUES
 ( 1, 1),
 ( 1, 2),
( 2, 1),
( 3, 2);

select * from students;
select * from courses;
select * from enrollment;

-- Query 1: Insert a new student record with the following details:

insert into students(student_name, age, email, frontend_mark, backend_mark, status)
values ('Hasan Rifat', 21, 'hasan@example.com', 60,60, 'DONE');


-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
select student_name from students s inner join enrollment using(student_id) inner join courses using(course_id) where course_name='Next.js';

-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
update students set status='Awarded' where (frontend_mark+backend_mark)=(select frontend_mark+backend_mark as total from students order by total desc limit 1);

-- Query 4: Delete all courses that have no students enrolled.
delete from courses where course_id not in (select DISTINCT(course_id) from enrollment inner join courses using(course_id));

-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
select student_name from students limit 2 OFFSET 2;

-- Query 6: Retrieve the course names and the number of students enrolled in each course.
select course_name, count(*) from enrollment inner join courses USING(course_id) group by course_name;

-- Query 7: Calculate and display the average age of all students.
select round(avg(age),2) as average_age from students;

-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.
select student_name from students where email like '%example.com';
