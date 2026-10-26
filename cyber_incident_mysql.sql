-- =====================================================================
-- CYBERSECURITY INCIDENT & RISK ANALYTICS  |  MySQL Workbench version (MySQL 8.0+)
-- Chalane ka tareeka: MySQL Workbench -> File -> Open SQL Script -> Execute (bijli wala button / Ctrl+Shift+Enter)
-- Kisi ek query ko chalane ke liye: usko select karo -> Ctrl+Enter
-- =====================================================================

-- STEP 0: database banao aur use karo
DROP DATABASE IF EXISTS cyber_incident_db;
CREATE DATABASE cyber_incident_db;
USE cyber_incident_db;

-- ===================== PART 1 : DDL =====================
CREATE TABLE systems (
  system_id    INT          PRIMARY KEY,
  system_name  VARCHAR(50)  NOT NULL UNIQUE,
  criticality  INT          CHECK (criticality BETWEEN 1 AND 10)
);
CREATE TABLE user_roles (
  role_id    INT          PRIMARY KEY,
  role_name  VARCHAR(30)  NOT NULL UNIQUE
);
CREATE TABLE incidents (
  incident_id    INT          PRIMARY KEY,
  incident_date  DATE         NOT NULL,
  system_id      INT          NOT NULL,
  role_id        INT          NOT NULL,
  incident_type  VARCHAR(30)  NOT NULL,
  impact_score   INT          CHECK (impact_score BETWEEN 1 AND 10),
  FOREIGN KEY (system_id) REFERENCES systems(system_id),
  FOREIGN KEY (role_id)   REFERENCES user_roles(role_id)
);
CREATE TABLE responses (
  response_id     INT PRIMARY KEY,
  incident_id     INT NOT NULL,
  response_hours  DECIMAL(5,1) CHECK (response_hours >= 0),
  status          VARCHAR(10) DEFAULT 'Open' CHECK (status IN ('Open','Closed')),
  FOREIGN KEY (incident_id) REFERENCES incidents(incident_id)
);
-- ALTER: severity column add karo
ALTER TABLE incidents ADD COLUMN severity VARCHAR(10);
CREATE INDEX idx_inc_system ON incidents(system_id);

