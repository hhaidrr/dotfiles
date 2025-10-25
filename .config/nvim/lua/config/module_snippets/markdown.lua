local M = {}

M.problem_document = [[
# Problem Document - {}

## Central problem
{}

## Problem characteristics
Number of users this problem applies to (high | mid | low): {}
Frequency a user will experience this problem (high | mid | low): {}

## Current Best Solutions
{}

## Observations
{}

## Ideal solution
{}
]]

M.standdown_document = [[
# Stand-Down Document

[Date: YYYY-MM-DD]
#### **Focus for Today:** [Briefly describe the main task or problem you were working on.]

---

#### 🎯 **Goals and Progress Today**
* [List the specific tasks you planned to accomplish today.]
* [Describe the progress you made on each.]

---

#### 🚧 **Current State & Roadblocks**
* **Where I Left Off:** [Describe the exact state of the system or code. E.g., "Finished implementing the data validation logic, but haven't written the unit tests yet."]
* **Key Files/Code:** [Mention the specific files or functions you were working on, e.g., `user_service.py` or the `handle_auth_flow` function.]
* **Stuck on / Open Questions:** [What is the main challenge? What is the one question or problem you need to solve next? E.g., "The integration test for the new API is failing with a 500 error, not sure why."]

---

#### ➡️ **Next Steps**
* **Next Action:** [What is the first thing you'll do when you come back? This is the most important part! E.g., "Start by debugging the 500 error in the API integration test."]
* **Follow-Up:** [Any other tasks or people you need to follow up with.]

---

#### **Thoughts / Learnings:**
* [Any new insights, a clever solution you found, or a new concept you learned today.]
]]
return M
