# Table-grid-2d

Generates a spreadsheet-like table grid for representating junk that's naturally spreadsheet-like

# HowTo
Suppose you have the following declared variables in your controller

```coffee
colNames = ["gulag", "potato", "latvia", "cold"]
rowNames = [1..4]
comrades = []
comrades.push colName: "gulag", rowName: 1, id: "Mikhail"
comrades.push colName: "potato", rowName: 4, id: "Yuri"
comrades.push colName: "cold", rowName: 2, id: "Danil"
```
And you wanted your comrades in sort of bingo-grid spreadsheet table, do the following:

```handlebars
{{#table-grid-2d colNames=colNames rowNames=rowNames data=comrades originLabel="☭" action="cellTouched" as |comrade|}}
  <span>{{comrade.id}}</span>
{{/table-grid-2d}}
```

to get:

| ☭ | gulag | potato | latvia | cold |
|---|-------|--------|--------|------|
| 1 |Mikahil|        |        |      |
| 2 |       |        |        |Danil |
| 3 |       |        |        |      |
| 4 |       |  Yuri  |        |      |

## Notes
Yes, for now, all comrades must have a colName and rowName property. Sorry, perhaps in the future I will make this customizeable

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
