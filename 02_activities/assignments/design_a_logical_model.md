# Assignment 1: Design a Logical Model

##  
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
Your answer...
```
Type 1: Overwriting Changes
One record per customer. When an address changes, the old address is replaced with the new one.
table:
customer_id(Foreign Key to Customer)
Address fields
updated_at(timestamp of the last update)
Usage: Simple and requires less storage, but no history is kept.

Type 2: Retaining Changes
A new record is added each time the address changes, retaining all historical addresses.
table:
customer_address_id (Primary Key)
customer_id (Foreign Key to Customer)
Address fields
start_date, end_date (to track when each address is active)
is_current (to mark the active address)
Usage: Keeps a history of changes but uses more storage.


Bonus Answer:

Yes, there are privacy implications with storing customer addresses, especially when retaining historical data. Keeping old addresses (Type 2) raises the risk of sensitive data exposure and potential privacy violations if not protected. However, storing only the current address (Type 1) reduces these risks by keeping less sensitive information.


## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...
```

1.Address Type Table: The AdventureWorks schema has a separate AddressType table to categorize addresses (like home, business, and billing). This organization makes it easier to add new address types without changing the main address table.

2.Additional Tables : AdventureWorks uses additional tables for things like product details, customer information, and sales records.

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `September 28, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-4-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
