# Debt Wanchor TODO

This checklist captures the current project state and the agreed implementation order.

## Completed

- [x] Confirm the existing WaniKani summary integration.
- [x] Confirm the existing Discord webhook sender and Sidekiq job skeleton.
- [x] Create branch `add-wanikani-discord-test-coverage`.
- [x] Add Minitest characterization coverage for lesson and review counting.
- [x] Add coverage for the current per-user summary message.
- [x] Add Discord payload and response handling tests without real network calls.
- [x] Make Faraday available outside the development-only gem group.
- [x] Bring `db/schema.rb` up to date with the existing debt manager migration.
- [x] Run the Rails test suite: 12 runs, 21 assertions, 0 failures, 1 skipped test.

## Next

- [x] Define the debt metric as lessons + reviews.
- [x] Represent each user's WaniKani result as structured data instead of only a sentence.
- [x] Add tests for the chosen total/debt calculation before implementing it.
- [ ] Implement the two-person comparison: totals, difference, and ratio.
- [ ] Add edge-case tests, including equal totals and division by zero.
- [ ] Format a clear Discord comparison message.
- [ ] Re-enable Discord posting in `UpdateDebtJob`.
- [ ] Add job tests that verify Discord is called without making network requests.
- [ ] Decide whether the latest WaniKani total should update `users.debt`.
- [ ] If persisted, update the home-page ranking and add model/controller coverage.
- [ ] Run focused tests after each change and the full Rails suite before each commit.

## Deferred Security Work

- [ ] Rotate the Discord webhook URLs that GitGuardian identified as exposed.
- [ ] Confirm the new webhook is stored only in Rails credentials or an environment variable.
- [ ] Review repository history for any remaining active secrets.

## Current Reference

- Branch: `add-wanikani-discord-test-coverage`
- Baseline commit: `7394f34 Add WaniKani and Discord baseline coverage`
- Test command: `rbenv exec bundle exec rails test`
