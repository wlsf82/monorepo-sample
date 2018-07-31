const test = require("tape");

test("foo", t => {
    t.plan(1);
    t.equal(true, true);
});

test("foo 2", t => {
    t.plan(1);
    t.equal(false, false);
});
