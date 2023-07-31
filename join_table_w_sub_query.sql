--GitHub
--https://github.com/softwareNuggets
-- /PostgreSQL_shorts_resources
-- /join_table_w_sub_query.sql

--drop table Patients
--drop table MedicalProcedures

CREATE TEMPORARY TABLE Patients (
    id			INT PRIMARY KEY,
    patient_id	INT,
	first_name	varchar(30),
	last_name	varchar(30)
);

CREATE TEMPORARY TABLE MedicalProcedures (
    patient_id				INT,
    dateof_procedure		DATE,
    med_procedure_name		VARCHAR(50),
    PRIMARY KEY (patient_id, dateof_procedure)
);


INSERT INTO Patients (id, patient_id, first_name, last_name) 
VALUES
(1, 1001, 'Ricky',		'Thomas'),
(2, 1002, 'Chloé',		'Monet'),
(3, 1003, 'César',		'Torres'),
(4, 1004, 'Fred',		'Sanford'),
(5, 1005, 'Nicole',		'Johnson');


INSERT INTO MedicalProcedures 	(patient_id, dateof_procedure, 	med_procedure_name) 
VALUES
(1001, '2023-07-25', 'Procedure A'),
(1001, '2023-09-12', 'Procedure B1'),
(1001, '2023-10-12', 'Procedure B2'),
(1001, '2023-11-12', 'Procedure B3'),
(1001, '2024-02-15', 'Procedure B4'),
(1001, '2024-03-22', 'Procedure B5'),		--- 1001
(1002, '2023-07-25', 'Procedure C'),
(1002, '2023-07-26', 'Procedure D'),	
(1002, '2023-07-27', 'Procedure E'),		-- 1002
(1003, '2023-07-26', 'Procedure F1'),
(1003, '2023-08-26', 'Procedure F2'),
(1003, '2023-09-26', 'Procedure F3'),		-- 1003
(1005, '2023-07-26', 'Procedure A') ;		-- 1005

--output
1	Ricky	Thomas	1001	2024-03-22	Procedure B5
2	Chloé	Monet	1002	2023-07-27	Procedure E
3	César	Torres	1003	2023-09-26	Procedure F3
5	Nicole	Johnson	1005	2023-07-26	Procedure A





SELECT	p.id, 
		p.first_name,
		p.last_name,
		p.patient_id, 
		mp.dateof_procedure, 
		mp.med_procedure_name
FROM Patients p
JOIN MedicalProcedures mp 
	ON (p.patient_id = mp.patient_id)
JOIN (
    SELECT	
			patient_id, 
			MAX(dateof_procedure) AS max_date
    FROM MedicalProcedures
    GROUP BY patient_id
) as mpd 
ON (mp.patient_id = mpd.patient_id
	AND mp.dateof_procedure = mpd.max_date)
order by p.id