-- ===================== PART 2 : DML (INSERT) =====================
INSERT INTO systems VALUES (1, 'Web Server', 9);
INSERT INTO systems VALUES (2, 'Database', 10);
INSERT INTO systems VALUES (3, 'Payment API', 10);
INSERT INTO systems VALUES (4, 'VPN', 8);
INSERT INTO systems VALUES (5, 'Email Gateway', 7);
INSERT INTO systems VALUES (6, 'File Server', 6);
INSERT INTO systems VALUES (7, 'HR Portal', 5);
INSERT INTO systems VALUES (8, 'Wi-Fi', 3);
INSERT INTO systems VALUES (9, 'Backup NAS', 6);
INSERT INTO user_roles VALUES (1, 'Admin');
INSERT INTO user_roles VALUES (2, 'Employee');
INSERT INTO user_roles VALUES (3, 'Analyst');
INSERT INTO user_roles VALUES (4, 'Contractor');
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1001, '2026-01-01', 4, 4, 'Malware', 7);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1002, '2026-01-05', 1, 2, 'Malware', 5);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1003, '2026-01-17', 1, 4, 'Phishing', 4);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1004, '2026-01-19', 8, 2, 'Phishing', 7);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1005, '2026-02-14', 6, 3, 'Phishing', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1006, '2026-02-16', 1, 1, 'Phishing', 4);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1007, '2026-02-22', 2, 2, 'Malware', 8);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1008, '2026-02-24', 1, 2, 'Phishing', 6);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1009, '2026-02-25', 1, 1, 'Phishing', 4);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1010, '2026-03-05', 4, 4, 'Unauthorized Access', 5);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1011, '2026-03-07', 1, 4, 'Data Leak', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1012, '2026-03-08', 1, 2, 'Malware', 7);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1013, '2026-03-16', 1, 1, 'Unauthorized Access', 8);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1014, '2026-03-21', 2, 2, 'Malware', 4);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1015, '2026-03-23', 1, 4, 'Phishing', 5);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1016, '2026-04-01', 2, 3, 'Unauthorized Access', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1017, '2026-04-06', 2, 1, 'DDoS', 10);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1018, '2026-04-07', 4, 3, 'Phishing', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1019, '2026-04-13', 5, 1, 'Phishing', 6);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1020, '2026-04-14', 3, 1, 'Phishing', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1021, '2026-04-15', 2, 3, 'DDoS', 9);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1022, '2026-04-21', 3, 2, 'Data Leak', 7);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1023, '2026-04-23', 1, 2, 'Malware', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1024, '2026-04-24', 2, 1, 'Phishing', 4);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1025, '2026-05-07', 2, 3, 'Phishing', 8);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1026, '2026-05-07', 3, 1, 'DDoS', 10);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1027, '2026-05-09', 6, 3, 'Unauthorized Access', 7);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1028, '2026-05-15', 1, 3, 'Phishing', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1029, '2026-05-17', 1, 3, 'Malware', 5);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1030, '2026-05-18', 8, 4, 'Malware', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1031, '2026-05-22', 3, 4, 'Malware', 3);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1032, '2026-05-25', 2, 2, 'Malware', 3);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1033, '2026-05-28', 7, 1, 'Malware', 4);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1034, '2026-05-28', 4, 4, 'Phishing', 10);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1035, '2026-06-03', 5, 3, 'Unauthorized Access', 7);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1036, '2026-06-12', 1, 4, 'Phishing', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1037, '2026-06-14', 7, 3, 'DDoS', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1038, '2026-06-15', 1, 3, 'Phishing', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1039, '2026-06-16', 1, 4, 'Malware', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1040, '2026-06-17', 1, 2, 'Malware', 6);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1041, '2026-06-18', 1, 3, 'Malware', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1042, '2026-07-01', 1, 2, 'Phishing', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1043, '2026-07-04', 3, 1, 'Data Leak', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1044, '2026-07-06', 3, 4, 'DDoS', 10);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1045, '2026-07-16', 3, 3, 'Phishing', 5);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1046, '2026-07-18', 7, 1, 'Malware', 4);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1047, '2026-07-19', 1, 4, 'Phishing', 5);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1048, '2026-07-21', 2, 2, 'Phishing', 9);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1049, '2026-07-25', 1, 2, 'Phishing', 8);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1050, '2026-07-25', 1, 3, 'Phishing', 5);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1051, '2026-07-27', 4, 1, 'DDoS', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1052, '2026-08-03', 1, 2, 'Malware', 7);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1053, '2026-08-04', 1, 3, 'Phishing', 8);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1054, '2026-08-11', 2, 1, 'Unauthorized Access', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1055, '2026-08-13', 4, 1, 'Phishing', 5);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1056, '2026-08-17', 2, 1, 'Phishing', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1057, '2026-08-28', 5, 4, 'Malware', 10);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1058, '2026-09-10', 4, 3, 'Phishing', 10);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1059, '2026-09-16', 4, 2, 'Data Leak', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1060, '2026-09-18', 4, 1, 'Unauthorized Access', 8);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1061, '2026-09-21', 4, 4, 'Phishing', 2);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1062, '2026-10-02', 4, 4, 'Phishing', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1063, '2026-10-02', 2, 4, 'Malware', 7);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1064, '2026-10-07', 4, 3, 'Malware', 8);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1065, '2026-10-15', 3, 1, 'Phishing', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1066, '2026-10-21', 1, 4, 'Phishing', 4);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1067, '2026-10-21', 2, 4, 'Malware', 10);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1068, '2026-10-22', 3, 1, 'Unauthorized Access', 5);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1069, '2026-10-26', 1, 4, 'Phishing', 1);
INSERT INTO incidents (incident_id,incident_date,system_id,role_id,incident_type,impact_score) VALUES (1070, '2026-10-27', 2, 3, 'Phishing', 3);
INSERT INTO responses VALUES (5001, 1001, 1.2, 'Closed');
INSERT INTO responses VALUES (5002, 1002, 1.3, 'Closed');
INSERT INTO responses VALUES (5003, 1003, 1.8, 'Closed');
INSERT INTO responses VALUES (5004, 1004, 3.2, 'Closed');
INSERT INTO responses VALUES (5005, 1005, 3.6, 'Closed');
INSERT INTO responses VALUES (5006, 1006, 8.4, 'Closed');
INSERT INTO responses VALUES (5007, 1007, 1.2, 'Closed');
INSERT INTO responses VALUES (5008, 1008, 9.0, 'Closed');
INSERT INTO responses VALUES (5009, 1009, 1.1, 'Closed');
INSERT INTO responses VALUES (5010, 1010, 2.1, 'Closed');
INSERT INTO responses VALUES (5011, 1011, 1.9, 'Closed');
INSERT INTO responses VALUES (5012, 1012, 40.9, 'Closed');
INSERT INTO responses VALUES (5013, 1013, 6.6, 'Closed');
INSERT INTO responses VALUES (5014, 1014, 2.2, 'Closed');
INSERT INTO responses VALUES (5015, 1015, 2.4, 'Closed');
INSERT INTO responses VALUES (5016, 1016, 4.4, 'Closed');
INSERT INTO responses VALUES (5017, 1017, 2.0, 'Closed');
INSERT INTO responses VALUES (5018, 1018, 1.1, 'Closed');
INSERT INTO responses VALUES (5019, 1019, 11.6, 'Closed');
INSERT INTO responses VALUES (5020, 1020, 3.5, 'Closed');
INSERT INTO responses VALUES (5021, 1021, 6.6, 'Closed');
INSERT INTO responses VALUES (5022, 1022, 3.4, 'Closed');
INSERT INTO responses VALUES (5023, 1023, 37.4, 'Closed');
INSERT INTO responses VALUES (5024, 1024, 3.6, 'Closed');
INSERT INTO responses VALUES (5025, 1025, 1.1, 'Closed');
INSERT INTO responses VALUES (5026, 1026, 1.4, 'Closed');
INSERT INTO responses VALUES (5027, 1027, 1.5, 'Closed');
INSERT INTO responses VALUES (5028, 1028, 1.9, 'Closed');
INSERT INTO responses VALUES (5029, 1029, 2.9, 'Closed');
INSERT INTO responses VALUES (5030, 1030, 1.3, 'Closed');
INSERT INTO responses VALUES (5031, 1031, 7.1, 'Closed');
INSERT INTO responses VALUES (5032, 1032, 4.7, 'Closed');
INSERT INTO responses VALUES (5033, 1033, 3.2, 'Closed');
INSERT INTO responses VALUES (5034, 1034, 1.0, 'Closed');
INSERT INTO responses VALUES (5035, 1035, 2.3, 'Closed');
INSERT INTO responses VALUES (5036, 1036, 6.9, 'Closed');
INSERT INTO responses VALUES (5037, 1037, 2.4, 'Closed');
INSERT INTO responses VALUES (5038, 1038, 4.6, 'Closed');
INSERT INTO responses VALUES (5039, 1039, 46.0, 'Closed');
INSERT INTO responses VALUES (5040, 1040, 6.4, 'Closed');
INSERT INTO responses VALUES (5041, 1041, 1.2, 'Closed');
INSERT INTO responses VALUES (5042, 1042, 2.8, 'Closed');
INSERT INTO responses VALUES (5043, 1043, 3.4, 'Closed');
INSERT INTO responses VALUES (5044, 1044, 1.7, 'Closed');
INSERT INTO responses VALUES (5045, 1045, 3.0, 'Closed');
INSERT INTO responses VALUES (5046, 1046, 1.2, 'Closed');
INSERT INTO responses VALUES (5047, 1047, 8.7, 'Closed');
INSERT INTO responses VALUES (5048, 1048, 5.1, 'Closed');
INSERT INTO responses VALUES (5049, 1049, 2.7, 'Closed');
INSERT INTO responses VALUES (5050, 1050, 1.1, 'Closed');
INSERT INTO responses VALUES (5051, 1051, 1.7, 'Closed');
INSERT INTO responses VALUES (5052, 1052, 2.5, 'Closed');
INSERT INTO responses VALUES (5053, 1053, 1.7, 'Closed');
INSERT INTO responses VALUES (5054, 1054, 3.3, 'Closed');
INSERT INTO responses VALUES (5055, 1055, 2.3, 'Closed');
INSERT INTO responses VALUES (5056, 1056, 5.7, 'Closed');
INSERT INTO responses VALUES (5057, 1057, 2.8, 'Closed');
INSERT INTO responses VALUES (5058, 1058, 2.6, 'Closed');
INSERT INTO responses VALUES (5059, 1059, 1.1, 'Closed');
INSERT INTO responses VALUES (5060, 1060, 1.7, 'Closed');
INSERT INTO responses VALUES (5061, 1061, 1.1, 'Closed');
INSERT INTO responses VALUES (5062, 1062, 1.2, 'Open');
INSERT INTO responses VALUES (5063, 1063, 4.6, 'Open');
INSERT INTO responses VALUES (5064, 1064, 4.5, 'Open');
INSERT INTO responses VALUES (5065, 1065, 1.3, 'Open');
INSERT INTO responses VALUES (5066, 1066, 7.3, 'Open');
INSERT INTO responses VALUES (5067, 1067, 4.3, 'Open');
INSERT INTO responses VALUES (5068, 1068, 3.1, 'Open');
INSERT INTO responses VALUES (5069, 1069, 3.8, 'Open');
INSERT INTO responses VALUES (5070, 1070, 3.9, 'Open');

