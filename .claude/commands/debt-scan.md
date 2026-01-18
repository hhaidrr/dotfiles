# /scan-debt
Scan the codebase for technical debt based on our specific checklist.

- Scope: @src/

## Instructions
1. Read the criteria in the ## Checklist section.
2. Search through @src/ to find violations of these specific rules.
3. Create a report including each issue found. Each issue should include:
   - File path and line number range.
   - Code snippet
   - Which checklist item it violates.
   - A brief suggestion for the fix based on industry standards and best practices.
4. Finally, output a summary table of the total debt found.

## Checklist
### Law of Demeter (Principle of Least Knowledge)
- [ ] **Violation**: Chained method calls or property access across different object boundaries.
- [ ] **The "One Dot" Rule**: A method `m` of object `O` should only invoke:
    - Methods of `O` itself.
    - Methods of objects passed as arguments to `m`.
    - Methods of objects created/instantiated within `m`.
    - Methods of `O`’s direct component objects.
- [ ] **Exemption**: Do not flag "Fluent APIs" or "Method Chaining" where the return type is the same class (e.g., Builders or django queryset methods, jQuery-style chains).

#### Example of LoD Debt:
- **Bad**: `customer.getWallet().getCard().getBalance()` (3 dots reaching into sub-objects).
- **Bad**: `customer.wallet.card.object.get_balance()` (django style deep ORM chaining, coupling to many db table relations).
- **Good**: `customer.getAvailableBalance()` (The customer object handles the delegation).
