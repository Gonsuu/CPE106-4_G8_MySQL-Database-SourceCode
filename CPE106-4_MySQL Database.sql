
CREATE TABLE IF NOT EXISTS employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE IF NOT EXISTS branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

UPDATE employee
SET branch_id = NULL
WHERE branch_id NOT IN (SELECT branch_id FROM branch);

DELETE FROM employee
WHERE branch_id NOT IN (SELECT branch_id FROM branch);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE IF NOT EXISTS client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

DROP TABLE IF EXISTS works_with;

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

SHOW CREATE TABLE works_with;

DROP TABLE IF EXISTS branch_supplier;

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

SHOW CREATE TABLE branch_supplier;

UPDATE employee
SET first_name = 'David', last_name = 'Wallace', birth_day = '1967-11-17', 
    sex = 'M', salary = 250000, super_id = NULL, branch_id = NULL
WHERE emp_id = 100;

DELETE FROM branch WHERE branch_id = 1;
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id=1
WHERE emp_id= '100';

DELETE FROM employee WHERE emp_id = 101;
DELETE FROM branch WHERE branch_id = 4;


INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

DELETE FROM employee WHERE emp_id = 102;

INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

DELETE FROM branch WHERE branch_id = 2;

INSERT INTO branch VALUES(2,'Scranton',102,'1992-04-06');

UPDATE employee
SET branch_id=2
WHERE emp_id=102;

DELETE FROM employee WHERE emp_id = 103;
DELETE FROM employee WHERE emp_id = 104;
DELETE FROM employee WHERE emp_id = 105;
DELETE FROM employee WHERE emp_id = 106;
DELETE FROM employee WHERE emp_id = 107;
DELETE FROM employee WHERE emp_id = 108;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

DELETE FROM branch WHERE branch_id = 3;

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id=3
WHERE emp_id=106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

SELECT * FROM client WHERE client_id IN (400, 401, 402, 403, 404, 405, 406);
DELETE FROM client WHERE client_id in (400, 401, 402, 403, 404, 405, 406);

INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

DELETE FROM employee WHERE emp_id IN (109, 110);

SELECT *
FROM employee;

SELECT *
FROM client;

SELECT *
FROM employee
ORDER BY salary ASC;

SELECT * 
FROM employee
ORDER BY salary DESC;

SELECT *
FROM employee
ORDER BY sex,first_name;

SELECT *
from employee
LIMIT 5;

SELECT first_name, employee.last_name
FROM employee;

SELECT first_name AS forename, employee.last_name AS surname
FROM employee;

SELECT DISTINCT sex
FROM employee;

SELECT *
FROM employee
WHERE sex='M';

SELECT *
FROM employee
WHERE branch_id=2;

SELECT emp_id,first_name,last_name
FROM employee
WHERE birth_day >='1970-01-01';

SELECT *
FROM employee
WHERE branch_id = 2 AND sex = 'F';

SELECT *
FROM employee
WHERE (birth_day >= '1970-01-01' AND sex = 'F') OR salary > 80000;

SELECT *
FROM employee
WHERE birth_day BETWEEN '1970-01-01' AND '1975-01-01';

SELECT *
FROM employee
WHERE first_name IN ('Jim', 'Michael', 'Johnny', 'David');

SELECT COUNT(emp_id)
FROM employee;

SELECT COUNT(super_id)
FROM employee;

SELECT AVG(salary)
FROM employee;

SELECT SUM(salary)
FROM employee;

SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

SELECT SUM(total_sales),emp_id
FROM works_with
GROUP BY emp_id;

SELECT SUM(total_sales),client_id
FROM works_with
GROUP BY client_id;

SELECT * 
FROM client 
WHERE client_name 
LIKE '%LLC';

SELECT * 
FROM branch_supplier
WHERE supplier_name
LIKE '% Label%';

SELECT *
FROM  employee
WHERE birth_day
LIKE '____-10%';

SELECT *
FROM client
WHERE client_name LIKE '%Highschool%';

SELECT employee.first_name AS Employee_Branch_Names
FROM employee
UNION
SELECT branch.branch_name
FROM branch;

SELECT client.client_name AS Non_Employee_Entities, client.branch_id AS Branch_ID
FROM client
UNION
SELECT branch_supplier.supplier_name, branch_supplier.branch_id
FROM branch_supplier;

UPDATE branch
SET branch_name = 'Buffalo', mgr_id = NULL, mgr_start_date = NULL
WHERE branch_id = 4;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch    -- LEFT JOIN, RIGHT JOIN
ON employee.emp_id = branch.mgr_id;

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (SELECT works_with.emp_id
                          FROM works_with
                          WHERE works_with.total_sales > 50000);

SELECT client.client_id, client.client_name
FROM client
WHERE client.branch_id = (SELECT branch.branch_id
                          FROM branch
                          WHERE branch.mgr_id = 102);

 SELECT client.client_id, client.client_name
 FROM client
 WHERE client.branch_id = (SELECT branch.branch_id
                           FROM branch
                           WHERE branch.mgr_id = (SELECT employee.emp_id
                                                  FROM employee
                                                  WHERE employee.first_name = 'Michael' AND employee.last_name ='Scott'
                                                  LIMIT 1));

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
                         SELECT works_with.emp_id
                         FROM works_with
                         )
AND employee.branch_id = 2;

SELECT client.client_name
FROM client
WHERE client.client_id IN (
                          SELECT client_id
                          FROM (
                                SELECT SUM(works_with.total_sales) AS totals, client_id
                                FROM works_with
                                GROUP BY client_id) AS total_client_sales
                          WHERE totals > 100000
);

CREATE TABLE IF NOT EXISTS trigger_test (
     message VARCHAR(100)
);

DROP TRIGGER IF EXISTS my_trigger;

CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('added new employee');
    END;

DROP TRIGGER IF EXISTS my_trigger;

CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(NEW.first_name);
    END;

DROP TRIGGER IF EXISTS my_trigger;

CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
         IF NEW.sex = 'M' THEN
               INSERT INTO trigger_test VALUES('added male employee');
         ELSEIF NEW.sex = 'F' THEN
               INSERT INTO trigger_test VALUES('added female');
         ELSE
               INSERT INTO trigger_test VALUES('added other employee');
         END IF;
    END;

SELECT * FROM information_schema.triggers WHERE trigger_name = 'my_trigger';

DROP TRIGGER my_trigger;