-- ===================== PART 3 : DML (UPDATE / DELETE) + CASE =====================
-- Workbench ka "Safe Updates" mode WHERE ke bina UPDATE rok deta hai (Error 1175), isliye band karo
SET SQL_SAFE_UPDATES = 0;

-- Excel ke nested IF jaisa hi logic
UPDATE incidents SET severity =
  CASE WHEN impact_score >= 9 OR incident_type = 'Ransomware' THEN 'Critical'
       WHEN impact_score >= 7 THEN 'High'
       WHEN impact_score >= 4 THEN 'Medium'
       ELSE 'Low' END;

-- Safe demo: INSERT / UPDATE / DELETE phir ROLLBACK
START TRANSACTION;
INSERT INTO incidents VALUES (9999, CURDATE(), 2, 3, 'Data Leak', 9, 'Critical');
UPDATE incidents SET impact_score = 10 WHERE incident_id = 9999;
DELETE FROM incidents WHERE incident_id = 9999;
ROLLBACK;

-- ===================== PART 4 : SELECT, WHERE, ORDER BY =====================
SELECT * FROM incidents;
SELECT incident_id, incident_type, impact_score FROM incidents WHERE impact_score >= 8 ORDER BY impact_score DESC, incident_id;
SELECT * FROM incidents WHERE incident_type IN ('Ransomware','Data Leak') AND incident_date BETWEEN '2026-03-01' AND '2026-06-30';
SELECT DISTINCT incident_type FROM incidents WHERE incident_type LIKE '%a%';

