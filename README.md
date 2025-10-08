# UniversityTycoon
Turn-based campus board game: buy buildings, earn credits from visitors, and survive events like bonuses, transfers, and suspensions.

## Quick start
```bash
# 1) Create fresh DB
sqlite3 tycoon.db < create.sql

# 2) Seed initial board, players, buildings, specials
sqlite3 tycoon.db < populate.sql

# 3) Reproduce the example game (Rounds 1–2)
sqlite3 tycoon.db < q1.sql
sqlite3 tycoon.db < q2.sql
sqlite3 tycoon.db < q3.sql
sqlite3 tycoon.db < q4.sql
sqlite3 tycoon.db < q5.sql
sqlite3 tycoon.db < q6.sql
sqlite3 tycoon.db < q7.sql
sqlite3 tycoon.db < q8.sql

# 4) Inspect results
sqlite3 tycoon.db
sqlite> PRAGMA foreign_keys=ON;
sqlite> .headers on
sqlite> .mode column
sqlite> SELECT * FROM Audit_Log ORDER BY Log_ID;
sqlite> SELECT Player_ID, Name, Credit_Balance, Current_Location FROM Player ORDER BY Player_ID;
