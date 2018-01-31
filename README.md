# Rails Coding Challenge #

*Miles Zimmerman*

## Steps ##
(if using gemsets)

1. ```gem install bundler```
2. ```bundle install```

## Test ##
1. ```bundle exec rake```

The cuboid code is written in a way that the main guts can be pulled out into a module or parent class, depending on the needs, to work with any dimensional polyhedron.

Additionally, I have baked in an assumption that the magnitude of the cuboid vectors (named dimensions here) are always positive integers. The code is not intended to handle more robust checking, as a lot of that code is unnecessary in a business environment as one would not re-write commonly and rigorously known and tested collision or polyhedron algorithms in general. Those can be found in physics engines or game libraries or textbooks or the web.

If I were to implement the bin packing problem in a business environment I would utilize more sophisticated combinatorial optimization and/or matching algorithms depending on the requirements. The code here should suffice for the purposes of this coding challenge, however.

Thanks!

- Miles
