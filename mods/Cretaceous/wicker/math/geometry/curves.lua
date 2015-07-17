---
-- @description Implements curve-related classes and functions.
-- @author simplex


local Lambda = wickerrequire 'paradigms.functional'
local Pred = wickerrequire 'lib.predicates'
local Algo = wickerrequire "utils.algo"

local MathCommon = wickerrequire "math.common"
local Common = pkgrequire "common"
local VVF = Common.VectorValuedFunction

local C = wickerrequire "math.complex"

Curve = Class(function(self, fn, length)
	assert( Lambda.IsFunctional(fn) )
	assert( Pred.IsNonNegativeNumber(length) )
	self.fn = fn
	self.length = length
end)
local Curve = Curve
Pred.IsCurve = Pred.IsInstanceOf(Curve)


function Curve:__call(t)
	return self.fn(t)
end

function Singleton(x)
	return Curve(Lambda.Constant(x), 0)
end
local Singleton = Singleton
Constant = Singleton

Origin = Singleton(Point(0, 0, 0))

function Curve:FlipYZ()
	local fn = self.fn
	return Curve(function(t)
		local pt = fn(t)
		pt.y, pt.z = pt.z, pt.y
		return pt
	end, self.length)
end

-- Concatenates two curves.
local function concatenate_two(alpha, beta)
	local a_fn, b_fn = alpha.fn, beta.fn

	local L_a, L_b = alpha.length, beta.length
	local totalL = L_a + L_b

	local l_a, l_b = L_a/totalL, L_b/totalL
	local invl_a, invl_b = 1/l_a, 1/l_b

	return Curve(function(t)
		if t < l_a then
			return a_fn(invl_a*t)
		else
			return b_fn(invl_b*(t - l_a))
		end
	end, totalL)
end

