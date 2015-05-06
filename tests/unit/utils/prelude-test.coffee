`import Prelude from 'table-grid-2d/utils/prelude'`
`import { module, test } from 'qunit'`

module 'Prelude'

test 'it loads', (assert) ->
  assert.ok Prelude,
  assert.ok Prelude.zip
  assert.ok Prelude.promiseFilterBy
  assert.ok Prelude.promiseLift
  assert.ok Prelude.asyncMapBy
  assert.ok Prelude.asyncMap
  assert.ok Prelude.reduceBuild
  assert.ok Prelude.lll

test 'zip normal', (assert) ->
  actual = Prelude.zip [1,2,3], ['a','b','c']
  expected = Ember.A [
    [1, 'a'],
    [2, 'b'],
    [3, 'c']
  ]
  assert.deepEqual actual, expected

test 'zip uneven', (assert) ->
  actual = Prelude.zip [1,2,3], ['a','b','c','d']
  expected = Ember.A [
    [1, 'a'],
    [2, 'b'],
    [3, 'c'],
    [undefined, 'd']
  ]
  assert.deepEqual actual, expected

test 'promiseFilterBy', (assert) ->
  makeObject = (name) ->
    Ember.Object.create
      name: Prelude.wait 5, -> name
  objects = [makeObject('doug'), makeObject('rover'), makeObject('spot')]
  Prelude.promiseFilterBy objects, "name", "rover"
  .then (objects) ->
    assert.ok objects, "filter should return an array"
    assert.equal objects.length, 1, "the array should have correct length"
    assert.ok objects[0], "the array should have contents"
    objects[0].get("name").then (name) ->
      assert.equal name, "rover"