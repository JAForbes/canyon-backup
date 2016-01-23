getComment = (code,value,firComment) ->	
  #If the standard comment is empty return only the non standard comment.
  #Always append the non standard comment.
  if code is not 127
  	return firComment
  else
    return value+". "+firComment 

w = new WebPage "comments", "General Comments"
w.writeCode getComment.toString()

w.beginTable "Code","Value","Non Standard Comment","Comment"
firComments = ["Custom non-standard comment",""]
for code,value of codedValues.pitfirstandardcomments
  for firComment in firComments
  	w.addToTable code,value,firComment,getComment(code,value,firComment)

w.endTable()

w.end()