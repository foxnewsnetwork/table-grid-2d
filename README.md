# Weird bug branch

This is the default setup after you run:

```bash
ember addon my-addon-name
```

All I did was go into dummy/app/controllers/application.js and add:

```javascript
// tests/dummy/app/controllers/application.js
import Ember from 'ember';

export default Ember.Controller.extend({
  colNames: "abcdefg".split("")
});
```

and
```handlebars
<!-- tests/dummy/app/templates/application.hbs -->
<h2 id="title">Welcome to Ember.js</h2>

<ul>
  {{#each colName in colNames}}
    <li>{{colName}}</li>
  {{/each}}
</ul>
```

I then ran:
```bash
ember serve
```
Everything built, but upon visiting localhost:4200

I am greeted with the following error:

```
Uncaught Error: Assertion Failed: The value that #each loops over must be an Array. You passed [a,b,c,d,e,f,g] 
```
Somehow, arrays aren't passing each's array assertion. 

This bug doesn't exist in regular ember apps despite my many attempts to reproduce on codepen:

http://codepen.io/foxnewsnetwork/pen/wBZKzx?editors=101

# Table-grid-2d

Generates a spreadsheet-like table grid for representating junk that's naturally spreadsheet-like

```emblem
table-grid-2d colNames=colNames rowNames=rowNames data=warehouses cellKey="coordinate" action="cellTouched"
```

## Installation

* `git clone` this repository
* `npm install`
* `bower install`

## Running

* `ember server`
* Visit your app at http://localhost:4200.

## Running Tests

* `ember test`
* `ember test --server`

## Building

* `ember build`

For more information on using ember-cli, visit [http://www.ember-cli.com/](http://www.ember-cli.com/).
