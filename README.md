This is the source-code for http://demo.netzke.org - the [Netzke](http://netzke.org) live-demo.

## Installation (to run it locally)

1. Get the code from github

    git clone git://github.com/skozlov/netzke-demo.git && cd netzke-demo

2. Checkout or symlink Netzke gems (Core, Basepack, and Persistence) into vendor/gems

    git clone git://github.com/skozlov/netzke-core.git vendor/gems/netzke-core
    git clone git://github.com/skozlov/netzke-basepack.git vendor/gems/netzke-basepack
    git clone git://github.com/skozlov/netzke-persistence.git vendor/gems/netzke-persistence

3. Install required gems

    bundle

4. Link your copy of Ext JS library into `public` as `extjs`.

    ln -s ~/code/sencha/ext-4.0.0 public/extjs

5. Create the database and do the migrations

    rake db:create && rake db:migrate

That's it. Additionally, you can (re)generate test data by visiting the following URL (it's linked at the end of the GridPanel demo page):

    http://localhost:3000/grid_panel/regenerate_test_data

## Prerequisites

* Rails ~> 3.0
* Ext JS ~> 4.0

## Feedback

Google groups:
http://groups.google.com/group/netzke

Twitter:
http://twitter.com/netzke

Author's twitter:
http://twitter.com/nomadcoder