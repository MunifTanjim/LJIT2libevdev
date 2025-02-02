--[[
    get a keyboard, and track it
--]]
package.path = package.path .. ";../?.lua"

local EVContext = require("EVContext")

local dev = EVContext:getKeyboard()

assert(dev, "no keyboard found")

print(string.format('Input device name: "%s"', dev:name()))
print(
  string.format("Input device ID: bus %#x vendor %#x product %#x\n", dev:busType(), dev:vendorId(), dev:productId())
)

-- print out a constant stream of events
for _, ev in dev:events() do
  if ev:typeName() == "EV_KEY" then
    print(string.format("{KEY = '%s', PRESSED = %s},", ev:codeName(), tostring(ev:value() == 1)))
  end
end
