// Generated by CoffeeScript 1.6.3
(function() {
  var Game, Ghost, Level, Pacman, can, con, g, l, levelData, p, update,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  can = document.getElementById('canvas');

  con = can.getContext('2d');

  Level = (function() {
    function Level(levelData) {
      this.levelData = levelData;
      this.canMove = __bind(this.canMove, this);
      this.draw = __bind(this.draw, this);
      window.lev = this.levelData;
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
      if (this.levelData[y + vy][x + vx] === 1) {
        return false;
      } else {
        return true;
      }
    };

    return Level;

  })();

  Game = (function() {
    function Game() {}

    return Game;

  })();

  Pacman = (function() {
    function Pacman(x, y) {
      this.x = x;
      this.y = y;
      this.hasTurn = __bind(this.hasTurn, this);
      this.turn = __bind(this.turn, this);
      this.move = __bind(this.move, this);
      this.keyDown = __bind(this.keyDown, this);
      this.draw = __bind(this.draw, this);
      this.vx = 0;
      this.vy = 0;
      this.nx = void 0;
      this.ny = void 0;
    }

    Pacman.prototype.draw = function() {
      con.fillStyle = '#FF0';
      return con.fillRect(this.x * 10, this.y * 10, 10, 10);
    };

    Pacman.prototype.keyDown = function(e) {
      switch (e.keyCode) {
        case 38:
        case 39:
        case 40:
        case 37:
          e.preventDefault();
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

    return Pacman;

  })();

  Ghost = (function() {
    function Ghost() {}

    return Ghost;

  })();

  g = new Game();

  levelData = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1], [1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1], [1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1], [1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1], [1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1], [1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1], [1, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1], [0, 0, 0, 0, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2], [1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1], [0, 0, 0, 0, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1], [1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1], [1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1], [1, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1], [1, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1], [1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1], [1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1], [1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]];

  l = new Level(levelData);

  l.draw();

  p = new Pacman(10, 16, 10, 10);

  p.draw();

  window.addEventListener("keydown", p.keyDown);

  update = function() {
    canvas.width = canvas.width;
    l.draw();
    if (p.hasTurn()) {
      if (l.canMove(p.x, p.y, p.nx, p.ny)) {
        p.turn();
      }
    }
    if (l.canMove(p.x, p.y, p.vx, p.vy)) {
      p.move();
    }
    return p.draw();
  };

  setInterval(update, 120);

}).call(this);
