function VarDump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
           if type(k) ~= 'number' then k = '"'..k..'"' end
           s = s .. '['..k..'] = ' .. VarDump(v) .. ','
        end
        return s .. '} '
     else
        return tostring(o)
     end
end

function SimpleVarDump(o)
   if type(o) == 'table' then
      for k,v in pairs(o) do
         print(k)
      end
   else 
      print(tostring(o))
   end
   
end