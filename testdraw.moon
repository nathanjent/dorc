-- Test drawing
require "dorc"

testObj=
	x:120
	y:68
	state:"idle"
	tic:0
	transcolor:14
	states:
		idle:
			sprt: 256
			framecnt:1
			trans:14
			ox:-2
			oy:-1
			w:2
			h:2

-- mocks of TIC-80 API with assertions
FLGREG=0x14404
export peek=(addr)->
	d=
		[256]:1
	d[addr-FLGREG]

export mget=(x,y)->0

-- Create `spr` method with custom assertion
assertSpr=(assertion)->
	if assertion
		(id,x,y,colorkey,scale,flip,rotate,w,h)->
			assertion id,x,y,colorkey,scale,flip,rotate,w,h
	else
		(id,x,y,colorkey,scale,flip,rotate,w,h)->
			assert x==testObj.x+testObj.states.idle.ox
			assert y==testObj.y+testObj.states.idle.oy
			assert w==testObj.states.idle.w
			assert h==testObj.states.idle.h

testDrawingIdleFrames=->
	export spr=assertSpr((id,...)->
		assert id==256,"Sprite id not matched")

	print "testing tic:#{testObj.tic}"
	draw testObj

	testObj.tic+=1
	print "testing tic:#{testObj.tic}"
	draw testObj

	testObj.tic+=1
	print "testing tic:#{testObj.tic}"
	draw testObj

	testObj.tic+=1
	print "testing tic:#{testObj.tic}"
	draw testObj

testDrawingIdleFrames!
print "Test run complete"
