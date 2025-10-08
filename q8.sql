-- Ruth rolls a 6
UPDATE Player
SET Current_Location = (Current_Location + 6) % 20
WHERE Name = 'Ruth';


UPDATE Player
SET Credit_Balance = 330 -- credit for ruth remains unchanged when landing on Prads building 
WHERE Name = 'Ruth';

UPDATE Player
SET Credit_Balance = 415 -- credit for Prad remains unchanged when ruth lands on his building after rolling 6
WHERE Name = 'Pradyumn'; 

INSERT INTO Audit_Log (Log_ID, Round_Number, Dice_Rolled, Action_Type, Credit_Balance, Player_ID, Location_ID)
VALUES (
    9,
    2,  
    6,  
    'No action',  
    330,  
    (SELECT Player_ID FROM Player WHERE Name = 'Ruth'),
    (SELECT Current_Location FROM Player WHERE Name = 'Ruth') 
);

-- Ruth rolls a 1
UPDATE Player
SET Current_Location = (Current_Location + 1) % 20
WHERE Name = 'Ruth';


INSERT INTO Audit_Log (Log_ID, Round_Number, Dice_Rolled, Action_Type, Credit_Balance, Player_ID, Location_ID)
VALUES (
    10,
    2,  
    1,  
    'Paying double the rent fee to monopoly owner',  
    (SELECT Credit_Balance FROM Player WHERE Name = 'Ruth'),  
    (SELECT Player_ID FROM Player WHERE Name = 'Ruth'),
    (SELECT Current_Location FROM Player WHERE Name = 'Ruth')  
);
