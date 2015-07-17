--[[
Copyright (C) 2013  simplex

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]--



function Capitalize(s)
	-- The extra parentheses are to trim the return list to 1 return value.
	return (s:lower():gsub(
		'^(%w)',
		string.upper
	):gsub(
		'(%s%w)',
		string.upper
	))
end

capitalize = Capitalize


BindModule 'string'

return _M
