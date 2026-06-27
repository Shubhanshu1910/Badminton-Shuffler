# 🏸 Badminton Shuffler – Fair Rotation Algorithm

## Objective

Generate the next badminton match while ensuring:

* Every player gets nearly equal playtime.
* Waiting players are prioritized.
* Partners change frequently.
* Opponents change frequently.
* Teams remain balanced.
* No player waits for too many consecutive rounds.

---

# Flow Diagram

```text
                Match Ends
                     │
                     ▼
      Update Match Statistics
                     │
     ┌───────────────┴───────────────┐
     │                               │
Increase Games Played        Increase Waiting Count
 For Players on Court        For Players in Queue
     │                               │
     └───────────────┬───────────────┘
                     ▼
        Update Player History
 (Partners, Opponents, Consecutive Play)
                     │
                     ▼
       Move Finished Players to Queue
                     │
                     ▼
      Sort Queue by Priority Score
                     │
                     ▼
     Select Players with Highest Priority
                     │
                     ▼
     Generate Candidate Team Combinations
                     │
                     ▼
        Calculate Fairness Score
                     │
                     ▼
Choose Combination with Highest Fairness
                     │
                     ▼
        Assign Players to Courts
                     │
                     ▼
         Reset Waiting Counters
                     │
                     ▼
            Start Next Match
```

---

# Step 1 – Match Ends

When the **End Match** button is pressed:

* Stop match timer.
* Save match duration.
* Save winning team (optional).
* Save match history.

---

# Step 2 – Update Statistics

For every player who played:

```text
gamesPlayed += 1

consecutivePlay += 1

waitingRounds = 0
```

For every player waiting:

```text
waitingRounds += 1

consecutivePlay = 0
```

---

# Step 3 – Save Match History

For every player:

Store

```text
Partner IDs

Opponent IDs

Court Played

Match Number

Session ID
```

Example

```text
Player A

Partners

B
D
F

Opponents

C
E
H
```

---

# Step 4 – Queue Management

After the match ends:

```text
Court Players

↓

Queue
```

Queue Example

```text
Queue

A

B

C

I

J
```

---

# Step 5 – Calculate Priority Score

Each player gets a priority score.

Example formula

```text
Priority Score

=

WaitingRounds × 10

+

LeastGamesPlayed × 5

+

ConsecutiveWaiting × 3

+

RandomBonus
```

Highest score

↓

Selected first

Example

| Player | Games | Waiting | Priority |
| ------ | ----- | ------- | -------- |
| A      | 5     | 0       | 10       |
| B      | 4     | 2       | 42       |
| C      | 4     | 1       | 31       |
| D      | 5     | 3       | 50       |

Player D enters first.

---

# Step 6 – Generate Teams

Suppose selected players are

```text
A

B

C

D
```

Possible teams

```text
AB vs CD

AC vs BD

AD vs BC
```

Evaluate every possibility.

---

# Step 7 – Calculate Fairness Score

Every team receives a score.

Example

| Condition              | Score |
| ---------------------- | ----- |
| Never partnered before | +30   |
| Partnered once         | +10   |
| Partnered many times   | -30   |
| Never faced each other | +25   |
| Equal skill            | +20   |
| Equal games played     | +15   |

Example

```text
AB vs CD

Score = 82

AC vs BD

Score = 95

AD vs BC

Score = 61
```

Highest score wins.

---

# Step 8 – Assign Courts

If two courts

Court 1

```text
A + C

vs

B + D
```

Court 2

```text
E + G

vs

F + H
```

Queue

```text
I

J
```

---

# Step 9 – Reset Waiting Counters

Players entering court

```text
waitingRounds = 0
```

Players still waiting

```text
waitingRounds += 1
```

---

# Step 10 – Start Next Match

Display

```text
Court 1

A + C

vs

B + D

──────────────

Court 2

E + G

vs

F + H

──────────────

Queue

I

J

──────────────

Start Match
```

---

# Player Data Structure

```text
Player

id

name

gamesPlayed

gamesWon

gamesLost

waitingRounds

consecutivePlay

partners[]

opponents[]

rating

status
```

---

# Fairness Rules

The algorithm always tries to:

✅ Equalize total games played

✅ Give waiting players priority

✅ Rotate partners

✅ Rotate opponents

✅ Balance team strength

✅ Prevent anyone from waiting too long

---

# Example Rotation (10 Players, 2 Courts)

```text
Round 1

Court 1
A+B vs C+D

Court 2
E+F vs G+H

Queue
I
J
```

↓

```text
Round 2

Court 1
I+A vs J+C

Court 2
E+G vs F+H

Queue
B
D
```

↓

```text
Round 3

Court 1
B+E vs D+F

Court 2
I+H vs J+A

Queue
C
G
```

This approach continuously rotates players while keeping playtime as even as possible and reducing repeated partnerships or matchups. It provides a clear blueprint for implementing the rotation engine in code later.
