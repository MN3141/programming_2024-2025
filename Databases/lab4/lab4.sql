
create table persoana(
cnp VARCHAR(13) PRIMARY KEY,
seria VARCHAR(4) NULL,
nr INT NULL,
prenume VARCHAR(30) NOT NULL,
nume VARCHAR(30) NOT NULL,
adresa VARCHAR(50) NOT NULL,
nationalitate VARCHAR(50) NOT NULL
);


create table facultate(
id_facultate INT PRIMARY KEY,
denumire VARCHAR(50) NOT NULL,
adresa VARCHAR(50) NOT NULL,
an_fondare YEAR NOT NULL,
decan VARCHAR(55) NOT NULL
);

create table specializare(
id_specializare INT PRIMARY KEY,
id_facultate INT NOT NULL,
denumire VARCHAR(50) NOT NULL,
FOREIGN KEY (id_facultate) REFERENCES universitas.facultate(id_facultate)
);


create table student(
nr_matricol INT PRIMARY KEY,
id_specializare INT NULL,
FOREIGN KEY (id_specializare) REFERENCES universitas.specializare(id_specializare),
cnp VARCHAR(13),
FOREIGN KEY (cnp) REFERENCES universitas.persoana(cnp),
an_curent INT NOT NULL,
grupa VARCHAR(10) NOT NULL,
semestru INT NOT NULL,
bursa TINYINT NULL
);

create table materie(
id_materie INT PRIMARY KEY,
id_specializare INT NOT NULL,
denumire VARCHAR(50) NOT NULL,
an_de_studiu INT NOT NULL,
semestru TINYINT NOT NULL,
profesor VARCHAR(50) NOT NULL,
FOREIGN KEY (id_specializare) REFERENCES universitas.specializare(id_specializare)
);


create table nota(
id_nota INT PRIMARY KEY,
id_student INT NOT NULL,
id_curs INT NOT NULL,
nota INT NOT NULL,
data_examen DATE NULL,
FOREIGN KEY (id_student) REFERENCES universitas.student(nr_matricol),
FOREIGN KEY (id_curs) REFERENCES universitas.materie(id_materie)
);

INSERT INTO persoana (cnp, seria, nr, prenume, nume, adresa, nationalitate) VALUES
('1234567890123', 'AB12', 1, 'John', 'Doe', '123 Main St, City', 'USA'),
('2345678901234', 'AB34', 2, 'Jane', 'Smith', '456 Elm St, City', 'USA'),
('3456789012345', 'AB56', 3, 'Alex', 'Brown', '789 Oak St, City', 'USA'),
('4567890123456', 'AB78', 4, 'Maria', 'Davis', '101 Pine St, City', 'USA'),
('5678901234567', 'AB90', 5, 'Michael', 'Wilson', '202 Maple St, City', 'USA'),
('6789012345678', 'AB12', 6, 'Sarah', 'Taylor', '303 Cedar St, City', 'USA'),
('7890123456789', 'AB34', 7, 'David', 'Anderson', '404 Birch St, City', 'USA'),
('8901234567890', 'AB56', 8, 'Emma', 'Thomas', '505 Spruce St, City', 'USA'),
('9012345678901', 'AB78', 9, 'William', 'Jackson', '606 Walnut St, City', 'USA'),
('0123456789012', 'AB90', 10, 'Olivia', 'White', '707 Cherry St, City', 'USA');

select * from persoana;

INSERT INTO facultate (id_facultate, denumire, adresa, an_fondare, decan) VALUES
(1, 'Facultatea de Inginerie', 'Str. Inginerilor 1, București', 1995, 'Prof. Dr. Ion Popescu'),
(2, 'Facultatea de Drept', 'Str. Dreptului 2, București', 1990, 'Prof. Dr. Maria Ionescu'),
(3, 'Facultatea de Științe Economice', 'Str. Economiei 3, București', 2000, 'Prof. Dr. Andrei Georgescu'),
(4, 'Facultatea de Litere', 'Str. Literaturii 4, București', 1985, 'Prof. Dr. Elena Marin');

INSERT INTO specializare (id_specializare, id_facultate, denumire) VALUES
(1, 1, 'Inginerie Mecanică'),        
(2, 1, 'Inginerie Electrică'),         
(3, 2, 'Drept Penal'),                 
(4, 2, 'Drept Civil'),                
(5, 3, 'Finanțe și Bănci'),            
(6, 4, 'Filologie Germană');            

SELECT * FROM specializare;
INSERT INTO student (nr_matricol, id_specializare, cnp, an_curent, grupa, semestru, bursa) VALUES
(1001, 1, '1234567890123', 2024, 'A1', 1, NULL),  
(1002, 2, '2345678901234', 2024, 'A2', 1, NULL), 
(1003, 3, '3456789012345', 2024, 'A1', 1, NULL), 
(1004, 4, '4567890123456', 2024, 'A1', 1, NULL),  
(1005, 5, '5678901234567', 2024, 'A2', 1, NULL),  
(1006, 6, '6789012345678', 2024, 'A1', 1, NULL), 
(1007, 1, '7890123456789', 2024, 'A1', 1, NULL), 
(1008, 1, '8901234567890', 2024, 'A1', 1, NULL), 
(1009, 1, '9012345678901', 2024, 'A1', 1, NULL),  
(1010, 6, '0123456789012', 2024, 'A2', 1, NULL); 

