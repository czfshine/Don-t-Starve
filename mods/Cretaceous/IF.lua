KEY_ALT=true 
KEY_CTRL=false
KEY_SHIFT=false

function AddKeyClick(key,fn)
  
  local has_alt,has_ctrl,has_shift,thekey
  
  if type(key)=="table" then 
    if key.key then 
      thekey=key.key
      has_alt=key.alt
      has_ctrl=key.ctrl
      has_shift=key.shift 
    else 
      has_alt=key[1]
      has_ctrl=key[2]
      has_shift=key[3]
      thekey=key[4]
    end
  elseif type(key)=="number" and key < 10000 then 
      thekey=key%1000
      has_alt= key >= 4000
      local two=math.floor(key/1000)
      has_ctrl= two==2 or two==3 or two==6 or two==7 
      has_shift= two==1 or two==3 or two==5 or two==7 
  elseif type(key)=="number" then 
    thekey=key%1000
    has_alt  =math.floor(key/1000)%10 == 1
    has_ctrl =math.floor(key/10000)%10 == 1
    has_shift=math.floor(key/100000)%10 == 1
  end
  
  if thekey and thekey>0 then 
    
    print(KEY_ALT,KEY_CTRL,KEY_SHIFT)
    print(has_alt,has_ctrl,has_shift,thekey)
    
    Add(thekey,function ()
        
        if not (
            (has_alt and (not KEY_ALT ))
            or  (has_ctrl and (not KEY_CTRL) )
            or (has_shift and (not KEY_SHIFT)) )then
            
            fn()
        end
    end)
  end
end



function Add(key,lfn)
  lfn()
end

AddKeyClick(4001,function () print(1) end)


