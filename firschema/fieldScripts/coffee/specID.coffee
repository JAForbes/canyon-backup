specID = (pit) =>
  description = codedValues.pitname[pit.tlspitname]
  #associated longer descriptions for particular codes
  pitCodes = {"J":"Injection Moulded","H":"Hand Moulded","P":"Thermoplastic","PC":"Precast"}
  
  #capture the first digit in the string
  pitSize = description[description.search /\d/] 

  #pitCode is the first character of the string description
  pitCode = description[0]

  switch pitCode
    when "C" and pitSize?      
      pitCode = "PC" #Precast
    when "V" #Victorian Pit
      pitSize = "D"
    when "0"
      pitCode = "O" #O pit

  #Long description for shorter code ie H = Hand Moulded
  longForm = pitCodes[pitCode]

  switch pitCode
    when "H", "J", "P", "PC" 
      return "Pit #{pitSize}, #{pitCode} (#{longForm})" #e.g. Pit 4, P (Thermoplastic)
    when "V"
      return "Pit D, H (Hand Moulded - Vic)"
    when "M"
      return description.replace "MH", "Manhole"
    when "X"
      return "Other"
    when "N"
      return "Not Determined"
    else
      return "Pit #{pitCode}, H (Hand Moulded)"

###WRITING TO WEBPAGE###
w = new WebPage "specID","Specification ID"

w.writeCode specID.toString()

w.beginTable "Description","Sentence"

#generate the correct specID for each possible description
for key,description of codedValues.pitname
  old_pit[0].tlspitname = key
  w.addToTable description,specID old_pit[0]

w.endTable()
w.end()