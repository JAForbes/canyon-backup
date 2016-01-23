// Generated by CoffeeScript 1.6.3
(function() {
  var cableCount, code, conduitProfile, countConduits, deadCable, duct, ductCodeChanged, ductMakeChanged, ductSizeChanged, firComment, firComments, fr10, fr12, fr14, fr15, fr16, fr2, fr3, fr5, fr6, fr7, fr8, fr9, getComment, ids, k, lastDuct, mandrelMax, material, nbnReservedDuct, nestProfile, notLocated, notperplan, phototaken, processedRoutes, sameRouteAs, unfit, value, w, _i, _j, _k, _l, _len, _len1, _len2, _len3, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9,
    _this = this,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  w = new WebPage("actLength", 'Actual measured length (m)');

  w.writeCode("/* One to one translation */\nActual measured length (m) = actlength");

  w.end();

  w = new WebPage('blockenda', 'A end block distance(m)');

  w.writeCode("/* One to one translation */\nA end block distance (m) = blockenda");

  w.end();

  w = new WebPage('blockendb', 'B end block distance(m)');

  w.writeCode("/* One to one translation */\nB end block distance (m) = blockendb");

  w.end();

  w = new WebPage('blocksurf', 'Surface Type at Blockage Location');

  w.writeCode("/* One to one translation */\nSurface Type at Blockage Location = blocksurf");

  w.end();

  w = new WebPage("cables", "Cables");

  w.writeCode("/* Not Applicable for Transits.  Default value to 0 on FIR */\nsds_1f = 0\nmss_12f = 0\nlss_72f = 0\nlss_144f = 0\nlss_288f = 0\nhsl_288f = 0\nhsl_432f = 0\nhsl_576f = 0\nhsd_72f = 0\ndss_72f = 0\ndss_144f = 0\ndss_288f = 0\ndss_432f = 0\ndss_576f = 0");

  w.end();

  cableCount = function(duct) {
    var ids, x;
    ids = duct.cableids.split(',');
    if (ids[0] === "-") {
      return "0";
    } else {
      return ((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = ids.length; _i < _len; _i++) {
          x = ids[_i];
          if (!(x === '-')) {
            _results.push(x);
          }
        }
        return _results;
      })()).length;
    }
  };

  w = new WebPage('cable_count', "Cable Count");

  w.writeCode(cableCount.toString());

  w.beginTable("Cable ID's", "Cable Count");

  ids = [];

  _ref = old_conduit.slice(0, 101);
  for (k in _ref) {
    duct = _ref[k];
    if (!(!(duct.cableids === '-'))) {
      continue;
    }
    ids.push(duct.cableids);
    duct.cableids = ids.join(',');
    w.addToTable(duct.cableids, cableCount(duct));
    lastDuct = duct;
  }

  lastDuct.cableids = "-";

  w.addToTable(duct.cableids, cableCount(lastDuct));

  w.endTable();

  w.end();

  if (typeof document !== "undefined" && document !== null) {
    w = new WebPage('calculated_length', "Calculated Length");
    w.writeCode("/* One to one translation */\ncalculated_length = nbnlength");
  }

  w.end();

  getComment = function(code, value, firComment) {
    if (code === !127) {
      return firComment;
    } else {
      return value + ". " + firComment;
    }
  };

  w = new WebPage("comments", "General Comments");

  w.writeCode(getComment.toString());

  w.beginTable("Code", "Value", "Non Standard Comment", "Comment");

  firComments = ["Custom non-standard comment", ""];

  _ref1 = codedValues.pitfirstandardcomments;
  for (code in _ref1) {
    value = _ref1[code];
    for (_i = 0, _len = firComments.length; _i < _len; _i++) {
      firComment = firComments[_i];
      w.addToTable(code, value, firComment, getComment(code, value, firComment));
    }
  }

  w.endTable();

  w.end();

  w = new WebPage("conduits", "Conduits");

  countConduits = function(duct) {
    var d;
    return ((function() {
      var _results;
      _results = [];
      for (k in old_conduit) {
        d = old_conduit[k];
        if (d.routeid === duct.routeid) {
          _results.push(d);
        }
      }
      return _results;
    })()).length;
  };

  w.writeCode(countConduits.toString());

  w.beginTable("duct.routeid", "Conduit Count");

  _ref2 = old_conduit.slice(0, 26);
  for (k in _ref2) {
    duct = _ref2[k];
    w.addToTable(duct.routeid, countConduits(duct));
  }

  w.end();

  w = new WebPage('conduit_material_and_diameter', 'Conduit Material and Diameter');

  processedRoutes = [];

  sameRouteAs = function(duct) {
    var ducts, otherDuct;
    ducts = [];
    for (k in old_conduit) {
      otherDuct = old_conduit[k];
      if (otherDuct.routeid === duct.routeid) {
        ducts.push(otherDuct);
      }
    }
    return ducts;
  };

  conduitProfile = function(duct) {
    if (duct != null) {
      if (duct.subductnum === "0") {
        duct.subductnum = "";
      }
      return "" + duct.nestcolumn + duct.nestrow + duct.subductnum + ":" + duct.material + duct.diameter + ":" + duct.fill + "%";
    }
  };

  nestProfile = function(duct) {
    var nest, otherDuct, otherDucts, _j, _len1;
    nest = conduitProfile(duct);
    otherDucts = sameRouteAs(duct);
    for (_j = 0, _len1 = otherDucts.length; _j < _len1; _j++) {
      otherDuct = otherDucts[_j];
      nest += "," + conduitProfile(otherDuct);
    }
    return nest;
  };

  w.writeWarning("This example uses multiple function definitions that are not displayed here.\nPlease view the source code file.");

  w.writeCode(nestProfile);

  w.beginTable("Route ID", "Nest Profile");

  for (_j = 0, _len1 = old_conduit.length; _j < _len1; _j++) {
    duct = old_conduit[_j];
    if (_ref3 = duct.routeid, __indexOf.call(processedRoutes, _ref3) < 0) {
      w.addToTable(duct.routeid, nestProfile(duct));
      processedRoutes.push(duct.routeid);
    }
    if (processedRoutes.length > 10) {
      break;
    }
  }

  w.endTable();

  w.end();

  deadCable = function(duct) {
    if (duct.deadCable === "Y") {
      duct.deadCable;
    }
    return "";
  };

  w = new WebPage('deadCable', 'Insitu Dead Cable identified');

  w.writeCode(deadCable.toString());

  w.end();

  ductCodeChanged = function(duct) {
    var nbnStr, tlsStr;
    nbnStr = ("" + duct.nbnnestcol + duct.nbnnestrow + duct.nbnsubduct).replace("0", "");
    tlsStr = ("" + duct.nestcolumn + duct.nestrow + duct.subductnum).replace("0", "");
    return [nbnStr !== tlsStr ? tlsStr : void 0] + "";
  };

  w = new WebPage('ductCodeChanged', 'Alternative Duct Section');

  w.beginTable("NBN", "Scoper", "Answer");

  _ref4 = old_conduit.slice(0, 11);
  for (k in _ref4) {
    duct = _ref4[k];
    if (k % 4 === 0) {
      duct.nestrow = 'B';
    }
    w.addToTable("" + duct.nbnnestcol + duct.nbnnestrow + duct.nbnsubduct, "" + duct.nestcolumn + duct.nestrow + duct.subductnum, ductCodeChanged(duct));
  }

  w.endTable();

  w.end();

  ductMakeChanged = function(duct) {
    if (duct.nbnmat === duct.material) {
      return "";
    }
    return codedValues.actualconduittype[duct.material];
  };

  w = new WebPage('ductMakeChanged', "Duct make not as per Planning Information");

  w.writeCode(ductMakeChanged.toString());

  w.beginTable("NBN Material", "Scoper Material", "Answer");

  _ref5 = old_conduit.slice(0, 11);
  for (k in _ref5) {
    duct = _ref5[k];
    w.addToTable(duct.nbnmat, duct.material, ductMakeChanged(duct));
  }

  w.endTable();

  w.end();

  ductSizeChanged = function(duct) {
    if (duct.nbndiamtr === duct.diameter) {
      return '';
    }
    return duct.diameter;
  };

  w = new WebPage('ductSizeChanged', "Duct size not as per Planning Information");

  w.writeCode(ductSizeChanged.toString());

  w.beginTable("NBN Diamater", "Scoper Diameter", "Answer");

  _ref6 = old_conduit.slice(0, 11);
  for (k in _ref6) {
    duct = _ref6[k];
    if (k % 4 === 0) {
      duct.diameter = "20";
    }
    w.addToTable(duct.nbndiamtr, duct.diameter, ductSizeChanged(duct));
  }

  w.endTable();

  w.end();

  if (typeof document !== "undefined" && document !== null) {
    w = new WebPage('end_node', "End Node");
    w.writeCode("/* One to one translation */\nend_node_tls_id = endnode");
  }

  w.end();

  w = new WebPage("fda", "FDA");

  w.writeCode("/* Not applicable for Transit Link */\nFDA = \"\"");

  w.end();

  w = new WebPage('fr1', "FR1");

  w.writeWarning("Not Implemented!");

  w.end();

  w = new WebPage('fr10', "FR10");

  fr10 = function(duct) {
    if (duct.fr10 === "Y") {
      return duct.fr10;
    }
    return "";
  };

  w.writeCode(fr10.toString());

  w.end();

  w = new WebPage('fr11', "FR11");

  w.writeWarning("Not Implemented!");

  w.end();

  w = new WebPage('fr12', "FR12");

  fr12 = function(duct) {
    if (duct.fr12 === "Y") {
      return duct.fr12;
    }
    return "";
  };

  w.writeCode(fr12.toString());

  w.end();

  w = new WebPage('fr13', "FR13");

  w.writeWarning("Not Implemented!");

  w.end();

  w = new WebPage('fr14', "FR14");

  fr14 = function(duct) {
    if (duct.fr14 === "Y") {
      return duct.fr14;
    }
    return "";
  };

  w.writeCode(fr14.toString());

  w.end();

  w = new WebPage('fr15', "FR15");

  fr15 = function(duct) {
    if (duct.fr15 === "Y") {
      return duct.fr15;
    }
    return "";
  };

  w.writeCode(fr15.toString());

  w.end();

  w = new WebPage('fr16', "FR16");

  fr16 = function(duct) {
    if (duct.fr16 === "Y") {
      return duct.fr16;
    }
    return "";
  };

  w.writeCode(fr16.toString());

  w.end();

  w = new WebPage('fr17', "FR17");

  w.writeWarning("Not Implemented!");

  w.end();

  w = new WebPage('fr18', "FR18");

  w.writeWarning("Not Implemented!");

  w.end();

  w = new WebPage('fr2', "FR2");

  fr2 = function(duct) {
    if (duct.fr02 === "Y") {
      return duct.fr02;
    }
    return "";
  };

  w.writeCode(fr2.toString());

  w.end();

  w = new WebPage('fr3', "FR3");

  fr3 = function(duct) {
    return [duct.actlength > 250 ? 'Y' : void 0] + '';
  };

  w.writeCode(fr3);

  w.beginTable("Actual Length", "FR3");

  _ref7 = old_conduit.slice(0, 11);
  for (k in _ref7) {
    duct = _ref7[k];
    duct.actlength = Math.floor(Math.random() * 150);
    if (k % 4 === 0) {
      duct.actlength += 250;
    }
    w.addToTable(duct.actlength, fr3(duct));
  }

  w.endTable();

  w.end();

  w = new WebPage('fr4', "FR4");

  w.writeWarning("Not Implemented!");

  w.end();

  w = new WebPage('fr5', "FR5");

  fr5 = function(duct) {
    if (duct.fr05 === "Y") {
      return duct.fr05;
    }
    return "";
  };

  w.writeCode(fr5.toString());

  w.end();

  w = new WebPage('fr6', "FR6");

  fr6 = function(duct) {
    if (duct.fr06 === "Y") {
      return duct.fr06;
    }
    return "";
  };

  w.writeCode(fr6.toString());

  w.end();

  w = new WebPage('fr7', "FR7");

  fr7 = function(duct) {
    if (duct.fr07 === "Y") {
      return duct.fr07;
    }
    return "";
  };

  w.writeCode(fr7.toString());

  w.end();

  w = new WebPage('fr8', "FR8");

  fr8 = function(duct) {
    if (duct.fr08 === "Y") {
      return duct.fr08;
    }
    return "";
  };

  w.writeCode(fr8.toString());

  w.end();

  w = new WebPage('fr9', "FR9");

  fr9 = function(duct) {
    if (duct.fr09 === "Y") {
      return duct.fr09;
    }
    return "";
  };

  w.writeCode(fr9.toString());

  w.end();

  w = new WebPage('mandrelmax', 'Maximum Mandrel Hauled (mm)');

  mandrelMax = function(duct) {
    if (mandrelmax === !"0") {
      return mandrelmax;
    }
    return "N/A";
  };

  w.writeCode(mandrelMax.toString());

  w.end();

  w = new WebPage('material', 'Material');

  material = function(duct) {
    return (duct.nbnmat || duct.material || "X") + (duct.nbndiamtr || duct.diameter);
  };

  w.writeCode(material.toString());

  w.beginTable("NBN Material", "Material", "NBN Diameter", "Diameter", "Output");

  _ref8 = old_conduit.slice(0, 11);
  for (_k = 0, _len2 = _ref8.length; _k < _len2; _k++) {
    duct = _ref8[_k];
    w.addToTable(duct.nbnmat, duct.material, duct.nbndiamtr, duct.diameter, material(duct));
  }

  w.endTable();

  w.end();

  if (typeof document !== "undefined" && document !== null) {
    w = new WebPage('measured_length', "Measured Length");
    w.writeCode("/* One to one translation */\nmeasured_length = nbnlength");
  }

  w.end();

  nbnReservedDuct = function(duct) {
    var out;
    out = "" + duct.nbnnestcol + duct.nbnnestrow + duct.nbnsubduct;
    return out.replace("0", "");
  };

  w = new WebPage('NBN_reserved_duct', 'NBN Reserved Duct');

  w.writeCode(nbnReservedDuct.toString());

  w.beginTable("Nest Col", "Nest Row", "Subduct", "NBN Reserved Duct");

  _ref9 = old_conduit.slice(0, 11);
  for (_l = 0, _len3 = _ref9.length; _l < _len3; _l++) {
    duct = _ref9[_l];
    w.addToTable(duct.nbnnestcol, duct.nbnnestrow, duct.nbnsubduct, nbnReservedDuct(duct));
  }

  w.endTable();

  w.end();

  notLocated = function(duct) {
    if (duct.scopestate === 6) {
      return "Y";
    }
    return "";
  };

  w = new WebPage('notLocated', 'Not Located');

  w.writeCode(notLocated.toString());

  w.end();

  w = new WebPage('notperplan', 'Location not as per Planning Information (Y/N)');

  notperplan = function(duct) {
    if (duct.notperplan === "Y") {
      return "Y";
    } else {
      return "";
    }
  };

  w.writeWarning("Not a direct translation.  Do not return 'N'");

  w.writeCode(notperplan.toString());

  w.end();

  w = new WebPage('otherdamage', "Other relevant physical visible damage");

  w.writeCode("#Direct translation\nOther relevant physical visible damage = otherdamage");

  w.end();

  w = new WebPage('phototaken', "Photograph Taken");

  phototaken = function(duct) {
    if (phototaken === "Y") {
      phototaken;
    }
    return "";
  };

  w.writeCode(phototaken.toString());

  w.end();

  if (typeof document !== "undefined" && document !== null) {
    w = new WebPage('start_node', "Start Node");
    w.writeCode("/* One to one translation */\nstart_node_tls_id = startnode");
  }

  w.end();

  if (typeof document !== "undefined" && document !== null) {
    w = new WebPage('systemID', "System ID");
    w.writeCode("/* system_id not provided in NDD GML, default value to 0 on FIR */\nsystem_id = 0");
    w.end();
  }

  if (typeof document !== "undefined" && document !== null) {
    w = new WebPage('tls_id_conduit', "Telstra Conduit ID");
    w.writeCode("/* One to one translation */\ntls_id_conduit = conduitid");
  }

  w.end();

  if (typeof document !== "undefined" && document !== null) {
    w = new WebPage('tls_id_route', "Telstra Route ID");
    w.writeCode("/* One to one translation */\ntls_id_route = routeid");
  }

  w.end();

  w = new WebPage('unfit', "Unfit");

  unfit = function(duct) {
    return [duct.scopestate === "6" ? "Y" : void 0] + '';
  };

  w.writeCode(unfit.toString());

  w.end();

}).call(this);
