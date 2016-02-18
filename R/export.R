#' export Function
#'
#' Export dataset with readme file.
#'
#' This is the final step of data cleaning. It will take the raw data object
#' you get from the takeFive, transform them into formats that required
#' by PI reseseach team(Insert link here). It will also return necessary variables
#' that include information that you will find handy in later data cleaning.
#' @param readyPack A PI object, included elements like Explicit, Sessions, Tasks, IAT and Demo which representing the original five datasets(required to process) and further addon variables(optional).
#' @keywords Data pre-analysis
#' @export
#' @examples
#'  \dontrun{
#'			rawData <- takeFive('~/explicit.txt','~/iat.txt','~/sessions.txt','~/sessionTasks.txt','~/demographics.txt','mTurk')
#'      prepare(rawData)
#'    }
#' @seealso  \code{\link{~/Requirements}} For files naming consistency and dataset cleaning requirements.
#' @return If it works correctly, there will be an objects return as original datasets and extra elements for reference. They are: $Explicit, $IAT, $Sessions, $Tasks and $Demo for actual datasets, and $participant_id $participatedNum $completedID $completedNum etc.

export <- function(readyPack) {
  takeName <- function(){
    #Ask for user input
    info <- cat("Please type in the name of the dataset:")
    x <- readline(prompt = info)
    #Return
    return(x)
  }
  collectedDate <- function(){
    #Ask for user input
    info <- cat("Data collected by(Date)?:")
    x <- readline(prompt = info)
    #Return
    return(x)
  }
  handledBy <- function(){
    #Ask for user input
    info <- cat("Dataset handled by?:")
    x <- readline(prompt = info)
    #Return
    return(x)
  }
  if (!(exists('Name', where=readyPack))) readyPack$Name <- takeName()
  if (!(exists('Collected_date', where=readyPack))) readyPack$Collected_date <- collectedDate()
  if (!(exists('Handled_by', where=readyPack))) readyPack$Handled_by <- handledBy()

  # Create a folder for output
  dataFolder <- paste(readyPack$Name,"_",readyPack$Type,"_",readyPack$Collected_date, sep="")
  dataFolder
  dir.create(dataFolder,showWarnings = FALSE)
  # Create a new README files
  readME <- paste(dataFolder,"/README.txt", sep="")
  file.create(readME)
  sink(readME)
  # Input File meta information
  summary(readyPack)
  nList <- names(readyPack)
  cat("Basic Information:\n\n\n")
  cat("Data Files List:\n")
  for (i in nList) {
    if (is.data.frame(readyPack[[i]])) {
      dataFile <- paste(dataFolder,"/",i,".csv", sep="")
      write.csv(readyPack[[i]],file = dataFile, col.names = F, row.names = F)
      cat("\t",i,"dataset\t",dataFile,"\n")
    }
  }
  cat("Group Labels:\n\n\n")
  cat("Measures included & Scoring:\n\n\n")
  cat("Variables list and brief description:\n\n\n")
  cat("Cleaning procedure:\n\n\n")
  sink()
  return (TRUE)
}
