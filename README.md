node-project-boilerplate
========================

Minimal [node.js](http://nodejs.org/) project structure boilerplate:

* Uses the [grunt](http://gruntjs.com/) task runner to drive the build, test and distribute.
* Includes the [mocha](http://visionmedia.github.io/mocha/) test framework, without any fancy assertion libraries.
* Suggests a source, build and distribution directory layout:
  * CoffeeScript and JavaScript sources under `src/`.
  * Tests under `test/`.
  * Build into `build/`.
  * Distribute into `lib/`.
* Suggests a source control regimen:
  * The repository contains the source, so it includes `src/` and `test/`.
  * The package contains the distribution, so it includes `lib/`.

This boilerplate makes as few framework decisions as possible. As it is, selecting mocha is a compromise. Without
choosing a test framework, it's not possible to demonstrate where testing fits into the build and distribution
strategy, or how to adjust module.paths to allow require statements to appear in tests as they would in client code.

The default grunt task cleans, builds, distributes and tests. The test is a simple truth test that can be deleted
once the task has been proven to work.

The boilerplate supports the following ramp up style:

```
git clone https://github.com/sheldonh/node-project-boilerplate.git
cd node-project-boilerplate
npm install -g grunt-cli
npm install
grunt
```

That should produce output like that ends with something like this:

```
Running "mochaTest:test" (mochaTest) task
1..1
ok 1 theTruth is true
# tests 1
# pass 1
# fail 0
```

The Gruntfile still needs work to make it really easy to extend for things like stitching (for example, minification
in a web application).