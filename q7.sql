--Pradyumn rolls a 2

UPDATE Player
SET Current_Location = (Current_Location + 2) % 20
WHERE Name = 'Pradyumn';


INSERT INTO Audit_Log (Log_ID, Round_Number, Dice_Rolled, Action_Type, Credit_Balance, Player_ID, Location_ID)
VALUES (
    8,
    2,  
    2,  
    'Move to Visitor, Suspension !',
    (SELECT Credit_Balance FROM Player WHERE Name = 'Pradyumn'),
    (SELECT Player_ID FROM Player WHERE Name = 'Pradyumn'),
    (SELECT Current_Location FROM Player WHERE Name = 'Pradyumn')
);
