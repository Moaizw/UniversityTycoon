-- Uli Rolls a 4
UPDATE Player
SET Current_Location = (Current_Location + 4) % 20
WHERE Name = 'Uli';

INSERT INTO Audit_Log (Log_ID, Round_Number, Dice_Rolled, Action_Type, Credit_Balance, Player_ID, Location_ID)
VALUES (
    7,
    2,  
    4,  
    'no action',
    (SELECT Credit_Balance FROM Player WHERE Name = 'Uli'),
    (SELECT Player_ID FROM Player WHERE Name = 'Uli'),
    (SELECT Current_Location FROM Player WHERE Name = 'Uli')
);
