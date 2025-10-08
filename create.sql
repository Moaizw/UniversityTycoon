CREATE TABLE Player (
  Player_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Name VARCHAR(50) NOT NULL,
  Token VARCHAR(50) NOT NULL,
  Credit_Balance INTEGER NOT NULL,
  Current_Location INTEGER,
  FOREIGN KEY (Token) REFERENCES Token(Name),
  FOREIGN KEY (Current_Location) REFERENCES Location(Location_ID)
);

CREATE TABLE Token (
  Name VARCHAR(50) PRIMARY KEY,
  Available BOOLEAN
);

CREATE TABLE Location (
  Location_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Type TEXT NOT NULL
);

CREATE TABLE Special (
  Name VARCHAR(50) PRIMARY KEY,
  Description_of_Action TEXT NOT NULL,
  Fine_Cost INTEGER NULL,
  Award_Cost INTEGER NULL,
  Location_ID INTEGER,
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);

CREATE TABLE Building (
  Name VARCHAR(50) PRIMARY KEY,
  Tuition_Fee INTEGER NOT NULL,
  Colour VARCHAR(50),
  Purchase_Price INTEGER NOT NULL,
  Location_ID INTEGER,
  Owner_ID INTEGER NULL,
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
  FOREIGN KEY (Owner_ID) REFERENCES Player(Player_ID)
);


CREATE TABLE Audit_Log (
  Log_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Round_Number INTEGER NOT NULL,
  Dice_Rolled INTEGER NOT NULL,
  Action_Type VARCHAR(50) NULL,
  Credit_Balance INTEGER NOT NULL,
  Player_ID INTEGER NOT NULL,
  Location_ID INTEGER NOT NULL,
  FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);

-- Triggers 

--Trigger for Welcome Week Credit
CREATE TRIGGER AwardCreditsOnPassingWelcomeWeek
AFTER UPDATE OF Current_Location ON Player
FOR EACH ROW
WHEN OLD.Current_Location > (SELECT Location_ID FROM Special WHERE Name = 'Welcome Week')
  AND NEW.Current_Location < OLD.Current_Location
BEGIN
    -- +100 credits to the player that passes WW
    UPDATE Player
    SET Credit_Balance = Credit_Balance + 100
    WHERE Player_ID = NEW.Player_ID;
END;


-- Trigger for landing on RAG-1

CREATE TRIGGER land_on_RAG1
AFTER UPDATE OF Current_Location ON Player
FOR EACH ROW
WHEN NEW.Current_Location = (SELECT Location_ID FROM Special WHERE Name = 'RAG 1')
BEGIN
    -- award 15 credits to the player
    UPDATE Player
    SET Credit_Balance = Credit_Balance + 15
    WHERE Player_ID = NEW.Player_ID;
END;

-- Trigger for landing on an unowned Building
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


-- Trigger for landing on an owned building 
CREATE TRIGGER pay_tuition_fee
AFTER UPDATE OF Current_Location ON Player
FOR EACH ROW
WHEN (NEW.Current_Location IN (SELECT Location_ID FROM Building WHERE Owner_ID IS NOT NULL AND Owner_ID != NEW.Player_ID)) -- Condition for trigger to be activated
BEGIN
    -- Take away tuition fee from player that lands on the owned building
    UPDATE Player
    SET Credit_Balance = Credit_Balance - (
        SELECT 
            CASE 
                WHEN (
                    SELECT COUNT(*) 
                    FROM Building
                    WHERE Colour = (SELECT Colour FROM Building WHERE Location_ID = NEW.Current_Location)
                ) = (
                    SELECT COUNT(*) 
                    FROM Building
                    WHERE Colour = (SELECT Colour FROM Building WHERE Location_ID = NEW.Current_Location)
                    AND Owner_ID = (SELECT Owner_ID FROM Building WHERE Location_ID = NEW.Current_Location)
                )
                THEN (SELECT Tuition_Fee * 2 FROM Building WHERE Location_ID = NEW.Current_Location)  -- Double fee for monopoly
                ELSE (SELECT Tuition_Fee FROM Building WHERE Location_ID = NEW.Current_Location)       -- Standard fee
            END
    )
    WHERE Player_ID = NEW.Player_ID;

    -- Adding tuition fee to the owner of building with double if owner owns a monopoly
    UPDATE Player
    SET Credit_Balance = Credit_Balance + (
        SELECT 
            CASE 
                WHEN (
                    SELECT COUNT(*) 
                    FROM Building
                    WHERE Colour = (SELECT Colour FROM Building WHERE Location_ID = NEW.Current_Location)
                ) = (
                    SELECT COUNT(*) 
                    FROM Building
                    WHERE Colour = (SELECT Colour FROM Building WHERE Location_ID = NEW.Current_Location)
                    AND Owner_ID = (SELECT Owner_ID FROM Building WHERE Location_ID = NEW.Current_Location)
                )
                THEN (SELECT Tuition_Fee * 2 FROM Building WHERE Location_ID = NEW.Current_Location)  -- x2 tuition fee if monopoly
                ELSE (SELECT Tuition_Fee FROM Building WHERE Location_ID = NEW.Current_Location)       -- normal tuition fee
            END
    )
    WHERE Player_ID = (SELECT Owner_ID FROM Building WHERE Location_ID = NEW.Current_Location);
END;



--Trigger for landing on Youre Suspended

CREATE TRIGGER MoveToVisitorOnSuspension
AFTER UPDATE OF Current_Location ON Player
FOR EACH ROW
WHEN NEW.Current_Location = (SELECT Location_ID FROM Special WHERE Name = 'Youre Suspended')
BEGIN
    -- The update statment here will move player from Youre suspended to Visitor
    UPDATE Player
    SET Current_Location = (SELECT Location_ID FROM Special WHERE Name = 'Visitor')
    WHERE Player_ID = NEW.Player_ID;
	
    -- When moving from Youre suspended to Visitor, player does not interact with any locations on the way so credit balance should remain unchanged  
    UPDATE Player
    SET Credit_Balance = OLD.Credit_Balance
    WHERE Player_ID = NEW.Player_ID;
END;
