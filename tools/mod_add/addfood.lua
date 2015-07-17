

local modpath="../../mods/Cretaceous/"
local prefabfiles=modpath.."prefabfiles.lua"
local assetsfile=modpath.."assets.lua"



function add2prefabfiles(name)
	local pre=io.open(prefabfiles,"rb")
	local con=pre:read("*a")
	pre:close()

	con=con:gsub("}",function()
	return [[  "]]..name..[[",
}]]
	end)
	print(con)
	io.open(prefabfiles,"wb"):write(con)

end

function add2assetsfile(assetsdata)
	local as=io.open(assetsfile,"rb")
	local con=as:read("*a")
	as:close()

	con=con:gsub("}",function()
		local outstr=""
		local A=assetsdata.ANIM or {}
		local I=assetsdata.IMAGE or {}
		local T=assetsdata.ATLAS or {}

		for _,v in pairs(A) do
			outstr=outstr.."  Asset(\"ANIM\" , \""..v.."\"),\n"
		end
		for _,v in pairs(I) do
			outstr=outstr.."  Asset(\"IMAGE\", \""..v.."\"),\n"
		end
		for _,v in pairs(T) do
			outstr=outstr.."  Asset(\"ATLAS\", \""..v.."\"),\n"
		end

		return outstr.."}"
	end)

	print(con)

	io.open(assetsfile,"wb"):write(con)

end

function addimage(name)

end

function addprefabs(name,assetsdata)

end





--test--
--add2prefabfiles("test")

ad={ANIM={"anim/test.zip"},
	IMAGE={"image/test.tex"},
	ATLAS={"image/test.xml"}
}
--add2assetsfile(ad)
