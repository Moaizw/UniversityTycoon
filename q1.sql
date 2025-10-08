-- Gareth rolls a 4
UPDATE Player
SET Current_Location = (Current_Location + 4) % 20
WHERE Name = 'Gareth';

INSERT INTO Audit_Log (Log_ID, Round_Number, Dice_Rolled, Action_Type, Credit_Balance, Player_ID, Location_ID)
VALUES (
    1,
    1,
    4,  
    'Awarded 100cr',
    (SELECT Credit_Balance FROM Player WHERE Name = 'Gareth'),
    (SELECT Player_ID FROM Player WHERE Name = 'Gareth'),
    (SELECT Current_Location FROM Player WHERE Name = 'Gareth')
);

