# bEtsy
[Much like other e-commerce platforms](https://www.etsy.com/), your team will make an online store where a wide variety of products can be listed and sold by any user. This project focuses on reinforcing the major components of Rails, model validations, testing, and more complex logic such as user authentication.

This is a [Stage 3](https://github.com/Ada-Developers-Academy/pedagogy/blob/master/rule-of-three.md) project requiring you to expand upon what you have learned in class.

Due date: EOD Friday October 26

## Project Learning Goals
- Core comprehension of:
  - Routes
  - Controllers
  - Models
  - Views
- User based application logic
- User authentication
- Testing on models and controllers
- Agile practices
- Feature branch management with Git
- Group project ownership

## Guidelines
- Groups of three or four will collaborate in pairs or individually and will report to their assigned Project Manager (one of the instructors)
- Use a task manager like [Trello](http://trello.com) to track your team's efforts
- Build a logical user-flow that moves across multiple controllers and models
- Use HTML/CSS and Bootstap or another CSS framework to style your website

## Getting Started
1. As a group decide on an app name (this may help lead the aesthetic)
1. As a group decide on a team name (this will amuse your instructors)
1. Have one person on your team fork/clone the project master as per usual
  1. Create a new rails app using `rails new .`
  1. Add all other team members as collaborators
  1. Each team member should clone the repo to their computer
1. Figure out your workflow for the project, re: Git and Task management
  1. Do you want to use git branches? Pull requests?
  1. Determine who will be the Stand Up Leader and Task Leader for the first week
1. Create a Trello board to use as a Kanban board and ensure that all team members and instructors have access
1. Review the User Stories below and create Trello tasks to represent them
1. Slack your team name, app name, and link to your Trello board to your Project Manager

## Expectations
Build an online system for listing, selling, reviewing, and buying a wide variety of products listed by multiple merchants.

### General Requirements
- Unit tests and/or specs for
  - Models
  - Controllers
- Test code coverage (using SimpleCov - remember me!)
  - 90% for all controller and model classes

### Prioritization

This project contains many user stories, some of which are more relevant to our in-class learning goals than others. Here is a rough categorization of how important various features are:

#### High Priority

- Browsing products
- Using the shopping cart (adding items, checking out)
- Authentication as a merchant
- CRUD on products, including authorization rules
- Model testing, particularly for any custom logic
- Controller testing

#### Medium Priority

- Product categories
- Basic validations (things that will break the site)
- Tracking product inventory
- Order fulfillment

#### Low Priority

- Reviews and ratings
- Comprehensive validations, particularly around submitting an order

### User Stories
#### Guest User (Unauthenticated)
As a guest to the website (not signed in) I **can**:

- Browse all products
- Browse products by category
- Browse products by merchant (users)
- View any individual product with additional details
- Leave a review for a product providing:
    - A text review
    - A rating out of 5
- Add in-stock products to my cart
- Remove products from my cart
- Change the quantity of an existing product in my cart
- Purchase the items in my cart, providing:
    - Email Address
    - Mailing Address
    - Name on credit card
    - Credit card number
    - Credit cart expiration
    - Credit Card CVV (security code)
    - Billing zip code
- Purchasing an order makes the following changes:
    - Reduces the number of inventory for each product
    - Changes the order state from "pending" to "paid"
    - Clears the current cart
- After purchasing an order, I can view a confirmation screen including:
    - Each item in the order with a quantity and line-item subtotal
    - A link to the item description page
    - Order total price
    - Date/time the order was placed
    - The current status of the order
- Sign up to be a merchant using OAuth
    - Every merchant must have a username
- Sign in to my merchant account using OAuth

As a guest I **cannot**:

- Add products to the cart that are out of stock
- View any link or page to manage any products
- View any of the account pages

#### Authenticated Users
As a signed-in user, I **can**:

- Do everything a guest user can do except for sign up and sign in
- Sign out
- Create new categories (categories are shared between all merchants)
- Create a new product providing:
    - name
    - description
    - price
    - photo URL
    - stock
- Assign my products to any number of categories
- Retire a product from being sold, which hides it from browsing
- View an account page to edit/update my existing products
- View an account page showing my order fulfillment
- On the order fulfillment page:
    - Total Revenue
    - Total Revenue by status
    - Total number of orders by status
    - Filter orders displayed by status
    - Link to each individual order
    - A list of orders including at least one of my products:
        - Each order item sold by me with a quantity and line-item subtotal
        - A link to the item description page
        - DateTime the order was placed
        - Link to transition the order item to marked as shipped
        - The current status of the order ("pending", "paid", "complete", "cancelled")
- View an individual order to see the user's:
    - Name
    - Email address
    - Mailing address
    - Last four digits of their credit card
    - Credit card expiration date

As a signed-in user, I **cannot**:

- Review my own products
- View order items from a shared order that belong to another merchant
- View another user's private data (i.e. order fulfillment or product management)

### Validations
Many of our models will have attributes that are required for our application to use and display data consistently. Each model will have attributes with requirements for a valid record. The requirements are summarized below:

#### Merchant
- Username must be present
- Username must be unique
- Email Address must be present
- Email Address must be unique

#### Product
- Name must be present
- Name must be unique
- Price must be present
- Price must be a number
- Price must be greater than 0
- Product must belong to a User

#### Order
- An Order must have one or more Order Items

#### OrderItem
- Must belong to a Product
- Must belong to an Order
- Quantity must be present
- Quantity must be an integer
- Quantity must be greater than 0

#### Review
- Rating must be present
- Rating must be an integer
- Rating must be between 1 and 5

## Process

We expect you to follow the agile process we've learned about in class as you work on this project.

### Team Leaders
Each team will have team leaders who are responsible for keeping track of each team member's contributions. Rotate leader roles at the beginning of the second week; every team member should be in at least one leader role during the project.

- **Stand Up Leader**
  - Notifies team members about meeting schedule and ensures that everyone is present and ready
  - Takes notes about each person's daily report in Stand Up
  - Keeps the meeting moving
- **Task Leader**
  - Leads discussion on task assignment and prioritization
    - Decide if a task should be completed alone or in a pair
    - Assign tasks based on...
      - Individual comfort
      - Desire
      - Ability
  - Ensures the Kanban board stays up to date

### Stand Up Meetings
The Stand Up Leader should determine the daily time for your stand up meeting with the team. Once you come up with a time, confirm with your PM that this time will work for them.

At the end of each day, your team's assigned Project Manager will review the Trello board to ensure it captures the updates that your team has made throughout the day.

### Interim Demo
In a real world work environment, a team's success is measured by their product as opposed to each individual's contribution.

Each team will present their progress and respond to questions from their Project Manager on the first Friday. Every team member will participate in these demos; the PM will ask specific questions regarding
1. The team's progress and plan for completing the project
1. The technical decisions and implementation
1. Every team member's understanding of the underlying technical structures

### Midpoint Retrospective

On the first Friday, instead of our normal full-class retro, each team will get together and conduct a small-scale retro. One team member should facilitate, this may be the standup leader or someone else. Your retro should focus on the following questions:
- What has gone well?
- What could have gone better?
- Where is our direction still unclear?

## Final Presentation
Each team will present their product in a final presentation to the group on the final Friday. Your presentation should be no more than 7 minutes. The presentation should include every team member and:
- what you learned as individuals and as a group
- a short story-driven demo of interesting features

## Submission Guidelines
Your final project must be deployed to [Heroku](http://heroku.com). Your team will open a single pull request for the entire project. There are comprehension questions to answer with your submission that you should complete together as a group. Remember, you can submit a PR and still make some final changes to your code, so don't wait until the last minute.

## What Instructors Are Looking For
Check out the [feedback template](feedback.md) which lists the items instructors will be looking for as they evaluate your project.
