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
- **Good**: `customer.getAvailableBalance()` (The customer object handles the delegation).
