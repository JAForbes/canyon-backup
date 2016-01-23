can = document.getElementById 'canvas'
con = can.getContext '2d'



class Level
	constructor : (@levelData) ->
		window.lev = @levelData
	draw : () =>
		for rowIndex,row of @levelData
			for colIndex,col of row
				if col is 0
					con.fillStyle = '#000'
					con.fillRect 10*colIndex,10*rowIndex, 10, 10
				else if col is 1
					con.fillStyle = '#6688FB'
					con.fillRect 10*colIndex,10*rowIndex, 10, 10

		for rowIndex,row of @levelData
			for colIndex,col of row
				if col is 2
					con.fillStyle = '#000'
					con.fillRect 10*colIndex,10*rowIndex, 10, 10
					con.fillStyle = '#FFF'
					con.fillRect (10*colIndex)+2.5,(10*rowIndex)+2.5, 5, 5

	canMove : (x,y,vx,vy) =>
		if @levelData[y+vy]?[x+vx] is 1
			return false
		else
		  return true

	collectPellet : (x,y) =>
		if @levelData[y][x] is 2
			@levelData[y][x] = 0
			return true
		else
		  return false

	pelletsGone : () =>
		for row in @levelData
			if 2 in row
				return false
		return true

class Pacman
  constructor : (@x,@y) ->
  	@vx = 0
  	@vy = 0
  	@nx = undefined #next vx
  	@ny = undefined #next vy

  draw : () =>
  	con.fillStyle = '#FF0'
  	con.fillRect(@x*10,@y*10,10,10)

  keyDown : (e) =>

  	switch e.keyCode #no arrow page scrolling
  		when 38,39,40,37
  		  e.preventDefault()

  	switch e.keyCode
  		when 38
  		  @nx = 0
  		  @ny = -1
  		when 39
  		  @nx = 1
  		  @ny = 0
  		when 40
  		  @nx = 0
  		  @ny = 1
  		when 37
  		  @nx = -1
  		  @ny = 0

  move : () =>
  	@x += @vx
  	@y += @vy

  turn : () =>
  	@vx = @nx
  	@vy = @ny
  	@nx = undefined
  	@ny = undefined

  hasTurn : () =>
  	p.nx?

class Ghost


levelData = [
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	[1,2,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,1]
	[1,2,1,1,1,2,1,1,1,2,1,2,1,1,1,2,1,1,1,2,1]
	[1,2,1,1,1,2,1,1,1,2,1,2,1,1,1,2,1,1,1,2,1]
	[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1]
	[1,2,1,1,1,2,1,2,1,1,1,1,1,2,1,2,1,1,1,2,1]
	[1,2,2,2,2,2,1,2,2,2,1,2,2,2,1,2,2,2,2,2,1]
	[1,1,1,1,1,2,1,1,1,2,1,2,1,1,1,2,1,1,1,1,1]
	[3,3,3,3,1,2,1,2,2,2,2,2,2,2,1,2,1,3,3,3,3]
	[1,1,1,1,1,2,1,2,1,1,2,1,1,2,1,2,1,1,1,1,1]
	[2,2,2,2,2,2,2,2,1,2,2,2,1,2,2,2,2,2,2,2,2]
	[1,1,1,1,1,2,1,2,1,1,1,1,1,2,1,2,1,1,1,1,1]
	[3,3,3,3,1,2,1,2,2,2,2,2,2,2,1,2,1,3,3,3,3]
	[1,1,1,1,1,2,1,2,1,1,1,1,1,2,1,2,1,1,1,1,1]
	[1,2,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,1]
	[1,2,1,1,1,2,1,1,1,2,1,2,1,1,1,2,1,1,1,2,1]
	[1,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,1,2,2,2,1]
	[1,1,1,2,1,2,1,2,1,1,1,1,1,2,1,2,1,2,1,1,1]
	[1,2,2,2,2,2,1,2,2,2,1,2,2,2,1,2,2,2,2,2,1]
	[1,2,1,1,1,1,1,1,1,2,1,2,1,1,1,1,1,1,1,2,1]
	[1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1]
	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
]

l = new Level(levelData)
l.draw()

p = new Pacman(10,16,10,10)
p.draw()
window.addEventListener "keydown", p.keyDown

update = () ->
	canvas.width = canvas.width
	l.draw()

	if p.hasTurn()
		if l.canMove p.x,p.y,p.nx,p.ny
			p.turn()

	if l.canMove p.x,p.y,p.vx,p.vy
	  p.move()

	l.collectPellet(p.x,p.y)
	p.draw()

	if l.pelletsGone()
		console.log 'win'
		clearInterval intervalId

intervalId = setInterval update,120