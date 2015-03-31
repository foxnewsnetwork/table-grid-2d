`import Ember from 'ember'`
`import gridMaker from '../utils/grid-maker'`

TableGrid2dComponent = Ember.Component.extend
  tagName: "table"
  classNames: ["table-grid-2d"]

  rows: Ember.computed "data.@each", "rowNames.@each", "colNames.@each", ->
    return if Ember.isBlank @get "data"
    gridMaker data: @get("data"), colNames: @get("colNames"), rowNames: @get("rowNames")

  actions:
    touch: (cell) ->
      @sendAction 'action', cell

`export default TableGrid2dComponent`
