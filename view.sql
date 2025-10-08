CREATE VIEW leaderboard AS
SELECT 
    Player.Name AS name,
    CASE
        WHEN Building.Name IS NOT NULL THEN LOWER(REPLACE(Building.Name, ' ', '_')) -- checks if player is currently at a building
        WHEN Special.Name IS NOT NULL THEN LOWER(REPLACE(Special.Name, ' ', '_')) -- checks if player is currently at a special
    END AS location,
    Player.Credit_Balance AS credits,
    (SELECT GROUP_CONCAT(LOWER(REPLACE(Name, ' ', '_')), ', ') -- snake case formatting for building column
     FROM Building 
     WHERE Owner_ID = Player.Player_ID) AS buildings, -- only includes buildings owned by players 
    Player.Credit_Balance + IFNULL((
        SELECT SUM(Purchase_Price) -- adds up purchase price of all buildings owned by player
        FROM Building
        WHERE Owner_ID = Player.Player_ID
    ), 0) AS networth -- if player owns no buildings then the sum = 0 
FROM Player
LEFT JOIN Building ON Player.Current_Location = Building.Location_ID -- matches each players current location with a building location 
LEFT JOIN Special ON Player.Current_Location = Special.Location_ID -- matches each players current location with a special location
ORDER BY credits DESC;
