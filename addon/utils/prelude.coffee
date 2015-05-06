`import Ember from 'ember'`

promiseLift = (x) ->
  return x if x? and typeof x.then is 'function'
  new Ember.RSVP.Promise (resolve) -> resolve x

zipCore = (ax, ay) ->
  [x, xs...] = ax
  [y, ys...] = ay
  return [] if Ember.isBlank(ax) and Ember.isBlank(ay)
  [[x,y]].concat zip xs, ys

zip = (xs, ys) ->
  Ember.A zipCore xs, ys

promiseFilterBy = (xs, key, expectedValue) ->
  asyncMapBy xs, key  
  .then (actualValues) ->
    zip xs, actualValues
    .filter ([_, actualValue]) -> actualValue is expectedValue
    .map ([x, _]) -> x

asyncMapBy = (xs, field) ->
  asyncMap xs, (x) -> Ember.get x, field

asyncMap = (xs, mapper) ->
  promises = Ember.A xs
  .map mapper
  .map promiseLift
  Ember.RSVP.all promises

reduceBuild = (xs, reducer) ->
  xs.reduce reducer, {}

wait = (time, action) ->
  new Ember.RSVP.Promise (resolve) ->
    Ember.run.later null, (-> resolve action()), time

lll = (x) ->
  console.log x
  x

class Prelude
  @zip = zip
  @promiseFilterBy = promiseFilterBy
  @promiseLift = promiseLift
  @asyncMapBy = asyncMapBy
  @asyncMap = asyncMap
  @reduceBuild = reduceBuild
  @lll = lll
  @wait = wait

`export default Prelude`
`export {
  promiseLift,
  zip,
  promiseFilterBy,
  lll,
  reduceBuild,
  asyncMapBy,
  asyncMap,
  Prelude,
  wait
}`