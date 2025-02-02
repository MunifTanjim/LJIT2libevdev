local ffi = require("ffi")

local function octal(value)
  return tonumber(value, 8)
end

ffi.cdef([[
int printf(const char *__restrict, ...);
int open(const char *, int, ...);
extern char *strerror (int __errnum);
]])

local exports = {
  -- Constants
  O_NONBLOCK = octal("04000"),
  O_RDONLY = 00,
  O_WRONLY = 01,
  O_RDWR = 02,

  EAGAIN = 11,

  -- library functions
  open = ffi.C.open,
  printf = ffi.C.printf,
  strerror = ffi.C.strerror,
}

setmetatable(exports, {
  __call = function(self, tbl)
    tbl = tbl or _G
    for k, v in pairs(self) do
      tbl[k] = v
    end
    return self
  end,
})

return exports
