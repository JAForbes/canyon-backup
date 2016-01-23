// Generated by CoffeeScript 1.6.3
(function() {
  var ArrayUtils, Ghost, Level, Pacman, can, con, ghosts, interacted, intervalId, l, levelData, p, reset, respawn, score, update,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  can = document.getElementById('canvas');

  con = can.getContext('2d');

  interacted = false;

  ArrayUtils = (function() {
    function ArrayUtils() {}

    ArrayUtils.shuffle = function(array) {
      return array.sort(function() {
        return 0.5 - Math.random();
      });
    };

    ArrayUtils.clone2d = function(array) {
      var newArray, row, _i, _len;
      newArray = [];
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        row = array[_i];
        newArray.push(row.slice(0));
      }
      return newArray;
    };

    return ArrayUtils;

  })();

  Level = (function() {
    function Level(levelData) {
      this.levelData = levelData;
      this.pelletsGone = __bind(this.pelletsGone, this);
      this.collectPellet = __bind(this.collectPellet, this);
      this.validMoves = __bind(this.validMoves, this);
      this.wrap = __bind(this.wrap, this);
      this.canMove = __bind(this.canMove, this);
      this.draw = __bind(this.draw, this);
    }

    Level.prototype.draw = function() {
      var col, colIndex, row, rowIndex, _ref, _ref1, _results;
      _ref = this.levelData;
      for (rowIndex in _ref) {
        row = _ref[rowIndex];
        for (colIndex in row) {
          col = row[colIndex];
          if (col === 0) {
            con.fillStyle = '#000';
            con.fillRect(10 * colIndex, 10 * rowIndex, 10, 10);
          } else if (col === 1) {
            con.fillStyle = '#6688FB';
            con.fillRect(10 * colIndex, 10 * rowIndex, 10, 10);
          }
        }
      }
      _ref1 = this.levelData;
      _results = [];
      for (rowIndex in _ref1) {
        row = _ref1[rowIndex];
        _results.push((function() {
          var _results1;
          _results1 = [];
          for (colIndex in row) {
            col = row[colIndex];
            if (col === 2) {
              con.fillStyle = '#000';
              con.fillRect(10 * colIndex, 10 * rowIndex, 10, 10);
              con.fillStyle = '#FFF';
              _results1.push(con.fillRect((10 * colIndex) + 2.5, (10 * rowIndex) + 2.5, 5, 5));
            } else {
              _results1.push(void 0);
            }
          }
          return _results1;
        })());
      }
      return _results;
    };

    Level.prototype.canMove = function(x, y, vx, vy) {
      var _ref;
      if (((_ref = this.levelData[y + vy]) != null ? _ref[x + vx] : void 0) === 1) {
        return false;
      } else {
        return true;
      }
    };

    Level.prototype.wrap = function(entity) {
      var _ref;
      if (entity.x > ((_ref = levelData[entity.y]) != null ? _ref.length : void 0) - 1) {
        entity.x = 0;
      } else if (entity.x < 0) {
        entity.x = levelData[entity.y].length - 1;
      }
      if (entity.y > levelData.length - 1) {
        return entity.y = 0;
      } else if (entity.y < 0) {
        return entity.y = levelData.length - 1;
      }
    };

    Level.prototype.validMoves = function(x, y) {
      var moves, _ref, _ref1, _ref2, _ref3;
      moves = [];
      if (((_ref = this.levelData[y + 1]) != null ? _ref[x] : void 0) !== 1) {
        moves.push({
          x: 0,
          y: 1
        });
      }
      if (((_ref1 = this.levelData[y - 1]) != null ? _ref1[x] : void 0) !== 1) {
        moves.push({
          x: 0,
          y: -1
        });
      }
      if (((_ref2 = this.levelData[y]) != null ? _ref2[x + 1] : void 0) !== 1) {
        moves.push({
          x: 1,
          y: 0
        });
      }
      if (((_ref3 = this.levelData[y]) != null ? _ref3[x - 1] : void 0) !== 1) {
        moves.push({
          x: -1,
          y: 0
        });
      }
      return moves;
    };

    Level.prototype.collectPellet = function(x, y) {
      var pellet_snd, _ref;
      if (((_ref = this.levelData[y]) != null ? _ref[x] : void 0) === 2) {
        this.levelData[y][x] = 0;
        pellet_snd = new Audio("snd/pellet_4.wav");
        pellet_snd.play();
        score += 10;
        return true;
      } else {
        return false;
      }
    };

    Level.prototype.pelletsGone = function() {
      var ping, row, _i, _len, _ref;
      _ref = this.levelData;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        row = _ref[_i];
        if (__indexOf.call(row, 2) >= 0) {
          return false;
        }
      }
      ping = new Audio("snd/cool.wav");
      ping.play();
      return true;
    };

    return Level;

  })();

  Pacman = (function() {
    function Pacman(x, y) {
      this.x = x;
      this.y = y;
      this.die = __bind(this.die, this);
      this.hasTurn = __bind(this.hasTurn, this);
      this.turn = __bind(this.turn, this);
      this.move = __bind(this.move, this);
      this.keyDown = __bind(this.keyDown, this);
      this.draw = __bind(this.draw, this);
      this.vx = 0;
      this.vy = 0;
      this.nx = void 0;
      this.ny = void 0;
      this.fx = void 0;
      this.fy = void 0;
      this.alive = true;
    }

    Pacman.prototype.draw = function() {
      if (this.alive) {
        con.fillStyle = '#FF0';
      } else {
        con.fillStyle = '#F00';
      }
      return con.fillRect(this.x * 10, this.y * 10, 10, 10);
    };

    Pacman.prototype.keyDown = function(e) {
      switch (e.keyCode) {
        case 38:
        case 39:
        case 40:
        case 37:
          e.preventDefault();
          if (!interacted) {
            interacted = true;
          }
      }
      switch (e.keyCode) {
        case 38:
          this.nx = 0;
          return this.ny = -1;
        case 39:
          this.nx = 1;
          return this.ny = 0;
        case 40:
          this.nx = 0;
          return this.ny = 1;
        case 37:
          this.nx = -1;
          return this.ny = 0;
      }
    };

    Pacman.prototype.move = function() {
      this.x += this.vx;
      return this.y += this.vy;
    };

    Pacman.prototype.turn = function() {
      this.vx = this.nx;
      this.vy = this.ny;
      this.nx = void 0;
      return this.ny = void 0;
    };

    Pacman.prototype.hasTurn = function() {
      return p.nx != null;
    };

    Pacman.prototype.die = function() {
      var ping;
      this.alive = false;
      score -= 100;
      if (interacted) {
        ping = new Audio("snd/lose.wav");
        return ping.play();
      }
    };

    return Pacman;

  })();

  Ghost = (function() {
    function Ghost(x, y, colour) {
      this.x = x;
      this.y = y;
      this.colour = colour;
      this.kill = __bind(this.kill, this);
      this.move = __bind(this.move, this);
      this.draw = __bind(this.draw, this);
      this.vx = 0;
      this.vy = 0;
      this.nx = void 0;
      this.ny = void 0;
      this.fx = void 0;
      this.fy = void 0;
    }

    Ghost.prototype.draw = function() {
      con.fillStyle = this.colour;
      return con.fillRect(this.x * 10, this.y * 10, 10, 10);
    };

    Ghost.prototype.move = function(validMoves) {
      var valid, _i, _len;
      validMoves = ArrayUtils.shuffle(validMoves);
      if (validMoves != null) {
        for (_i = 0, _len = validMoves.length; _i < _len; _i++) {
          valid = validMoves[_i];
          if (validMoves.length > 1) {
            if (!((valid.x * -1 === this.vx) && (valid.y * -1 === this.vy))) {
              this.vx = valid.x;
              this.vy = valid.y;
              break;
            }
          } else {
            this.vx = valid.x;
            this.vy = valid.y;
            break;
          }
        }
      }
      this.x += this.vx;
      return this.y += this.vy;
    };

    Ghost.prototype.kill = function(pacman) {
      pacman.fx = pacman.x + pacman.vx / 2;
      pacman.fy = pacman.y + pacman.vy / 2;
      this.fx = this.x + this.vx / 2;
      this.fy = this.y + this.vy / 2;
      if (this.x === pacman.x && this.y === pacman.y) {
        pacman.die();
      }
      if (this.fx === pacman.fx && this.fy === pacman.fy) {
        return pacman.die();
      }
    };

    return Ghost;

  })();

  window.levelStart = [[1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1], [0, 2, 2, 2, 2, 0, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0], [1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 0, 1, 1, 1, 2, 1], [1, 2, 1, 1, 1, 0, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1], [1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 1], [1, 2, 1, 1, 1, 0, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1], [1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1, 0, 2, 2, 2, 2, 1], [1, 1, 1, 1, 1, 0, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1], [3, 3, 3, 3, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 1, 0, 1, 3, 3, 3, 3], [1, 1, 1, 1, 1, 0, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 0, 2, 2, 2, 2, 2], [1, 1, 1, 1, 1, 0, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1], [3, 3, 3, 3, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 1, 0, 1, 3, 3, 3, 3], [1, 1, 1, 1, 1, 0, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1], [1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 0, 2, 2, 2, 2, 1], [1, 2, 1, 1, 1, 0, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1], [1, 2, 2, 2, 1, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 0, 1, 2, 2, 2, 1], [1, 1, 1, 2, 1, 0, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1], [1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1, 0, 2, 2, 2, 2, 1], [1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1], [0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0], [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1]];

  levelData = void 0;

  score = void 0;

  l = void 0;

  p = void 0;

  ghosts = void 0;

  intervalId = void 0;

  setInterval(function() {
    if (score > 0) {
      return score -= 10;
    }
  }, 1000);

  reset = function() {
    levelData = ArrayUtils.clone2d(levelStart);
    respawn();
    return score = 0;
  };

  respawn = function() {
    l = new Level(levelData);
    l.draw();
    p = new Pacman(10, 16);
    p.draw();
    window.addEventListener("keydown", p.keyDown);
    ghosts = [];
    ghosts.push(new Ghost(11, 10, 'PURPLE'));
    ghosts.push(new Ghost(10, 10, 'PINK'));
    ghosts.push(new Ghost(9, 10, 'AQUA'));
    ghosts.push(new Ghost(9, 10, 'RED'));
    return intervalId = setInterval(update, 180);
  };

  update = function() {
    var g, _i, _len;
    canvas.width = canvas.width;
    l.draw();
    for (_i = 0, _len = ghosts.length; _i < _len; _i++) {
      g = ghosts[_i];
      g.move(l.validMoves(g.x, g.y));
      l.wrap(g);
      g.draw();
      g.kill(p);
    }
    if (p.hasTurn()) {
      if (l.canMove(p.x, p.y, p.nx, p.ny)) {
        p.turn();
      }
    }
    if (l.canMove(p.x, p.y, p.vx, p.vy)) {
      p.move();
    }
    l.wrap(p);
    l.collectPellet(p.x, p.y);
    p.draw();
    if (l.pelletsGone()) {
      console.log('win');
      clearInterval(intervalId);
      setTimeout(reset, 10000);
    }
    if (!p.alive) {
      clearInterval(intervalId);
      respawn();
    }
    con.fillStyle = '#000';
    con.font = "bold 12px sans-serif";
    return con.fillText("Score: " + score, 0, (levelData.length + 1) * 10);
  };

  reset();

}).call(this);