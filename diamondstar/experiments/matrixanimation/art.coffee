canvas = document.getElementById 'c'
context = canvas.getContext '2d'


#Colours!
s = 'fccd8e' #skin
h = '8c5c4d' #hair
a = '691c63' #arms
t = 'dc5173' #torso
c = 'b3b3b3' #collar
w = 'b3b3b3' #waist
b = '4f4f4f' #buckle
p = 'ff9fb6' #pants
f = 'ad51b9' #feet
o = 'TRANSPARENT'

idle = [
	[o,h,h,h,o]
	[h,h,s,s,h]
	[h,s,s,s,h]
	[o,o,s,o,o]
	[a,t,c,t,a]
	[a,t,t,t,a]
	[a,t,t,t,a]
	[s,w,b,w,s]
	[o,p,p,p,o]
	[o,p,o,p,o]
	[o,f,o,f,o]
]

currentMatrix = idle

copyMatrix = (matrix) =>
	copy = []
	for row in matrix
		copy.push row.slice(0)
	return copy

lookRight = copyMatrix idle
lookRight[1][2]=h
lookRight[2][1]=h

lookLeft = copyMatrix idle
lookLeft[1][1]=s
lookLeft[1][3]=h
lookLeft[2][3]=h

lookUp = copyMatrix idle
lookUp[0] = [o,o,o,o,o]
lookUp[1] = [h,s,s,s,h]
lookUp[2] = [h,s,s,s,h]
lookUp[3] = [h,h,s,h,h]



faceUp = copyMatrix idle
faceUp[1] = [h,h,h,h,h]
faceUp[2] = [h,h,h,h,h]
faceUp[4] = [a,t,t,t,a]
faceUp[7] = [s,w,w,w,s]

lookDown = copyMatrix idle
lookDown[0] = [o,o,o,o,o]
lookDown[1] = [h,h,h,h,h]
lookDown[2] = [h,h,h,h,h]
lookDown[3] = [h,s,s,s,h]
lookDown[4] = [a,t,t,t,a]

mouseMoved = (e) =>
	if e.pageY > 150
		currentMatrix = lookDown
	else if e.pageY > 50
		if 75< e.pageX <160
			currentMatrix = idle
		if e.pageX < 100
			currentMatrix = lookLeft
		if e.pageX > 150
			currentMatrix = lookRight
	else e.pageY < 20
		currentMatrix = lookUp


draw = () =>
	canvas.width = canvas.width
	context.translate 70,50
	for y,row of currentMatrix
		for x,value of row
			if not (value is o)
				context.fillStyle = value
				context.fillRect x*10,y*10,10,10

document.body.addEventListener 'mousemove', mouseMoved


setInterval(draw,30)		