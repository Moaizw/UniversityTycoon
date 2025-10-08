# University Tycoon — Scenario (Data & Rules Brief)

> Player-facing instructions are in **[GAMEPLAY.md](GAMEPLAY.md)**.  
> This file documents the **data requirements**, **rules** as enforced by SQL, and **assumptions**.

## Entities (minimum)
- **Player**: `player_id` (PK), `name` (unique), `token` (FK → Token), `credit_balance` (int), `current_location` (FK → Location).
- **Token**: `token_id` (PK), `name` (unique; Mortarboard, Book, Certificate, Gown, Laptop, Pen).
- **Location**: `location_id` (PK), `name`, `type` ∈ {Corner, Hearing, RAG, Building}, `colour` (nullable for non-buildings), `order_index` (board position).
- **Building**: `building_id` (PK), `name` (unique), `tuition_fee` (int), `owner_player_id` (nullable FK → Player), `colour` (mandatory for set logic).
- **Special** (Corner / Hearing / RAG grouped as “specials”): `special_id` (PK), `name` (unique, e.g., “RAG 1”), `description`.
- **Audit_Log**: `log_id` (PK, autoinc), `round_number`, `player_id`, `location_landed`, `credit_balance_after`.

## Core constraints
- Max **6 players**; each player must have **exactly one** token; tokens are unique per game.
- A **building** has either **one owner or none**.
- **Colour sets** define monopoly (owning all buildings of that colour).

## Rules to enforce (via triggers / procedures)
- **R0 – Movement (clockwise)**: updates `Player.current_location` by die roll modulo board length.
- **R1 – Buy unowned**: on landing on an unowned building, **debit 2× tuition** and set `owner_player_id`.
- **R2 – Pay owner**: on landing on an owned building, **transfer tuition** (or **2×** if owner has full colour set).
- **R3 – Suspension**: status/state represented by location = `Suspension`; leaving requires a roll of **6**; then **roll again**.
- **R4 – Welcome Week**: **+100** when **landing on or passing** that square.
- **R5 – Roll = 6**: landing square **has no effect**; then **extra roll**.
- **R6 – You’re Suspended!**: relocate to `Suspension` **without** Welcome Week credit.
- **R7 – RAG/Hearing**: execute the **card action** per `Special.description`.
- **R8 – Visiting Suspension**: landing there while not suspended → **no action**.

## Audit requirements
- Every turn append to `Audit_Log`: `player_id`, `round_number`, `location_landed`, `credit_balance_after`.
- **Append-only**; do not update past rows.

## Initial state (example alignment)
- Board: ordered `Location` rows with `order_index = 0…(N-1)`.
- Ownership markers: owner’s token displayed at the building’s top-right (derived from `Building.owner_player_id`).
- Colour → set mapping defined in `Location/Building` data (for monopoly checks).

## Ambiguities you must decide (and document)
- **Negative balances** allowed or blocked? (Choose and enforce.)  
- **At most one Special per player**: on acquiring a new one, **replace** or **reject**?  
- **R5 interaction** with auto-buy/pay: your implementation should **skip all effects** on the roll-6 landing.  
- **Passing Welcome Week** detection: use indices (from → to) with wrap-around logic.  
- **Game end**: number of rounds or insolvency triggers—define for your demo.

## Example turns (for reproducibility)
Round 1:  
1) Gareth rolls 4  
2) Uli rolls 5  
3) Pradyumn rolls 6, then 4  
4) Ruth rolls 5

Round 2:  
1) Gareth rolls 4  
2) Uli rolls 4  
3) Pradyumn rolls 2  
4) Ruth rolls 6, then 1

## File map (expected)
- `create.sql` — tables, constraints, triggers implementing R0–R8.  
- `populate.sql` — tokens, locations (with colour/shape), buildings, specials, starting players.  
- `q1.sql … q8.sql` — scripted turns to reproduce the example rounds.

