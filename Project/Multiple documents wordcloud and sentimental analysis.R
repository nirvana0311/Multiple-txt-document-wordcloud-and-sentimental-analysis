require(wordcloud)

folder="C:\\Users\\nirva\\IdeaProjects\\R\\Jalayer data mining part 5\\Project"
fileList=list.files(path = folder,pattern = "*.txt")
fileList=paste(folder,"\\",fileList,sep = "")

corpus=lapply(fileList,FUN = readLines)
corpus=lapply(corpus,FUN = paste,collapse = " ")

corpus=gsub(" ?(f|ht)tp(s?)://(.*)[.|/|&|=][a-zA-z0-9|-]*", "", corpus)
corpus=gsub(pattern = "\\W",replacement = " ",corpus)
corpus=gsub(pattern = "\\d",replacement = " ",corpus)
corpus=tolower(corpus)
corpus=removeWords(corpus,stopwords('en'))
corpus=gsub("\\b[A-z]\\b{1}",replacement = "",corpus)
corpus=stripWhitespace(corpus)

corpus2=Corpus(VectorSource(corpus))
tdm=TermDocumentMatrix(corpus2)
tdmAsMatrix=as.matrix(tdm)
colnames(tdmAsMatrix)=c("Che","euro","mart")
comparison.cloud(tdmAsMatrix)

pos.words=scan("positive-words.txt",what = 'character',comment.char = ';')
neg.words=scan("negative-words.txt",what = 'character',comment.char = ';')

bagOfWords=str_split(corpus,pattern = "\\s+")
lapply(bagOfWords,FUN = function(x){sum(!is.na(match(x,pos.words)))-sum(!is.na(match(x,neg.words)))})
lapply(bagOfWords,FUN = function(x){sum(!is.na(match(x,neg.words)))})

