`import Ember from 'ember'`
`import { promiseFilter, zip, asyncMapBy, reduceBuild, lll, asyncMap } from './prelude'`

get = Ember.get
colNameKey = "colName"
rowNameKey = "rowName"

class Row
  @named = (name) ->
    new Row(name)

  constructor: (@rowName) ->

  inOrderOf: (@colNames) -> @

  withItems: (itemsPromise) ->
    itemsPromise.then (items) =>
      @assignInOrder items
    .then (cells) =>
      @cells = Ember.A cells
      @

  toString: ->
    content = @cells
    .map (cell) -> if cell? then cell.id else "null"
    .join(" | ")
    @rowName + " | " + content

  assignInOrder: (items) ->
    @buildColNameHash items
    .then (hash) =>
      @colNames.map (colName) -> hash[colName]

  buildColNameHash: (items) ->
    asyncMapBy items, colNameKey
    .then (colNames) ->
      zip items, colNames
    .then (namesNItems) ->
      reduceBuild namesNItems, (hash, [item, colName]) ->
        hash[colName] = item
        hash

rowFilter = (expectedRowName, xs) ->
  promiseFilter xs, (x) ->
    "#{get x, rowNameKey}".trim() is "#{expectedRowName}".trim()

gridMaker = (data: xs, colNames: colNames, rowNames: rowNames) ->
  asyncMap rowNames, (rowName) ->
    Row.named(rowName).inOrderOf(colNames).withItems rowFilter rowName, xs

`export default gridMaker`