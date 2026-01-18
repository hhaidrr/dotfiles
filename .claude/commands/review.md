# Code Review Checklist

# Logical edge cases
- Can breaks be caused through database state changes?
- can breaks be caused through function parameter?
- can breaks be caused through network response differences?

# Strength/processing/data integrity/reliability
- Race conditions
-- are multiple commits competing for unlocked resources?
-- using implicit locks, explicit locks to prevent races?
-- Are we performing arithmetic and basic data operations/aggregations within the database layer itself when possible? (performance benefit as well)

# Performance
- Are we performing more queries than necessary?
- Are we performing more network calls than necessary?
- Any n+1 requests?
- Can time complexity be reduced?

# Maintainability
- Is it easy to understand syntactically?
- Are the semantics good? Do they describe intent well?
- Are good clarifying docstrings/comments in place when the code isnt enough?
- Are orchestrator functions separate from business logic functions within the service layer?
- is the work layered properly? MVC?

- Are functions extracted well? How much cyclomatic complexity is there?

- How much coupling is there?
-- Are objects reaching into each other too much? (law of demeter)

- do functions assume things about the internals of other functions?

- pure functions are separated from side effect functions (easier unit testing segregation from orchestration logic which require integration tests)

- branching is separate and isolated from in parent functions from leaf and unbranching functions
