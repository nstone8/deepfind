import os
import strutils

proc saveFile(path:string,saveDir:string) =
  echo("Saving file ",path)

proc processFile(path:string,saveDir:string,maxKwLen:int) =
  echo("Processing file ",path)
  f=open(path)
  var oldString=""
  var newString=""
  while readLine(f,newString):
    

#we will accept any number of inputs, these will be our keywords

var keywords:seq[string]

if paramCount() < 3:
  quit("usage: deepfind searchRoot saveDir keyword1 [keyword2] [keyword3] ...")

let searchRoot=paramStr(1).string

let saveDir=paramStr(2).string

for i in 2..paramCount():
  keywords.add(paramStr(i).string)

var maxKwLen=0
for kw in keywords:
  if kw.len>maxKwLen:
    maxKwLen=kw.len
  
var filesToCheck: seq[string]

var dirsToCheck:seq[string]

dirsToCheck.add(searchRoot)

var thisDir:string

while dirsToCheck.len > 0:
  thisDir=dirsToCheck.pop
  for (kind,path) in thisDir.walkDir:
    case kind:
      of pcFile:
        var filename=""
        while filename=="":
          filename=path.splitPath[1]
        var nameMatch=false
        for kw in keywords:
          if kw in filename:
            nameMatch=true
            break
        if nameMatch:
          path.saveFile(saveDir)
        else:
          path.processFile(saveDir,maxKwLen)
      of pcDir:
        dirsToCheck.add(path)
      else:
        discard

        
      
       
