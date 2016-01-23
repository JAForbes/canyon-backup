can = document.getElementById 'canvas'
con = can.getContext '2d'



class Level
	constructor : (@levelData) ->
		
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

	validMoves : (x,y) =>
		moves = []
		unless @levelData[y+1][x] is 1
			moves.push {x:0,y:1}
		unless @levelData[y-1][x] is 1
			moves.push {x:0,y:-1}
		unless @levelData[y][x+1] is 1
		  moves.push {x:1,y:0}
		unless @levelData[y][x-1] is 1
			moves.push {x:-1,y:0}
		return moves


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
	constructor : (@x,@y,@colour) ->
		@vx = 0
		@vy = 0
		@nx = undefined
		@ny = undefined
	draw : () =>
		con.fillStyle = @colour
		con.fillRect(@x*10,@y*10,10,10)
		
	move : (validMoves) =>
		#shuffle moves
		validMoves = validMoves.sort -> 0.5 - Math.random()
		if validMoves?
			for valid in validMoves
				if validMoves.length > 1
					unless (valid.x *-1 is @vx) and (valid.y *-1 is @vy)
						@vx = valid.x
						@vy = valid.y
						break
				else #go backwards if you have to
					@vx = valid.x
					@vy = valid.y
					break
				 
		
		@x += @vx
		@y += @vy


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

p = new Pacman(10,16)
p.draw()
window.addEventListener "keydown", p.keyDown

pg = new Ghost(11,16,'#800080')


update = () ->

	canvas.width = canvas.width
	l.draw()
	pg.move(l.validMoves(pg.x,pg.y))
	pg.draw()

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
	
	
intervalId = setInterval update,180
window.lev = @levelData
window.validMoves = l.validMoves