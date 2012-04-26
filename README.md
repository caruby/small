caSmall: A caTissue web service and application micro-framework
===============================================================

**Home**:         [http://caruby.rubyforge.org/casmall.html](http://caruby.rubyforge.org/casmall.html)    
**Git**:          [http://github.com/caruby/small](http://github.com/caruby/small)       
**Author**:       OHSU Knight Cancer Institute    
**Copyright**:    2012    
**License**:      MIT License    

Synopsis
--------

caSmall is a framework for deploying a caTissue RESTful web service and custom web applications.

Feature List
------------

1. Search, create and update caTissue objects.

2. Leverages the [caRuby](http://caruby.rubyforge.org) declarative API.

Installing
----------
caSmall is installed on a server as a JRuby gem:
    sudo jgem install caruby-small

Usage
-----

Examples:

* Fetch the specimen with identifier 212:

  GET `myserver:9060/casmall/specimen/212`

* Fetch the specimen collection group with SPN <tt>SPN-41873</tt>:

  GET `myserver:9060/casmall/SpecimenCollectionGroup?surgicalPathologyNumber=SPN-41873`

* Fetch specimens based on a submitted JSON criterion template:

  POST `myserver:9060/casmall/query`

* Create a specimen from a submitted JSON object:

  POST `myserver:9060/casmall/`

* Update a specimen from a submitted JSON object:

   PUT `myserver:9060/casmall/`

Copyright
---------

caSmall &copy; 2012 by [Oregon Health & Science University](http://www.ohsu.edu/xd/health/services/cancer/index.cfm).
