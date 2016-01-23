// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __slice = [].slice;

  window.WebPage = (function() {
    function WebPage(divID, heading) {
      var d;
      this.divID = divID;
      this.heading = heading;
      this.endTable = __bind(this.endTable, this);
      this.addToTable = __bind(this.addToTable, this);
      this.beginTable = __bind(this.beginTable, this);
      this.writeCode = __bind(this.writeCode, this);
      this.writeHtml = __bind(this.writeHtml, this);
      this.end = __bind(this.end, this);
      this.html = [];
      document.querySelector(".span10").innerHTML += "<div id='" + this.divID + "'></div>";
      d = document.querySelector(".nav.nav-list");
      d.innerHTML += "<li><a href='#" + this.divID + "'>" + this.heading + "</a></li></ul>";
      this.html.push("<h2>" + this.heading + "</h2>");
      this.html.push("<a href='./fieldScripts/coffee/" + this.divID + ".coffee'>Source Code Used To Generate Result</a>");
    }

    WebPage.prototype.end = function() {
      return document.getElementById("" + this.divID).innerHTML = this.html.join("");
    };

    WebPage.prototype.writeHtml = function(html) {
      return this.html.push(html);
    };

    WebPage.prototype.writeCode = function(code) {
      return this.html.push("<pre><code>" + code + "</code></pre>");
    };

    WebPage.prototype.beginTable = function() {
      var heading, headings, table, _i, _len;
      headings = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      this.html.push("<table class='table table-striped' width='200px'>");
      table = "<tr>";
      for (_i = 0, _len = headings.length; _i < _len; _i++) {
        heading = headings[_i];
        table += "<th>" + heading + "</th>";
      }
      table += "</tr>";
      return this.html.push(table);
    };

    WebPage.prototype.addToTable = function() {
      var cell, cells, table, _i, _len;
      cells = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      table = "<tr>";
      for (_i = 0, _len = cells.length; _i < _len; _i++) {
        cell = cells[_i];
        table += "<td>" + cell + "</td>";
      }
      table += "</tr>";
      return this.html.push(table);
    };

    WebPage.prototype.endTable = function() {
      return this.html.push("</table>");
    };

    return WebPage;

  })();

}).call(this);
