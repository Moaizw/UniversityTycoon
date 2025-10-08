-- Ruth Rolls a 5
UPDATE Player
SET Current_Location = (Current_Location + 5) % 20
WHERE Name = 'Ruth';

INSERT INTO Audit_Log (Log_ID, Round_Number, Dice_Rolled, Action_Type, Credit_Balance, Player_ID, Location_ID)
VALUES (
    5,
    1,
    5,  
    'Paid Owner of Building after landing on it',
    (SELECT Credit_Balance FROM Player WHERE Name = 'Ruth'),
    (SELECT Player_ID FROM Player WHERE Name = 'Ruth'),
    (SELECT Current_Location FROM Player WHERE Name = 'Ruth')
);

