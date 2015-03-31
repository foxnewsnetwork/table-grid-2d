`import Ember from 'ember'`

get = Ember.get
colNameKey = "colName"
rowNameKey = "rowName"
reduceBuild = (xs, reducer) ->
  xs.reduce reducer, {}

class Row
  @named = (name) ->
    new Row(name)

  constructor: (@rowName) ->

  inOrderOf: (@colNames) -> @

  withItems: (items) ->
    @cells = Ember.A @assignInOrder items
    @

  toString: ->
    content = @cells
    .map (cell) -> if cell? then cell.id else "null"
    .join(" | ")
    @rowName + " | " + content

  assignInOrder: (items) ->
    hash = @buildColNameHash items
    @colNames.map (colName) -> hash[colName]

  buildColNameHash: (items) ->
    reduceBuild items, (hash, item) =>
      colName = get item, colNameKey
      hash[colName] = item
      hash

rowFilter = (rowName, xs) ->
  xs.filter (x) -> get(x, rowNameKey) is rowName

gridMaker = (data: xs, colNames: colNames, rowNames: rowNames) ->
  Ember.A rowNames.map (rowName) ->
    Row.named(rowName).inOrderOf(colNames).withItems rowFilter rowName, xs

`export default gridMaker`