-- ===================== PART 5 : Single-row, conversion, conditional functions =====================
SELECT UPPER(incident_type) AS type_uc, LENGTH(incident_type) AS len,
       DATE_FORMAT(incident_date,'%d-%b-%Y') AS fmt_date, DATE_FORMAT(incident_date,'%b') AS mth,
       IFNULL(severity,'Unclassified') AS sev, CONCAT(ROUND(impact_score/10*100), '%') AS impact_pct
FROM incidents;
SELECT incident_id,
       CASE severity WHEN 'Critical' THEN 'P1' WHEN 'High' THEN 'P2' WHEN 'Medium' THEN 'P3' ELSE 'P4' END AS priority
FROM incidents;                                                      -- (Oracle DECODE ki jagah CASE)
SELECT STR_TO_DATE('15-Aug-2026','%d-%b-%Y') AS d, CAST('8.5' AS DECIMAL(4,1)) AS n;

-- ===================== PART 6 : Group functions =====================
SELECT severity, COUNT(*) AS incidents, ROUND(AVG(impact_score),1) AS avg_impact FROM incidents GROUP BY severity ORDER BY incidents DESC;
SELECT DATE_FORMAT(incident_date,'%Y-%m') AS month, COUNT(*) AS incidents FROM incidents GROUP BY DATE_FORMAT(incident_date,'%Y-%m') ORDER BY 1;
SELECT incident_type, COUNT(*) AS cnt FROM incidents GROUP BY incident_type HAVING COUNT(*) >= 5 ORDER BY cnt DESC;
SELECT MIN(response_hours) AS fastest, MAX(response_hours) AS slowest, ROUND(AVG(response_hours),1) AS mean_hrs,
       ROUND(STDDEV(response_hours),1) AS std_hrs FROM responses;
