-- Move Uli forward by 5 spaces
UPDATE Player
SET Current_Location = (Current_Location + 5) % 20  
WHERE Name = 'Uli';

INSERT INTO Audit_Log (Log_ID, Round_Number, Dice_Rolled, Action_Type, Credit_Balance, Player_ID, Location_ID)
VALUES (
    2,
    1,
    5,  
    'Awarded 15cr',
    (SELECT Credit_Balance FROM Player WHERE Name = 'Uli'),
    (SELECT Player_ID FROM Player WHERE Name = 'Uli'),
    (SELECT Current_Location FROM Player WHERE Name = 'Uli')
);
