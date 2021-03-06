-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local string = require "string"
local util = require "lsb.util"

local function alpha()
    return {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
            "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
            "w", "x", "y", "z"}
end

local function behead_array()
    local a = alpha()
    util.behead_array(10, a)
    assert(a[1] == "j", string.format("a[1] should be 'j', is '%s'", tostring(a[1])))
    assert(#a == 17, string.format("#a should be 17, is %d", #a))

    a = alpha()
    util.behead_array(16, a)
    assert(a[1] == "p", string.format("a[1] should be 'p', is '%s'", tostring(a[1])))
    assert(#a == 11, string.format("#a should be 11, is %d", #a))

    a = alpha()
    util.behead_array(0, a)
    assert(a[1] == "a", string.format("a[1] should be 'a', is '%s'", tostring(a[1])))
    assert(#a == 26, string.format("#a should be 26, is %d", #a))

    a = alpha()
    util.behead_array(45, a)
    assert(a[1] == nil, string.format("a[1] should be 'nil', is '%s'", tostring(a[1])))
    assert(#a == 0, string.format("#a should be 0, is %d", #a))
end


local function pairs_by_key()
    local hash = { a = true , b = true, c = true }
    local abc = {"a", "b", "c"}

    local cnt = 1
    for k, v in util.pairs_by_key(hash) do
        assert(abc[cnt] == k)
        cnt = cnt + 1
    end

    cnt = 3
    for k, v in util.pairs_by_key(hash, function(a, b) return a > b end) do
        assert(abc[cnt] == k)
        cnt = cnt - 1
    end
end


local function merge_objects()
    local a = {
        foo = 1,
        bar = {1, 1, 3},
        quux = 3
    }
    local b = {
        foo = 5,
        bar = {0, 0, 5, 1},
        baz = {
            hello = 100
        }
    }

    local c = util.merge_objects(a, b)
    assert(c.foo == 6)
    assert(c.bar[1] == 1)
    assert(c.bar[2] == 1)
    assert(c.bar[3] == 8)
    assert(c.bar[4] == 1)
    assert(c.baz.hello == 100)
    assert(c.quux == 3)
end

behead_array()
pairs_by_key()
merge_objects()