-- MySQL me MEDIAN function nahi hota, isliye window function se nikalte hain
SELECT ROUND(AVG(response_hours),1) AS median_hrs FROM (
  SELECT response_hours, ROW_NUMBER() OVER (ORDER BY response_hours) AS rn, COUNT(*) OVER () AS cnt FROM responses
) t WHERE rn IN (FLOOR((cnt+1)/2), CEIL((cnt+1)/2));

-- ===================== PART 7 : JOINS =====================
-- 7a INNER JOIN (incident + system + role + response)
SELECT i.incident_id, s.system_name, r.role_name, i.incident_type, i.severity, p.response_hours
FROM incidents i
JOIN systems s     ON i.system_id = s.system_id
JOIN user_roles r  ON i.role_id   = r.role_id
JOIN responses p   ON p.incident_id = i.incident_id
ORDER BY p.response_hours DESC;

-- 7b EXPERIMENT 4 PATTERN: LEFT JOIN -> zero incident wale systems bhi (Backup NAS)
SELECT s.system_name, COUNT(i.incident_id) AS total_incidents, IFNULL(ROUND(AVG(p.response_hours),1),0) AS avg_hours
FROM systems s
LEFT JOIN incidents i ON s.system_id = i.system_id
LEFT JOIN responses p ON p.incident_id = i.incident_id
GROUP BY s.system_name ORDER BY total_incidents DESC;

-- 7c Role wise incidents
SELECT r.role_name, COUNT(*) AS incidents, SUM(CASE WHEN i.severity='Critical' THEN 1 ELSE 0 END) AS critical
FROM incidents i JOIN user_roles r ON i.role_id = r.role_id GROUP BY r.role_name ORDER BY incidents DESC;

-- ===================== PART 8 : SUB-QUERIES =====================
-- average se zyada incidents wale systems  (MySQL me AVG(COUNT(*)) direct nahi chalta, derived table use hota hai)
SELECT s.system_name, COUNT(*) AS c FROM incidents i JOIN systems s ON s.system_id = i.system_id
GROUP BY s.system_name
HAVING COUNT(*) > (SELECT AVG(c) FROM (SELECT COUNT(*) AS c FROM incidents GROUP BY system_id) t)
ORDER BY c DESC;
-- overall average se slow responses
SELECT incident_id, response_hours FROM responses WHERE response_hours > (SELECT AVG(response_hours) FROM responses) ORDER BY 2 DESC;
-- OUTLIERS: mean + 2*std rule
SELECT incident_id, response_hours FROM responses
WHERE response_hours > (SELECT AVG(response_hours) + 2*STDDEV(response_hours) FROM responses);

-- ===================== PART 9 : SET OPERATORS =====================
-- UNION har MySQL version me chalta hai. MINUS/INTERSECT ki jagah NOT IN / IN (ya MySQL 8.0.31+ me EXCEPT / INTERSECT)
SELECT system_id FROM systems WHERE system_id NOT IN (SELECT system_id FROM incidents);              -- MINUS: kabhi attack nahi hue
SELECT DISTINCT system_id FROM incidents WHERE incident_type='Ransomware'
  AND system_id IN (SELECT system_id FROM incidents WHERE incident_type='Phishing');                 -- INTERSECT: dono se hit
SELECT system_id FROM incidents WHERE severity='Critical'
UNION SELECT system_id FROM incidents WHERE incident_type='DDoS';                                    -- UNION: koi ek

-- ===================== PART 10 : UNIQUE ANGLE - Risk patterns =====================
-- Same system par same attack >= 3 baar => stronger monitoring chahiye
SELECT s.system_name, i.incident_type, COUNT(*) AS times
FROM incidents i JOIN systems s ON s.system_id = i.system_id
GROUP BY s.system_name, i.incident_type HAVING COUNT(*) >= 3 ORDER BY times DESC;

-- Risk score = incidents x avg impact x criticality / 10
CREATE OR REPLACE VIEW v_system_risk AS
SELECT s.system_id, s.system_name, s.criticality,
       COUNT(i.incident_id) AS incidents,
       IFNULL(ROUND(AVG(i.impact_score),1),0) AS avg_impact,
       IFNULL(ROUND(AVG(p.response_hours),1),0) AS avg_hours,
       SUM(CASE WHEN i.severity='Critical' THEN 1 ELSE 0 END) AS critical_cnt,
       ROUND(COUNT(i.incident_id) * IFNULL(AVG(i.impact_score),0) * s.criticality / 10) AS risk_score
