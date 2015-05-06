`import Ember from 'ember'`
`import DS from 'ember-data'`
`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'table-grid-2d', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
}

test 'it renders', (assert) ->
  assert.expect 2

  # creates the component instance
  component = @subject()
  assert.equal component._state, 'preRender'

  # renders the component to the page
  @render()
  assert.equal component._state, 'inDOM'


DelayedModel = Ember.Object.extend
  fireProxy: null
  colName: Ember.computed.alias "fireProxy.colName"
  rowName: Ember.computed.alias "fireProxy.rowName"

wait = (time, action) ->
  new Ember.RSVP.Promise (resolve) ->
    Ember.run.later null, (-> resolve action()), time

makeDelayedObj = (n) ->
  fireProxy = wait 5, ->
    Ember.Object.create 
      colName: 'apple'
      rowName: n
  DelayedModel.create fireProxy: fireProxy

test 'delayed objects', (assert) ->
  data = Ember.A [ makeDelayedObj(41), makeDelayedObj(42), makeDelayedObj(43), makeDelayedObj(44)]
  wait 50, ->
    data.map (obj) ->
      obj.get("fireProxy").then (fp) ->
        assert.equal fp.get("colName"), 'apple', 'roughly should have values'

test 'given a dataset that is highly delayed, it should still work', (assert) ->
  data = Ember.A [ makeDelayedObj(41), makeDelayedObj(42), makeDelayedObj(43), makeDelayedObj(44)]
  component = @subject()
  component.set "rowNames", Ember.A ['apple', 'berry', 'cherry']
  component.set "colNames", Ember.A [41,42,43,44]
  component.set "data", data
  @render()

  assert.equal component._state, 'inDOM'
  wait 100, ->
    cells = Ember.A []
    rows = component.get("rows")
    assert.ok rows, "there should some rows of stuff"
    assert.equal rows.length, 3
    rows.map (row) ->
      assert.ok row, "each row should be ok"
      assert.ok row.cells, "each row should have cells"
      assert.equal row.cells.get("length"), 4, "each row should have 4 cells"
      console.log row.toString()
    

          
