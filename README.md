# YNAB Privacy Linker

Automatically import transactions when you make purchases 



## Deploying to Heroku

_Note: this steps are for refernce only, you do not need to do these_

After you have created a heroku app correctly and have the heroku-cli:


### Add the right buildpacks to use webpacker + rails

```bash
heroku buildpacks:clear
heroku buildpacks:add heroku/nodejs
heroku buildpacks:add heroku/ruby
```

### Add the environment variables needed

```bash
heroku config:set RAILS_MASTER_KEY=<key in /config/maskter.key>
figaro heroku:set -a <heroku-app-name>
```
