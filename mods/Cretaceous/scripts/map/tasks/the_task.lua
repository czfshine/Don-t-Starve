require 'map/tasks'

AddTask("The_Task",{
    locks=LOCKS.NONE,
    keys_given=KEYS.NONE,
    
    room_choices={
      ["The_Room"]=1
      },
    
    room_bg=GROUND.SAVANNA,
    
    background_room="The_Room",
    colour={b=0,r=0,g=0,a=0},
  })

    
    