INSERT INTO materie (id_materie, id_specializare, denumire, an_de_studiu, semestru, profesor) VALUES
(1, 1, 'Mecanica Tehnica', 1, 1, 'Prof. Ionescu'),          
(2, 1, 'Termodinamică', 1, 2, 'Prof. Popescu'),           
(3, 1, 'Mecatronica', 2, 1, 'Prof. Vasilescu'),            
(4, 2, 'Circuite Electrice', 1, 1, 'Prof. Georgescu'),     
(5, 2, 'Teoria Semnalelor', 1, 2, 'Prof. Albu'),           
(6, 2, 'Sisteme de Control', 2, 1, 'Prof. Matei'),          
(7, 3, 'Drept Penal General', 1, 1, 'Prof. Radu'),          
(8, 3, 'Drept Procesual Penal', 2, 2, 'Prof. Daciana'),    
(9, 4, 'Drept Civil General', 1, 1, 'Prof. Stanescu'),      
(10, 4, 'Drept Comercial', 2, 1, 'Prof. Barbu');            

INSERT INTO nota (id_nota, id_student, id_curs, nota, data_examen) VALUES
(1, 1001, 1, 8, '2024-05-15'),    -- Student 1001, Course 1, Grade 8
(2, 1001, 2, 7, '2024-05-20'),    -- Student 1001, Course 2, Grade 7
(3, 1002, 1, 9, '2024-05-15'),    -- Student 1002, Course 1, Grade 9
(4, 1002, 3, 10, '2024-05-18'),   -- Student 1002, Course 3, Grade 10
(5, 1003, 2, 6, '2024-05-20'),    -- Student 1003, Course 2, Grade 6
(6, 1003, 4, 5, '2024-05-21'),     -- Student 1003, Course 4, Grade 5
(7, 1004, 5, 8, '2024-05-22'),    -- Student 1004, Course 5, Grade 8
(8, 1004, 6, 7, '2024-05-23'),    -- Student 1004, Course 6, Grade 7
(9, 1005, 1, 10, '2024-05-25'),   -- Student 1005, Course 1, Grade 10
(10, 1005, 7, 6, '2024-05-26'),   -- Student 1005, Course 7, Grade 6
(11, 1006, 2, 5, '2024-05-27'),    -- Student 1006, Course 2, Grade 5
(12, 1006, 8, 4, '2024-05-28'),    -- Student 1006, Course 8, Grade 4
(13, 1007, 3, 9, '2024-05-29'),    -- Student 1007, Course 3, Grade 9
(14, 1007, 9, 7, '2024-05-30'),    -- Student 1007, Course 9, Grade 7
(15, 1008, 4, 8, '2024-06-01'),    -- Student 1008, Course 4, Grade 8
(16, 1008, 10, 9, '2024-06-02'),    -- Student 1008, Course 10, Grade 9
(17, 1009, 5, 10, '2024-06-03'),   -- Student 1009, Course 5, Grade 10
(18, 1009, 1, 6, '2024-06-04'),    -- Student 1009, Course 1, Grade 6
(19, 1010, 6, 4, '2024-06-05'),    -- Student 1010, Course 6, Grade 4
(20, 1010, 7, 3, '2024-06-06');    -- Student 1010, Course 7, Grade 3

-- Query alias
select avg(nota) as media_note from nota


-- Afișați pentru fiecare notă din tabelul nota timpul trecut de la acordarea notei până în prezent
SELECT DATEDIFF(CURDATE(), data_examen) AS zile_trecute
FROM nota;

-- Afișați din tabelul persoană numele complet al studentului într-o singură coloană, și seria cu numărul de buletin în altă coloană.
select concat(prenume," ",nume) as nume_intreg from persoana

-- Afișați din tabelul student numărul de studenți înmatriculați și numărul total
-- de persoane înmatriculate. Acest exercițiu reflectă posibilitatea unei persoane
-- de a fi student la mai multe facultăți simultan

SELECT 
    COUNT(*) AS numar_total_inmatriculari,           
    COUNT(DISTINCT cnp) AS numar_total_persoane
FROM 
    student;
    
 SELECT * from student   
 
 -- Afișează numele decanilor de facultate cu caractere mari : Ex: POPESCU.(Fără să modifici în baza de date)
 
 SELECT upper(decan) as decan_upper from facultate;
 
 -- Afișează CNP-ul, numele persoanei, luna nașterii (numeric, ex: 08), luna
-- nașterii( text, ex: August) pentru toate persoanele. (Extrage luna nasterii din CNP.

SELECT 
    cnp,
    nume,
    prenume,
    SUBSTRING(cnp, 3, 2) AS luna_nasterii_numerica,
    CASE SUBSTRING(cnp, 3, 2)
        WHEN '01' THEN 'Ianuarie'
        WHEN '02' THEN 'Februarie'
        WHEN '03' THEN 'Martie'
        WHEN '04' THEN 'Aprilie'
        WHEN '05' THEN 'Mai'
        WHEN '06' THEN 'Iunie'
        WHEN '07' THEN 'Iulie'
        WHEN '08' THEN 'August'
        WHEN '09' THEN 'Septembrie'
        WHEN '10' THEN 'Octombrie'
        WHEN '11' THEN 'Noiembrie'
        WHEN '12' THEN 'Decembrie'
        ELSE 'Lună necunoscută'
    END AS luna_nasterii_text
FROM 
    persoana;
    
-- Afișează în format ASCII numele profesorilor care au in componenta numelui litera ‘a’. (opțional)
SELECT ASCII(profesor) FROM  materie 
WHERE profesor LIKE '%a';

-- Adaugă litera ‘x’ în fața numelui decanilor care conduc facultăți ce au denumirea formată din mai puțin de 5 caractere. (opțional)
UPDATE facultate
SET decan = CONCAT('x', decan)
WHERE CHAR_LENGTH(denumire) < 5;

SELECT * from facultate;