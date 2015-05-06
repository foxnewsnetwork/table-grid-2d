`import Ember from 'ember'`
`import gridMaker from '../utils/grid-maker'`

TableGrid2dComponent = Ember.Component.extend
  tagName: "table"
  classNames: ["table-grid-2d"]
  originLabel: "#"

  rowsPromise: Ember.computed "data.@each.colName", "data.@each.colName", "rowNames.@each", "colNames.@each", ->
    return if Ember.isBlank @get "data"
    gridMaker data: @get("data"), colNames: @get("colNames"), rowNames: @get("rowNames")
    .then (rows) =>
      @set "rows", Ember.A rows

  actions:
    touch: (cell) ->
      @sendAction 'action', cell

`export default TableGrid2dComponent`
