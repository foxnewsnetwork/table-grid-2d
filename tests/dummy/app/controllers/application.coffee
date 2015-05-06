`import Ember from 'ember'`
`import { zip, wait } from 'table-grid-2d/utils/prelude'`

objectify = ([colName, rowName]) ->
  colName: colName
  rowName: rowName
  id: [colName, rowName].join("-")

remoteObjectify = ([colName, rowName]) ->
  Ember.Object.create
    colName: wait 5, -> colName
    rowName: wait 8, -> rowName
    id: [colName, rowName].join("-")

ApplicationController = Ember.Controller.extend
  badJunk: Ember.A [1..5]
  rowNames: Ember.A [1..6]
  colNames: Ember.A "abcdefg".split("")
  data: Ember.computed "rowNames.@each", "colNames.@each", ->
    colNames = @get "colNames"
    rowNames = @get "rowNames"
    zip(colNames, rowNames).map objectify

  remoteData: Ember.computed "rowNames.@each", "colNames.@each", ->
    colNames = @get "colNames"
    rowNames = @get "rowNames"
    zip(colNames, rowNames).map remoteObjectify    

`export default ApplicationController`