-- Concatenates a list of curves.
local function concatenate_many(t)
	local n = #t

	-- list of curve functions
	local fns = {}
	-- list of curve lengths
	local Ls = {}
	-- total length
	local totalL = 0

	for i, gamma in ipairs(t) do
		fns[i] = gamma.fn
		local L = gamma.length
		Ls[i] = L
		totalL = totalL + L
	end

	-- invls[i] is the total length divided by the ith length.
	local invls = {}
	-- proportion_until[i] is a number in [0, 1] indicating how much
	-- the sum of lengths from curves 1 to i-1 contributes to the total
	-- length.
	local proportion_until = {0}

	for i, L in ipairs(Ls) do
		local l = L/totalL
		invls[i] = 1/l
		proportion_until[i + 1] = proportion_until[i] + l
	end
	proportion_until[#proportion_until] = nil

	--[[
	-- Given the parameter t, returns the index of the composing function in
	-- which it falls.
	--]]
	local curve_finder = Lambda.Compose( Lambda.ThirdOf, Algo.BinarySearcher(proportion_until, nil, true) )

	return Curve(function(t)
		local i = assert( curve_finder(t) )
		return fns[i]( (t - proportion_until[i])*invls[i] )
	end, totalL)
end

function Curve.Concatenate(...)
	local t = {...}
	local n = #t

	if n == 1 and type(t[1]) == "table" and not Pred.IsObject(t[1]) then
		t = t[1]
		n = #t
	end

	if n == 2 then
		return concatenate_two(t[1], t[2])
	elseif n == 1 then
		return t[1]
	elseif n == 0 then
		return Origin
	else
		return concatenate_many(t)
	end
end
Curve.__concat = concatenate_two
Concatenate = Curve.Concatenate

function Curve:Length(t)
	return self.length*(t or 1)
end

function Curve:Invert()
	local fn = self.fn
	return Curve(function(t)
		return fn(1 - t)
	end, self.length)
end

local private_pow = MathCommon.FastExponentiator(concatenate_two)
function Curve:__pow(n)
	if n == 0 then
		return Singleton(self.fn(0))
	else
		assert( n == math.floor(n) )
		if n > 0 then
			return private_pow(self, n)
		else
			return private_pow(self, n):Invert()
		end
	end
end

function Curve.__add(alpha, v)
	local fn
	fn, alpha = VVF.Transpose(alpha, v)
	return Curve(fn, alpha.length)
end

function Curve.__mul(alpha, lambda)
	local fn
	fn, alpha, lambda = VVF.Scale(alpha, lambda)
	return Curve(fn, alpha.length*lambda)
end

function Curve:__tostring()
	return ("curve from %s to %s"):format(tostring(self(0)), tostring(self(1)))
end


-----------------------------------------------


function LineSegment(a, b)
	if type(a) == "number" then
		length = math.abs(b - a)
	else
		length = a:Dist(b)
	end

	local v = b - a
	return Curve(function(t)
		return a + v*t
	end, length)
end

function CircularArc(radius, theta, theta0)
	radius = radius or 1
	theta = theta or 2*math.pi
	theta0 = theta0 or 0
	return Curve(function(t)
		local delta = theta*t + theta0
		return C.Polar(radius, delta)
	end, math.abs(theta)*radius)
end

function Circle(radius, theta0)
	return CircularArc(radius, 2*math.pi, theta0)
end

UnitCircle = Circle(1)

-- table of points
function PolygonalPathFromTable(t)
	local segs = {}
	for i = 1, #t - 1 do
		segs[i] = LineSegment(t[i], t[i + 1])
	end
	return Curve.Concatenate(segs)
end

function ClosedPolygonalPathFromTable(t)
	local u = {}
	for i, v in ipairs(t) do
		u[i] = v
	end
	u[#u + 1] = t[1]
	return PolygonalPathFromTable(u)
end

function PolygonalPath(...)
	return PolygonalPathFromTable {...}
end

function ClosedPolygonalPath(...)
	return ClosedPolygonalPathFromTable {...}
end

--[[
-- FIXME: not necessarily passing through A and B due to the vertical projection.
--
-- Circular arc connecting P to Q along a plane perpendicular to the ground.
--
-- There's a lot of math in the formulas used here, but just simple math
-- (planar geometry, with a tiny bit of linear algebra).
-- It can be derived from the equations:
-- r cos(theta/2) = r - h
-- r sin(theta/2) = d/2
--
-- Where d is the distance between the two points and h is the height. This
-- has a proper solution if and only if h <= d/2. The solution theta is not
-- being directly used.
--
-- @param P The origin point.
-- @param Q The destination point.
-- @param max_height (optional) Maximum height relative to the line connecting P and Q.
--]]
function CircularPathConnecting(P, Q, max_height)
	assert( Pred.IsPoint(P) )
	assert( Pred.IsPoint(Q) )
	max_height = max_height or 2
	assert( Pred.IsPositiveNumber(max_height) )

	local Q_to_P = P - Q

	local d = Q_to_P:Length()
	if d < 0.001 then
		return Singleton(Q)
	end

	local h = math.max(max_height , d/2 - 0.05)

	local r = (d*d)/(8*h) + h/2
	assert( r >= h )

	local theta = 2*math.acos(1 - h/r)
	assert( 0 <= theta and theta <= math.pi )

	-- New "horizontal" basis element.
	local e1 = Q_to_P/d
	-- New "vertical" basis element.
	local e2
	do
		local old_e2 = Vector3(0, 1, 0)
		-- Gram–Schmidt
		e2 = old_e2 - old_e2:Dot(e1)*e1
		if e2:LengthSq() < 1e-6 then
			e2 = Vector3(0, 0, 0)
		else
			e2:Normalize()
		end
	end

	assert( math.abs(e1:Dot(e2)) < 0.05 )


	local new_origin = (P + Q)/2 + e2*(-(r - h))


	local angle_to_P = math.asin(P:Dot(e2)/r)

	
	local canon_curve = CircularArc(r, theta, angle_to_P)
	local canon_fn = canon_curve.fn
	
	return Curve(function(t)
		local canon_pt = canon_fn(t)
		return new_origin + e1*canon_pt.x + e2*canon_pt.z
	end, canon_curve.length)
end
