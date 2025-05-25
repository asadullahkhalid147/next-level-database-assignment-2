1.What is PostgreSQL?
PostgreSQL হল একটি অতি শক্তিশালীopen-source relational database management system (RDBMS).PostgreSQL বিনামূল্যে ব্যবহার ,মডিফাই ,বিতরণ করা যায় | সারি ও কলামের সাহায্যে সাহায্যে টেবিল তৈরি করে তথ্য সাজিয়ে রাখা যায়|বিভিন্ন operating system যেমন linux, windows, macOs এ এটি ব্যবহার করা যায়|এটি ব্যবহার করে আমরা  json data এর উপরও query করতে পারি এবং json data কে সংরক্ষণ করতে পারি। PostgreSQL এর  একটি এটির বৃহৎ community  রয়েছে যা PostgreSQL কে সংরক্ষণ ও enhance এ সাহায্য করে|

3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

Primary key হল সেই  কলাম যা একটি টেবিলের প্রতিটি সারি কে uniquely identify করে| Primary key প্রতিটি সারিতে unique হয় ,  Primary key কখনো NULL value হতে পারে না এবং একটা টেবিলে একটা কলামই  Primary Key হিসেবে ব্যবহৃত হয়|

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER
);
এখানে student_id হলো Primary Key.

একটি table এর Foreign Key হল সেই কলাম যেটি অন্য একটি টেবিলের Primary Key হিসেবে ব্যবহৃত হয় |মূলত দুটি টেবিলের মধ্যে সম্পর্ক স্থাপনের জন্যই Foreign Key use করা হয়|

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course TEXT NOT NULL
);
enrollments table এর Foreign Key হল student_id যেটা আবার students table এর Primary Key.
4. What is the difference between the VARCHAR and CHAR data types?

VARCHAR(n) : সর্বোচ্চ n টা character নিতে পারবে | n টা character এর কম দিলেও নিবে তবে যতগুলো character কম দেওয়া আছে সেখানে কোন extra space ব্যবহার করবে না|
name VARCHAR(20) :: name এর  ভিতরে 1 থেকে 20 টা character নিতে পারবে| 

CHAR(n) : সর্বোচ্চ n টা character নিতে পারবে | n টা character এর কম দিলেও নিবে তবে যতগুলো character কম দেওয়া আছে সেখানে কোন extra space ব্যবহার করবে |
code VARCHAR(50) :: code এর  ভিতরে 1 থেকে 50 টা character নিতে পারবে| 

6. What are the LIMIT and OFFSET clauses used for?

LIMITt: PostgreSQL এ প্রতিটা query তে সারির সংখ্যা নিয়ন্ত্রণে রাখতে LIMIT এবং OFFSET ব্যবহার করা হয় বিশেষত pagination এবং data previewing এর সময়|
SELECT * FROM students
LIMIT 5;

শুধুমাত্র প্রথম পাঁচটার সারি দেখা যাবে|

OFFSET: PostgreSQL এ প্রতিটা query তে সারি skip করতে OFFSET ব্যবহার করা হয়|
SELECT * FROM students
OFFSET 5;

প্রথম পাঁচটা সারি বাদে বাকি সারি গুলো দেখা যাবে|

7. How can you modify data using UPDATE statements?

PostgreSQL এ UPDATE দিয়ে বিদ্যমান সারি গুলোকে modify করা যায়|
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;

Example1:
UPDATE employees
SET salary = 60000
WHERE employee_id = 101;

employee_id 101 হলে salary 60000 এ modify করতে হবে |

Example2:
UPDATE employees
SET salary = 65000,
    department = 'Marketing'
WHERE employee_id = 102;

employee_id 102 হলে salary, 60000 এ এবং department  'Marketing'
 এ modify করতে হবে |


