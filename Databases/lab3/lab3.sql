
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

SELECT denumire, id_facultate
FROM facultate
WHERE id_facultate % 2 = 1;
-- Afișează denumirea și id_facultate pentru facultățile care au id_facultate
-- impar.

SELECT nationalitate, nume
FROM persoana
WHERE nume LIKE '%a%';
-- Afișează naționalitatea și numele persoanelor care au in componenta numelui
-- litera “a”.

SELECT grupa
FROM student
WHERE bursa IS NOT NULL AND semestru = 2;
-- Afișează grupa studenților care au bursa și sunt în semestrul 2.

SELECT nume
FROM persoana
ORDER BY nume ASC;
-- Afișează lista tuturor numelor persoanelor, ordonate în ordine alfabetică.

SELECT nume
FROM persoana
ORDER BY nume ASC
LIMIT 10;
-- Afișează lista cu numele primelor 10 persoane, ordonate în ordine alfabetică

SELECT decan
FROM facultate
WHERE an_fondare BETWEEN 1900 AND 1995;
-- Afișează numele decanilor care conduc facultăți fondate între anii 1900,1995

INSERT INTO materie (id_materie, id_specializare, denumire, an_de_studiu, semestru, profesor)
VALUES (12, 1, 'Etica', 2024, 1, 'Prof. Cosma Doe');
-- Adaugă în tabela materie o înregistrare cu materia: Etica.

DELETE FROM materie
WHERE denumire LIKE '%tica%';
-- Șterge toate materiile care contin string-ul “tica”.

SELECT *
FROM specializare;
-- Afișează toate atributele pentru toate înregistrările din tabela specializare