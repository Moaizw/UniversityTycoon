-- Inserting values into Tables 

INSERT INTO Token
VALUES 
('Certificate', 0),
('Mortarboard', 0),
('Book', 0),
('Pen', 0),
('Gown', 1),
('Laptop', 1);

INSERT INTO Location
VALUES
(1, 'Corner'),
(2, 'Building'),
(3, 'Building'),
(4, 'Hearing'),
(5, 'Building'),
(6, 'Building'),
(7, 'RAG'),
(8, 'Corner'),
(9,  'Building'),
(10, 'Building'),
(11, 'Corner'),
(12, 'Building'),
(13, 'Building'),
(14, 'RAG'),
(15, 'Building'),
(16, 'Building'),
(17, 'Hearing'),
(18, 'Corner'),
(19, 'Building'),
(20, 'Building');


INSERT INTO Player
VALUES
(71, 'Gareth', 'Certificate', 345, 19),
(47, 'Uli', 'Mortarboard', 590, 2),
(53, 'Pradyumn', 'Book', 465, 6),
(49, 'Ruth', 'Pen', 360, 4);


INSERT INTO Building
VALUES
('Kilburn',  15, 'Green', 30, 2, 49),
('IT', 15, 'Green', 30, 3, 71),
('Uni Place', 25, 'Orange', 50, 5, 71),
('AMBS', 25, 'Orange', 50, 6, 47),
('Crawford', 30, 'Blue', 60, 9, 53),
('Sugden', 30, 'Blue', 60, 10, 71),
('Shopping Precint', 35, 'Brown', 70, 12, NULL),
('MECD', 35, 'Brown', 70, 13, 47),
('Library', 40, 'Grey', 80, 15, 53),
('Sam Alex', 40, 'Grey', 80, 16, NULL),
('Museum', 50, 'Black', 100, 19, 53),
('Whitworth Hall', 50, 'Black', 100, 20, 49);

INSERT INTO Special
VALUES
('Welcome Week', 'Awarded 100cr', NULL, 100, 1),
('Hearing 1', 'Fined 20cr', 20, NULL, 4),
('RAG 1', 'Awarded 15cr', NULL, 15, 7),
('Visitor', 'No action is taken', NULL, NULL, 8),
('Ali G', 'No action is taken', NULL, NULL, 11),
('RAG 2', 'Give all other players 10cr', 10, NULL, 14),
('Hearing 2', 'Fined 25cr', 25, NULL, 17),
('Youre Suspended', 'Go to Visitor without passing Welcome Week or collecting credits. Roll a 6 to be released', NULL, NULL, 18);
