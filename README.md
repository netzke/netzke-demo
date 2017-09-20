This is the source-code for [http://demo.netzke.org](http://demo.netzke.org) - the official [Netzke](http://netzke.org) demo.

The cutting-edge version (updated directly from master) is [here](http://edgedemo.netzke.org).

## To run locally

1. Get the code from github

    $ git clone git://github.com/netzke/netzke-demo.git && cd netzke-demo

2. Install required gems

    $ bundle install

3. Create your config/database.yml or use the included database.yml.sample (postgres)

4. Create the database, do the migrations, and seed the demo data

    $ rake db:create && rake db:migrate && rake db:seed

5. Symlink your Ext JS folder to `public/extjs`, e.g.:

    $ ln -s PATH/TO/YOUR/EXTJS/FILES public/extjs

## Dependencies

* Rails ~> 5.1.0
* Ext JS = 6.5.1
* Netzke = 6.5.0.0

## Feedback

Twitter: http://twitter.com/netzke

Author's twitter: http://twitter.com/mxgrn

Google groups: http://groups.google.com/group/netzke

---
Copyright (c) 2009-2017 [Good Bit Labs](http://goodbitlabs.com/), released under the same license as [Ext JS](https://www.sencha.com/legal/#Sencha_Ext_JS)
