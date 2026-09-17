-- %%
CREATE TABLE
    DataTypes (
        num INT,
        deci DECIMAL(5, 2),
        point_number FLOAT,
        name VARCHAR(5),
        lastName CHAR(5),
        bigText TEXT,
        TodaysDate date,
        CurrentTime TIME,
        combined DATETIME
    )

-- %%
INSERT INTO
    DataTypes (
        num,
        deci,
        point_number,
        name,
        lastName,
        bigText,
        TodaysDate,
        CurrentTime,
        combined
    )
VALUES
    (
        10,
        995.59,
        5.5,
        "Ahmed",
        "Nazar",
        "I live in France for my studies",
        '2026-09-17',
        '09:37:20',
        '2026-09-17 09:37:20'
    )

-- %%
INSERT INTO
    DataTypes (deci)
    VALUES (4445335.444)

-- %%
SELECT * FROM DataTypes

-- %%
CREATE TABLE UserProfiles (
    user_id INT,
    is_active BOOLEAN,
    profile_picture BLOB
);

INSERT INTO UserProfiles (
    user_id,
    is_active,
    profile_picture
)
VALUES (
    1,
    TRUE, 
    x'89504E470D0A1A0A' 
);


-- %%
drop TABLE  EMPLOYEES;

-- %%
CREATE TABLE EMPLOYEES(
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    Salary DECIMAL(10, 2),
    department VARCHAR(20)
);


-- %%
INSERT INTO
    EMPLOYEES (firstName, lastName, Salary, department)
VALUES
    ('John', 'Doe', 50000.00, 'ASSISTANT'),
    ('Jane', 'Smith', 60000.00, 'MANAGER'),
    ('Michael', 'Johnson', 55000.00, 'DEVELOPER'),
    ('Emily', 'Davis', 70000.00, 'DESIGNER'),
    ('William', 'Brown', 65000.00, 'MARKETING'),
    ('Olivia', 'Wilson', 72000.00, 'SALES'),
    ('James', 'Taylor', 58000.00, 'SUPPORT'),
    ('Sophia', 'Anderson', 75000.00, 'HR'),
    ('Benjamin', 'Thomas', 62000.00, 'ADMIN');

-- %%
select * from EMPLOYEES;

-- %%
select firstName, lastName, salary*1.1 as increasedSalary from EMPLOYEES;

-- %%
select 
    firstName,
    lastName,
    Salary AS increasedSalary
from EMPLOYEES 
where Salary > 60000;

-- %%
select firstName, lastName, Salary, department from EMPLOYEES where department IN ('MANAGER', 'DEVELOPER', 'DESIGNER');

-- %%
select firstName, lastName, Salary, department from Employees order by department ASC, salary DESC;

-- %%


-- %%


-- %%
