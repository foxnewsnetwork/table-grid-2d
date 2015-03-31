`import Ember from 'ember'`

zip = ([x,xs...], [y,ys...]) ->
  return [] unless x? and y?
  [[x,y]].concat zip xs, ys

objectify = ([colName, rowName]) ->
  colName: colName
  rowName: rowName
  id: [colName, rowName].join("-")

ApplicationController = Ember.Controller.extend
  rowNames: [1..6]
  colNames: "abcdefg".split("")
  data: Ember.computed "rowNames.@each", "colNames.@each", ->
    colNames = @get "colNames"
    rowNames = @get "rowNames"
    zip(colNames, rowNames).map objectify

`export default ApplicationController`