FROM systems s LEFT JOIN incidents i ON i.system_id = s.system_id
LEFT JOIN responses p ON p.incident_id = i.incident_id
GROUP BY s.system_id, s.system_name, s.criticality;

SELECT v.*, CASE WHEN critical_cnt >= 3 OR avg_hours > 6 THEN 'NEEDS MONITORING' ELSE 'OK' END AS status
FROM v_system_risk v ORDER BY risk_score DESC;

-- SLA performance
SELECT CASE WHEN response_hours <= 6 THEN 'Met' ELSE 'Breached' END AS sla, COUNT(*) AS cnt,
       ROUND(COUNT(*)*100/SUM(COUNT(*)) OVER (),1) AS pct
FROM responses GROUP BY CASE WHEN response_hours <= 6 THEN 'Met' ELSE 'Breached' END;

-- ===================== PART 11 : Other schema objects + Data dictionary =====================
-- MySQL me SEQUENCE nahi hota, AUTO_INCREMENT use hota hai (demo table)
CREATE TABLE incident_log (log_id INT AUTO_INCREMENT PRIMARY KEY, note VARCHAR(100));
INSERT INTO incident_log (note) VALUES ('first'), ('second');
SELECT * FROM incident_log;

CREATE OR REPLACE VIEW v_critical_open AS
SELECT i.incident_id, i.incident_type, p.response_hours FROM incidents i JOIN responses p ON p.incident_id=i.incident_id
WHERE i.severity='Critical' AND p.status='Open';

SELECT table_name, table_type FROM information_schema.tables WHERE table_schema = 'cyber_incident_db';
SELECT column_name, data_type, is_nullable FROM information_schema.columns WHERE table_schema='cyber_incident_db' AND table_name='incidents';
SELECT constraint_name, constraint_type, table_name FROM information_schema.table_constraints WHERE table_schema='cyber_incident_db' AND table_name IN ('incidents','responses');

-- ===================== PART 12 : DCL (root user se chalao) =====================
CREATE ROLE IF NOT EXISTS 'analyst_role', 'viewer_role';
GRANT SELECT, INSERT, UPDATE ON cyber_incident_db.incidents TO 'analyst_role';
GRANT SELECT ON cyber_incident_db.incidents TO 'viewer_role';
GRANT SELECT ON cyber_incident_db.systems   TO 'analyst_role', 'viewer_role';
GRANT SELECT ON cyber_incident_db.v_system_risk TO 'viewer_role';

CREATE USER IF NOT EXISTS 'soc_viewer'@'localhost' IDENTIFIED BY 'Viewer#123';
CREATE USER IF NOT EXISTS 'soc_analyst'@'localhost' IDENTIFIED BY 'Analyst#123';
GRANT 'viewer_role'  TO 'soc_viewer'@'localhost';
GRANT 'analyst_role' TO 'soc_analyst'@'localhost';
SET DEFAULT ROLE ALL TO 'soc_viewer'@'localhost', 'soc_analyst'@'localhost';

REVOKE UPDATE ON cyber_incident_db.incidents FROM 'analyst_role';   -- permission wapas lo
SHOW GRANTS FOR 'analyst_role';
SHOW GRANTS FOR 'soc_viewer'@'localhost';
-- Test: Workbench me soc_viewer ka naya connection banao, phir: DELETE FROM cyber_incident_db.incidents;
-- -> ERROR 1142: DELETE command denied

-- ===================== APPENDIX : EXPERIMENT 4 (e-commerce customers + orders) =====================
CREATE TABLE customers (customer_id INT PRIMARY KEY, customer_name VARCHAR(50));
CREATE TABLE orders (order_id INT PRIMARY KEY, customer_id INT, order_amount DECIMAL(10,2), FOREIGN KEY (customer_id) REFERENCES customers(customer_id));
INSERT INTO customers VALUES (1,'Aman'), (2,'Simran'), (3,'Rohit');
INSERT INTO orders VALUES (101,1,2500), (102,1,1500), (103,2,800);
SELECT c.customer_id, c.customer_name, IFNULL(SUM(o.order_amount),0) AS total_spent
FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name ORDER BY total_spent DESC;   -- Rohit = 0 => potential customer
