# bEtsy
## What We're Looking For

<!-- Reviewer instructions: no in-line comments on this one! Give it a quick review, and fill out the table, that's it. The goal is no more than 30 (closer to 20) minutes per submission. -->

### Manual testing

Workflow | yes / no
---   | ---
Deployed to Heroku |
**Before logging in** |
Browse all products, by category, by merchant |
Leave a review |
Verify unable to create a new product |
**After logging in** | |
Create a category |
Create a product in that category with stock 10 |
Add the product you created  |
Add it again (should update quantity) |
Verify unable to increase quantity beyond stock |
Add another merchant's product |
Check out |
Check that stock was reduced |
Change order-item's status on dashboard |
Verify unable to edit another merchant's product |
Verify unable to see another merchant's dashboard |
Verify unable to leave a review for your own product |

### Code Review

Area | yes / no
---  | ---
**Routes** |
No un-needed routes generated (check `reviews`) | 
Routes not overly-nested (check products and merchants) |
Merchant dashboard and cart page use a non-parameterized routes (should pull merchant or cart ID from session) |
**Controllers** |
Controller-filter to require login by default |
Helper methods or filters to find logged-in user, cart, product, etc |
No excessive business logic |
**Business logic that ought to live in the model** |
Add / remove / update product on order |
Checkout -> decrease inventory |
Merchant's total revenue |
Find all orders for this merchant (instance method on `Merchant`) |
Find all items from this order that are sold by this merchant (instance method on `Order`) |
**Model Tests** |
Add item to cart:<br>  - Can add a good product<br>  - Can't add a product w/o enough stock<br>  - Can't add a retired product<br>  - Can't add to an order that's not in cart mode<br>  - Logic specific to this implementation |
Get orders for this merchant:<br>  - Includes all orders from this merchant<br>  - Doesn't include orders from another merchant<br>  - Orders are not included more than once<br>  - Does something reasonable when there are no orders for this merchant |
**Controller Tests** |
Add item to cart:<br>  - Empty cart (should be created)<br>  - Cart already exists (should add to same order)<br>  - Product already in cart (should update quantity)<br>  - Bad product ID, product is retired, quantity too high, or something like that (error) |
Leave a review:<br>  - Works when not logged in<br>  - Works when logged in as someone other than the product's merchant<br>  - Doesn't work if logged in as this product's merchant<br>  - Doesn't work if validations fail |

<!-- A note on checking tests: usually just reading test names is enough, unless something is obviously wrong. You don't need to go in and evaluate the test code. Nor do you need to write much text in the evaluation, just "yes", "no", or "missing some". -->

# Only the person who submitted the PR will get an email about this feedback. Please let the rest of your team know about it.
