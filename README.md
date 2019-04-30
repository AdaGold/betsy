# bEtsy

## At a Glance

- Group, [stage 3](https://github.com/Ada-Developers-Academy/pedagogy/blob/master/rule-of-three.md) project
- Due EOD Friday, 6 PM PST, *DATE HERE*

## Introduction

[Much like other e-commerce platforms](https://www.etsy.com/), your team will make an online store where a wide variety of products can be listed and sold by any user. This project focuses on reinforcing the major components of Rails, model validations, testing, and more complex logic such as user authentication.

## Learning Goals

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

## Objective

We will build an online platform for listing, selling, reviewing, and buying a wide variety of products listed by multiple merchants.

This platform will support different kinds of users:

- users who never log in, and primarily want to be able to browse products and mange their shopping cart
- users who become merchants by logging in, and primarily want to manage products listed in their online shop

Teams will build this online platform following these principles:

- collaborate in pairs or individually throughout the week
- report to their assigned Project Manager (one of the instructors) and have frequent communication with them
- use a task manager like [Trello](http://trello.com) to track all work
- build a logical user-flow that moves across multiple controllers and models
- use HTML/CSS and Bootstap or another CSS framework to style your website

## Getting Started

1. As a group decide on an app name (this may help lead the aesthetic)
1. As a group decide on a team name (this will amuse your instructors)
1. Have one person on your team fork/clone the project master as per usual
    - Create a new rails app using `rails new .`
    - Add all other team members as collaborators
    - Each team member should clone the repo to their computer
1. Figure out your workflow for the project, re: git and task management
    - Do you want to use git branches? Pull requests?
1. Review the Process Requirements below
    - Determine who will be the Stand Up Leader and Task Leader for the first week
1. Create a Trello board to use as a Kanban board and ensure that all team members and the PM have access
1. Review the User Stories below and create Trello tasks to represent them
1. Slack your team name, app name, and invitation link to your Trello board to your Project Manager
1. Begin work on drafting an ERD together as a team!

## Non-Functional Requirements

This project must have:
  - 90% reported coverage for all controller and model classes using SimpleCov
  - Deployment to Heroku

### Images Must Be Externally Hosted

**All images used must be hosted on an external service.** To use an externally-hosted image, use absolute URLs to the website.

Examples of websites that will host your images:
- Imgur
- Google+ Photos
- Flickr
- TinyPic

You may use any other service besides those examples.

Heroku and Rails have very specific requirements to make images appear correctly after deployment. To avoid distracting yourselves from fighting deployment fires, we recommend using externally hosted images

## Process Requirements

We expect you to follow this modified Agile process as you work on this project:

### Team Leaders

Each team will have team leaders who are responsible for keeping track of each team member's contributions. Rotate leader roles at the beginning of the second week; every team member will be in at least one leader role during the project.

#### Stand Up Leader

The stand up leader has the following responsibilities:

- Determine the daily time for team standup. Once a time is decided, confirm with the PM that this time will work for them
- Notify team members about meeting schedule and ensures that everyone is present and ready
- Take notes about each person's update reported during stand up
- Keep the meeting moving

#### Task Leader

The task leader has the following responsibilities:

- Leads discussion on task assignment, prioritization, and organization
- Decide if a task should be completed alone or in a pair
- Assign tasks based on...
  - Individual comfort
  - Desire
  - Ability

### Stand Up Meetings

Make sure they're scheduled and they happen. The ideal stand up meeting is short and it's an important way to start the day on the right page. It's also the best chance to get the team together and ask for help.

### Kanban Board

Everyone is responsible for keeping the Kanban board accurate _at all times_.

This means the following:
- When you pick up a task, move the task from the "To do" column to "Doing"
- When you finish a task, move the task from the "Doing" column to "Done"
- When you stop work on a task, move the task from "Doing" back to "To do"
- When a task changes in nature, update the task's name and description and any relevant labels

_Do not_ leave the responsibility of the Kanban board to just one or two people. _Stay accountable to your team and the work you are doing._

At the end of each day, your team's assigned Project Manager will review the Trello board to ensure it captures the updates that your team has made throughout the day.

### Interim Demo

In a real world work environment, a team's success is measured by their product as opposed to each individual's contribution.

Each team will present their progress and respond to questions from their Project Manager at the halfway mark of the project. Every team member will participate in these demos; the PM will ask specific questions regarding:
1. The team's progress and plan for completing the project
1. The technical decisions and implementation
1. Every team member's understanding of the underlying technical structures

### Midpoint Retrospective

On the first Friday, instead of our normal full-class retro, each team will get together and conduct a small-scale retro. One team member should facilitate, this may be the standup leader or someone else. Your retro should focus on the following questions:
- What has gone well?
- What could have gone better?
- Where is our direction still unclear?

## Workflow Requirements

It is required on this project that each person follows the workflow of a full-stack developer.

Each person is not required to be an _expert_ on each thing, or to do the work perfectly.

However, after project setup has happened and project feature development is underway, each developer will be responsible for maintaining good practices.

For each task/feature that you work on, you are also responsible for:

- writing all of the unit tests relevant to their feature (nominal and edge cases)
- writing all of the controller tests (nominal and edge cases)
- writing the view code needed for the feature
- running the tests before pushing code
- adhering to the team's standards of git hygiene (PRs, branches, etc)

Do _not_ leave writing the tests to your features to someone else!

---

## Prioritization

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

---

## Functional Requirements

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
- View any merchant dashboard page

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
- View my merchant dashboard page to edit/update my existing products
- View my merchant dashboard page showing my order fulfillment
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

---

## Final Presentation Requirements

Each team will present their product in a final presentation to the group on the final Friday. Your presentation should be no more than 7 minutes. The presentation should include every team member and:
- what you learned as individuals and as a group
- a short story-driven demo of interesting features

## Submission Guidelines

Your final project must be deployed to [Heroku](http://heroku.com). Your team will open a single pull request for the entire project. There are comprehension questions to answer with your submission that you should complete together as a group. Remember, you can submit a PR and still make some final changes to your code, so don't wait until the last minute.

We ask you and your team members to list specific areas of feedback for instructors. Please be specific about files and lines of code. Please do not give an answer vague, like "testing"! Thank you!

## What Instructors Are Looking For
Check out the [feedback template](feedback.md) which lists the items instructors will be looking for as they evaluate your project.
