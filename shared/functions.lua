-- Apply filter to table
table.filter = function(t, filterIter)
	local out = {}

	for k, v in pairs(t) do
		if filterIter(v, k, t) then table.insert(out, v) end
	end

	return out
end

-- If the default case does not have to be handled, we can use the following auxiliary function:
function Switch(value)
    -- Handing `cases` to the returned function allows the `switch()` function to be used with a syntax closer to c code (see the example below).
    -- This is because lua allows the parentheses around a table type argument to be omitted if it is the only argument.
    return function(cases)
        local f = cases[value]
        if (f) then
            f()
        end
    end
end
