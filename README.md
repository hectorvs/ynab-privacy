# YNAB Privacy Linker

Utilizes the YNAB API as well as the Privacy.com API to automatically import transactions into YNAB the moment they happen!

Deployment of the app can be found at: https://ynab-privacy.herokuapp.com

With the app you can browse your YNAB budgets, select the category and link which Privacy.com virtual cards to 'listen' for transactions.

When a transaction happens using one of the Privacy.com cards, Privacy will POST the transaction to a webhook in this app, which will then look up the created card link and automatically import the transaction into YNAB to the budget and category specified.

_Disclaimer: this is a proof of concept project! use at your own risk_

### Usage Instructions

#### Pre-usage steps:
1. Create a [Privacy.com](https://privacy.com/) account
2. In Privacy.com Account Settings:
    1. Enable Privacy API
    1. Generate an API key - Copy it somewhere
    1. Enable Authorization Event Web hook with the following url:
    - `https://ynab-privacy.herokuapp.com/privacy/transactions`
3. Add funding source 
    - make sure this account is tracked in YNAB
4. Generate as many virtual cards in Privacy.com as needed
    - Once you use a card, it will be locked to merchant (name it something relevant like Nintendo eShop)
    - It's recommended not so use 'burner' cards so the links can persist.
    - More information about how Privacy.com works in their [FAQ](https://privacy.com/faq)

#### YNAB Privacy Linker Usage Steps:
1. Log in to  https://ynab-privacy.herokuapp.com/  using YNAB by pressing the "Sign in to YNAB button"
2. Click on "Add Privacy Access Token" and use the API key generated in the previous step. Save.
3. Click on "Build Budget Links" to start building Card Links :)

#### Building a Card Link
1. Select YNAB Budget
2. Select Account tracked YNAB used to fund Privacy.com cards
3. Select Category to automatically import transactions to, example: Fun Money
4. Select the card(s) you want to automatically import transactions from.
5. Create!

After creating links, click on the 'Existing Card Links' tab to manage them.

_NOTE: A Card can only be linked in one Category, however a Category can have multiple linked Cards._

## Development Details

This app was developed using a Rails backend and an Angular frontend. I used the `rails/webpacker` gem to run the JS frontend within the Rails Application.

The (Privacy.com API)[https://developer.privacy.com] is very much a work in progress and might change without warning at any time. 

Future functionality will include creating virtual cards and rejecting transactions using the authorization endpoint.

This gives the YNAB Privacy Linker app a ton of potential functionality, like create a card on the fly within the app, or create a setting to reject a transaction if the amount exceeds the allocated budget for the linked category.

The app is deployed in heroku.


### Deploying to Heroku

_Note: this steps are for refernce only, you do not need to do these_

After you have created a heroku app correctly and have the heroku-cli:

#### Add the right buildpacks to use webpacker + rails

```bash
heroku buildpacks:clear
heroku buildpacks:add heroku/nodejs
heroku buildpacks:add heroku/ruby
```

#### Add the environment variables needed

```bash
heroku config:set RAILS_MASTER_KEY=<key in /config/maskter.key>
figaro heroku:set -a <heroku-app-name>
```

#### Deploy
`git push heroku master`

Feel free to open an issue in the repo any questions or problems you might encounter.

Again, this is a proof of concept app and should be used at your own risk.
