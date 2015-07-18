--coding:utf-8
--[[markdown:
prefabs:
=======

plant
------------------
* 小麦（wheat）
 * growtime:15d
 * product:20-40*wheat seeds

* 辣椒（pepper）
 * growtime:15d
 * product:chili*3

* 大豆（beans）
 * growtime:15d
 * product:[3-4]*soybean
  
* 稻谷（paddy）
 * growtime:15d
 * product:1*paddy seeds
  
Materials(m)
---------------------
* 猪肉（pork）
1猪（pig）=1-2块猪肉

Materials(v)
---------------------------
* 茶叶（teas） 
1树枝=4-5片茶叶
  
* 草药（herb-medicine）
* 面团（dough）
 * perishtime:2d
 
* 一袋面粉（flour）
 * perishtime:5d
 
* 一袋大米 （rice）
 * perishtime:24d
 
* wheat seeds
 * perishtime:24d
 * 【有刺】
 
* 辣椒chili
* 大豆soybean
* paddy seeds
 * perishtime:24d
 
food(m)
---------------------------
* 煮鸡蛋（boiled egg）
 * {有暖石的功效}
food(v)
--------------------------
* 干面条(Dry noodles)
 * perishtime:15d
 
* 湿面条（Wet noodles）
 * perishtime:2d

* 粥（Porridge）
 * perishtime:2d

* 米饭（rices）
 * perishtime:3d
* 茶（tea）

cook
====
buhrimill
------------
pre|pro
---|---
10颗小麦种子|一袋面粉（flour）
大豆三个+浓盐水（strong brine）|豆浆soy milk
1稻谷|一袋大米 
      
knife
----------
pre|pro
---|---
面团（dough）|面条（noodle）
猪肉|1肉馅（comminuted meat）
      
hand
-----------------------------------
pre|pro
---|---
面团|馒头（steamed bread）
两袋面粉（flour）+一桶水（water）+一个腐烂物|四个面团（dough）

saucepan
----------------------
pre|pro
---|---
馒头+肉馅（comminuted meat）|包子
面团+肉馅（comminuted meat）|肉饺子（boiled dumpling）
面团+菜馅（Minced vegetables）|素饺子（boiled dumplings）
豆浆soy milk +石头|豆腐（tofu）
一袋大米（rice）+两桶水（water）|粥（Porridge）

一袋大米（rice）+一桶水（water）|米饭（rices）
4-5片茶叶+一桶水|茶
8草药+一桶水|1中药
n鸡蛋（egg）+一桶水|n煮鸡蛋（boiled egg）

club
----------------------------------
pre|pro
---|---
面团|大饼（cake）
   
]]


prefabsdata={
  plant={},
  food={}
}
cookdata={}

