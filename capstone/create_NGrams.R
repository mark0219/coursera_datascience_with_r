require(tm)
require(slam)
require(dplyr)
require(RWeka)

readSample <- function (file, p=0.01) {
    set.seed(0871)
    con <- file(paste('source_data/en_US/', file, sep = ''), open = 'r')
    textFile <- readLines(con)
    close(con)
    n <- length(textFile)
    sampledIdx <- sample(1:n, ceiling(n*p))
    return(textFile[sampledIdx])
}

createNGrams <- function (textFile, n = 1) {
    
    textCleanse <- function (corpus) {
        corpus <- tm_map(corpus, content_transformer(removeNumbers)) %>%
            tm_map(content_transformer(removePunctuation)) %>%
            tm_map(content_transformer(tolower)) %>%
            tm_map(content_transformer(stripWhitespace))
        return(corpus)
    }
    
    nonASCIIidx <- characters.non.ASCII <- grep('textFile', iconv(textFile, "latin1", "ASCII", sub="textFile"))
    textFile <- textFile[-nonASCIIidx]
    
    corpus <- Corpus(VectorSource(textFile))
    corpus <- textCleanse(corpus)
    tdm <- TermDocumentMatrix(corpus, control = list(tokenize = function(x) NGramTokenizer(x, Weka_control(min=n, max=n))))
    NGram <- data.frame(term = as.character(names(row_sums(tdm, na.rm = , dims = 2))),
                        frequency = row_sums(tdm, na.rm = , dims = 2))
    NGram <- NGram[order(NGram$frequency, decreasing = T),]
    rownames(NGram) <- NULL
    
    return(NGram)
    
}

textInput <- c(readSample("en_US.twitter.txt", p = 0.01),
               readSample("en_US.blogs.txt", p = 0.01),
               readSample("en_US.news.txt", p = 0.01))

twoGram <- createNGrams(textInput, n = 2)
threeGram <- createNGrams(textInput, n = 3)
fourGram <- createNGrams(textInput, n = 4)
fiveGram <- createNGrams(textInput, n = 5)

save(twoGram, file = './twoGram.RData')
save(threeGram, file = './threeGram.RData')
save(fourGram, file = './fourGram.RData')
save(fiveGram, file = './fiveGram.RData')






