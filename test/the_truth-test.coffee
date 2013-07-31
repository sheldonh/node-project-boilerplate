assert = require('assert')
module.paths.push('lib')

theTruth = require('the_truth')

describe "theTruth", ->
  it "is true", -> assert.equal theTruth(), true