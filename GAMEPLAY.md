# University Tycoon — Gameplay Instructions

> See the data model and exact trigger logic in **[SCENARIO.md](SCENARIO.md)**.

## Objective
Finish with the highest **credit balance**.

## Setup
- Players: up to **6**. Each chooses **one** unique token: Mortarboard, Book, Certificate, Gown, Laptop, Pen.
- Starting state: set initial **credits** and **starting location**; keep these consistent with your seed data.
- Turn order: fixed order throughout the game.

## Turn
1. Roll a fair **6-sided die**.  
2. Move **clockwise** that many spaces.  
3. Resolve the effect of the **landing** space.  
4. Record the turn in the **audit log**.

## Spaces
- **Building**
  - If **unowned** → buy from University for **2× tuition fee** (mandatory).
  - If **owned** → pay the owner the **tuition fee**; pay **double** if the owner holds **all buildings of that colour**.
- **Welcome Week**  
  - Landing on **or passing** grants **+100 credits**.
- **RAG / Hearing**  
  - Apply the action described by the card.
- **You’re Suspended!**  
  - Move directly to **Suspension** (do **not** pass Welcome Week; **no** +100).
- **Suspension (Visitor)**  
  - If you merely land there (not suspended), **no action**.

## Suspension
- While suspended you remain at **Suspension**.  
- You must roll a **6** to leave; on leaving you **immediately roll again**.

## Rolling a 6 (general rule)
- Move 6; the landing space has **no effect**; then **roll again immediately**.

## End of Game
- End after **N rounds** (define N) or by your chosen win condition.  
- Winner: highest **credits**. Tie-breakers (if needed): buildings owned → total tuition value → last-round net gain.

## Board Notation / UI
- Token on **inner edge** of a square = current location.  
- Token at **top-right** of a building square = owner.  
- Building **colour** sets also have a **high-contrast shape** (triangle, square, circle, diamond, cross, ring).

