-- Test drawing
import
	updateFrames
	from require "dorc"

testObj=
	x:120
	y:68
	cx:120
	cy:68
	mode:"idle"
	tic:0
	transcolor:14
	modes:
		idle:
			sprt: 256
			spriteSeqLen:1
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

export peek4=(addr,low)->
	d=
		[256]:1
	id=(addr / ((low and 1 or 0) + 2))-FLGREG
	d[id]

export mget=(x,y)->0

testDrawingIdleFrames=->
	print "testing tic:#{testObj.tic}"
	updateFrames testObj
	assert testObj.sprite==256,"Sprite id should be 256, got #{testObj.sprite}"

	testObj.tic+=1
	print "testing tic:#{testObj.tic}"
	updateFrames testObj
	assert testObj.sprite==256,"Sprite id should be 256, got #{testObj.sprite}"

	testObj.tic+=1
	print "testing tic:#{testObj.tic}"
	updateFrames testObj
	assert testObj.sprite==256,"Sprite id should be 256, got #{testObj.sprite}"

	testObj.tic+=1
	print "testing tic:#{testObj.tic}"
	updateFrames testObj
	assert testObj.sprite==256,"Sprite id should be 256, got #{testObj.sprite}"

testDrawingIdleFrames!
print "Test run complete"
