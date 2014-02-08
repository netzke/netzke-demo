This is the source-code for [http://netzke-demo.herokuapp.com](http://netzke-demo.herokuapp.com) - the official [Netzke](http://netzke.org) demo.

## To run locally

1. Get the code from github

    $ git clone git://github.com/netzke/netzke-demo.git && cd netzke-demo

2. Install required gems

    $ bundle install

3. Create your config/database.yml or use the included database.yml.sample (postgres)

4. Create the database, do the migrations, and seed the demo data

    $ rake db:create && rake db:migrate && rake db:seed

## Dependencies

* Rails ~> 4.0.0
* Ext JS ~> 4.2.0
* Netzke Core/Basepack ~> 0.10.0

## Feedback

Google groups: http://groups.google.com/group/netzke

Twitter: http://twitter.com/netzke

Author's twitter: http://twitter.com/uptomax
