-- Move Pradyumn by 6 spaces

DROP TRIGGER auto_buy_unowned_building; -- Prad lands on SP (unowned) after rolling 6, we do not want him to buy and own this building

UPDATE Player
SET Current_Location = (Current_Location + 6) % 20
WHERE Name = 'Pradyumn';


INSERT INTO Audit_Log (Log_ID, Round_Number, Dice_Rolled, Action_Type, Credit_Balance, Player_ID, Location_ID)
VALUES (
    3,
    1,  
    6,  
    'no action', -- no action taken on the first roll since it's a 6
    465,  -- credit balance remains the same
    (SELECT Player_ID FROM Player WHERE Name = 'Pradyumn'),
    (SELECT Current_Location FROM Player WHERE Name = 'Pradyumn') 
);

--recreate trigger before next roll
CREATE TRIGGER auto_buy_unowned_building
AFTER UPDATE OF Current_Location ON Player
FOR EACH ROW
WHEN NEW.Current_Location IN (SELECT Location_ID FROM Building WHERE Owner_ID IS NULL)
BEGIN
    -- Makes the player the new owner of the building in Player table
    UPDATE Building
    SET Owner_ID = NEW.Player_ID
    WHERE Location_ID = NEW.Current_Location;

    -- Removes 2x the tuition fee from players current balance
    UPDATE Player
    SET Credit_Balance = Credit_Balance - (SELECT Tuition_Fee * 2 FROM Building WHERE Location_ID = NEW.Current_Location)
    WHERE Player_ID = NEW.Player_ID;
END;

--Move Pradyumn by 4 spaces
UPDATE Player
SET Current_Location = (Current_Location + 4) % 20
WHERE Name = 'Pradyumn';

INSERT INTO Audit_Log (Log_ID, Round_Number, Dice_Rolled, Action_Type, Credit_Balance, Player_ID, Location_ID)
VALUES (
    4,
    1,
    4,  
    'Purchased unowned Building',  
    (SELECT Credit_Balance FROM Player WHERE Name = 'Pradyumn'),
    (SELECT Player_ID FROM Player WHERE Name = 'Pradyumn'),
    (SELECT Current_Location FROM Player WHERE Name = 'Pradyumn') 
);
