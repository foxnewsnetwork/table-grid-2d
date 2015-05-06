`import gridMaker from 'table-grid-2d/utils/grid-maker'`
`import { module, test } from 'qunit'`

module 'gridMaker'

product = (xs, ys) ->
  xs.reduce ( (arr, x) -> arr.concat ys.map (y) -> [x,y] ), []

cellularize = ([colName, rowName]) ->
  colName: colName
  rowName: rowName
  id: "#{colName}-#{rowName}"

consoleDrawTable = (colNames, rows) ->
  console.log "The below should look like a spreadsheet table"
  console.log " # | " + colNames.join("  |  ")
  rows.forEach (row) ->
    console.log row.toString()

noOdds = ([colName, rowName]) ->
  return true if colName % 2 is 0

# Replace this with your real tests.
test 'it is there', (assert) ->
  assert.ok gridMaker

test 'product', (assert) ->
  actual = product [1,2], "abc".split("")
  expected = [[1,"a"], [1,"b"], [1,"c"], [2,"a"], [2,"b"],[2, "c"]]
  assert.deepEqual actual, expected

test 'it works', (assert) ->
  colNames = [1..5]
  rowNames = "abcdefg".split ""
  cells = product(colNames, rowNames).map cellularize
  gridMaker data: cells, colNames: colNames, rowNames: rowNames
  .then (rows) ->
    consoleDrawTable colNames, rows
    assert.equal rows.length, 7

test 'it should properly reflect missing cells', (assert) ->
  colNames = [1..5]
  rowNames = "abcdefg".split ""
  cells = product(colNames, rowNames)
  .filter noOdds
  .map cellularize
  gridMaker data: cells, colNames: colNames, rowNames: rowNames
  .then (rows) ->
    consoleDrawTable colNames, rows
    assert.equal rows.length, 7  