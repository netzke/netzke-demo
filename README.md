This is the source-code for [http://netzke-demo.herokuapp.com](http://netzke-demo.herokuapp.com) - the [Netzke](http://netzke.org) live-demo.

## Installation (to run it locally)

1. Get the code from github

    git clone git://github.com/nomadcoder/netzke-demo.git && cd netzke-demo

2. Install required gems

    bundle install

3. Create the database and do the migrations

    rake db:create && rake db:migrate

That's it. Additionally, you can (re)generate test data by visiting the following URL (it's linked at the end of the GridPanel demo page):

    http://localhost:3000/grid_panel/regenerate_test_data

## Prerequisites

* Rails ~> 3.2.0
* Ext JS ~> 4.1

## Feedback

Google groups:
http://groups.google.com/group/netzke

Twitter:
http://twitter.com/netzke

Author's twitter:
http://twitter.com/nomadcoder
