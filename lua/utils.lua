local M = {}

M.concat_kv_tables = function (...)
  local new_tbl = {}
  for _,tbl in ipairs({...}) do
    for k,v in pairs(tbl) do
      new_tbl[k] = v
    end
  end
  return new_tbl
end

return M