local p=prefabsdata.plant
local f=prefabsdata.food
local c= cookdata
p.wheat={
  --start--wheat--
  name="wheat",
  name_zh="小麦",
  lootdropper=true, --掉落
  inspectable=true, --查看
  anim={ --动画
    asset={ --资源
      ANIM={"anim/grass.zip",},
      SOUND={"sound/common.fsb"},
      IMAGE={"image/test.tex"},
      ATLAS={"image/test.xml"},
    },
    Bank="grass",
    Build="grass1",
    animation="idle",
    loop=true,
    color={1,1,1,1}
  },
  minimap={ --小地图
    icon="grass.png",
  },
  pickable={ --采摘
    regen=30*16*15, --时间
    product="wheatseeds", --产物
    numbertoharvest={20,40},--数量
    max_cycles=20, --次数
    cycles_left=20,
    sound="dontstarve/wilson/pickup_reeds",
  },
  workable={ --动作
    action="DIG",
  },
  prefabs={ --生成物
    "wheatseeds"
  },
  MakeSmallPropagator=true,
  MakeNoGrowInWinter=true,
  MakeMediumBurnable=true,
  --end--wheat--
}
p.pepper={
  --start--pepper--
  name="pepper",
  name_zh="辣椒",
  lootdropper=true, --掉落
  inspectable=true, --查看
  anim={ --动画
    asset={ --资源
      ANIM={"anim/grass.zip",},
      SOUND={"sound/common.fsb"},
      IMAGE={"image/test.tex"},
      ATLAS={"image/test.xml"},
    },
    Bank="grass",
    Build="grass1",
    animation="idle",
    loop=true,
    color={1,1,1,1}
  },
  minimap={ --小地图
    icon="grass.png",
  },
  pickable={ --采摘
    regen=30*16*15, --时间
    product="wheatseeds", --产物
    numbertoharvest={20,40},--数量
    max_cycles=20, --次数
    cycles_left=20,
    sound="dontstarve/wilson/pickup_reeds",
  },
  workable={ --动作
    action="DIG",
  },
  prefabs={ --生成物
    "wheatseeds"
  },
  MakeSmallPropagator=true,
  MakeNoGrowInWinter=true,
  MakeMediumBurnable=true,
  --end--wheat--
}
p.beans={
  --start--beans--
  name="beans",
  name_zh="大豆",
  lootdropper=true, --掉落
  inspectable=true, --查看
  anim={ --动画
    asset={ --资源
      ANIM={"anim/grass.zip",},
      SOUND={"sound/common.fsb"},
      IMAGE={"image/test.tex"},
      ATLAS={"image/test.xml"},
    },
    Bank="grass",
    Build="grass1",
    animation="idle",
    loop=true,
    color={1,1,1,1}
  },
  minimap={ --小地图
    icon="grass.png",
  },
  pickable={ --采摘
    regen=30*16*15, --时间
    product="wheatseeds", --产物
    numbertoharvest={20,40},--数量
    max_cycles=20, --次数
    cycles_left=20,
    sound="dontstarve/wilson/pickup_reeds",
  },
  workable={ --动作
    action="DIG",
  },
  prefabs={ --生成物
    "wheatseeds"
  },
  MakeSmallPropagator=true,
  MakeNoGrowInWinter=true,
  MakeMediumBurnable=true,
  --end--wheat--
}
p.paddy={
  --start--wheat--
  name="paddy",
  name_zh="水稻",
  lootdropper=true, --掉落
  inspectable=true, --查看
  anim={ --动画
    asset={ --资源
      ANIM={"anim/grass.zip",},
      SOUND={"sound/common.fsb"},
      IMAGE={"image/test.tex"},
      ATLAS={"image/test.xml"},
    },
    Bank="grass",
    Build="grass1",
    animation="idle",
    loop=true,
    color={1,1,1,1}
  },
  minimap={ --小地图
    icon="grass.png",
  },
  pickable={ --采摘
    regen=30*16*15, --时间
    product="wheatseeds", --产物
    numbertoharvest={20,40},--数量
    max_cycles=20, --次数
    cycles_left=20,
    sound="dontstarve/wilson/pickup_reeds",
  },
  workable={ --动作
    action="DIG",
  },
  prefabs={ --生成物
    "wheatseeds"
  },
  MakeSmallPropagator=true,
  MakeNoGrowInWinter=true,
  MakeMediumBurnable=true,
  --end--wheat--
}

--================food=========================
f.pork={
  --start--
  name="pork",
  name_zh="猪肉",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.pork_dried={
  --start--
  name="pork_dried",
  name_zh="干猪肉",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.cookedpork={
  --start--
  name="cookedpork",
  name_zh="熟猪肉",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
--porkend
f.teas={
  --start--
  name="teas",
  name_zh="茶叶",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.herbmedicine={
  --start--
  name="herbmedicine",
  name_zh="草药",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.dough={
  --start--
  name="dough",
  name_zh="面团",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.flour={
  --start--
  name="flour",
  name_zh="面粉",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.rice={
  --start--
  name="rice",
  name_zh="大米",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.rices={
  --start--
  name="rices",
  name_zh="米饭",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.wheatseeds={
  --start--
  name="wheatseeds",
  name_zh="小麦种子",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.chili={
  --start--
  name="chili",
  name_zh="辣椒",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.soybean={
  --start--
  name="soybean",
  name_zh="大豆",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.paddyseeds={
  --start--
  name="paddyseeds",
  name_zh="水稻种子",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.cookedegg={
  --start--
  name="cookedegg",
  name_zh="煮鸡蛋",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.noodles_dried={
  --start--
  name="noodles_dried",
  name_zh="干面条",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.noodles={
  --start--
  name="noodles",
  name_zh="面条",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.porridge={
  --start--
  name="porridge",
  name_zh="粥",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
f.rices={
  --start--
  name="rices",
  name_zh="米饭",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}

  
  
f.tea={
  --start--
  name="tea",
  name_zh="茶",
  edible={ --可食用
    foodtype="MEAT", --类型
    healthvalue = 10,
    hungervalue = 10,
    sanityvalue = 0,
    stale_hunger = .666,
    stale_health = .5,
    spoiled_hunger = .333,
    spoiled_health = 0,
    
  },
  stackable={
    maxsize=20,--堆叠
  },
  bait=true, --诱饵
  inspectable=true,--检查
  inventoryitem=true,--存放
  tradable={
    goldvalue=3, --交易
  },
  perishable={
    perishTime=30*16*2,--保质期
    onperishreplacement="spoiled_food",--腐败物
  },
  cookable={
    product="cookedpork" --制作
  },
  dryable={
    product="pork_dried",--晒干
    drytime=60*16*2,
  },
  prefabs={
    "pork_dried",
    "cookedpork",
    "spoiled_food"
  },
  anim={
    asset={
      ANIM={"anim/meat.zip"}
    },
    bank="pork",
    build="pork",
    animmation="idle",
    loop=true,
  },
  --end--
}
--=======cooks=============================
--待办
  
    
  
    
  
  
  




