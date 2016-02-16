#' unFinished Function
#'
#' Main data cleaning function for PI datasets.
#'
#' This is one of the main function of GMDPP package. It will take the sorted
#' data object and automatically detect the unfinished and duplicated cases.
#' Unfinished cases will be cleaned out by default, with cases' total number and IDs
#' recorded. Duplicated cases will be counted and a ratio will be reported to screen
#' as a reference for further data cleaning. You can choose to automatically
#' clean out all the cases with duplicated data(suggested when the percetage of duplication
#' is low and you get enough data for your analysis), or stop the auto cleaning
#' and start cleaning duplicated data with the information returned(semi-cleaned data object and
#' the duplicatedNum and duplicatedID variables)
#' @param sortedPack A PI object, included subfields like Explicit, Sessions, Tasks, IAT and Demo which representing the original five datasets(required to process) and further addon variables like participatedID, participatedNum etc(optional).
#' @keywords Data cleaning
#' @export
#' @examples
#'  \dontrun{
#'			rawData <- takeFive('~/explicit.txt','~/iat.txt','~/sessions.txt','~/sessionTasks.txt','~/demographics.txt','mTurk')
#'      sortedData <- prepare(rawData)
#'      cleanse(sortedData)
#'    }
#' @seealso  \code{\link{~/Requirements}} For files naming consistency and dataset cleaning requirements.
#' @return If it works correctly, there will be an objects return as original datasets and extra elements for reference. They are: $Explicit, $IAT, $Sessions, $Tasks and $Demo for actual datasets, and $participant_id $participatedNum $completedID $completedNum etc.

cleanse <- function(sortedPack) {

  completedPack <- list()
  class(completedPack) <- "PI"

  # Clean out unfinished cases
  # Definition of unfinished cases: 1\ Did not get to the debriefing 2\ Has less
  # task_number than it should have (If a participant get to defriefing, it is
  # very unlikly that his/her data will have less session that usual. The criteria
  # No.2 is used as precaucious move here.)

  tasksNum <- sortedPack$Tasks[which(sortedPack$Tasks$task_id == 'debriefing'),]$task_number
  endNote <- strtoi(tasksNum[1])
  lastSession <- strtoi(tasksNum[1]) - 1
  tempID <- sortedPack$Tasks[which(sortedPack$Tasks$task_number == toString(lastSession)),]$participant_id

  uniqueID <- unique(tempID)
  tasksCount <- sapply(uniqueID, function(x) nrow(sortedPack$Tasks[which(sortedPack$Tasks$participant_id == x),]))
  if (length(which(tasksCount <= endNote))==0) (completedID <- uniqueID) else (completedID <- uniqueID[-which(tasksCount <= endNote)])
  completedNum <- length(completedID)

  unfinishedID <- sortedPack$participatedID[-which(sortedPack$participatedID %in% completedID)]
  unfinishedNum <- length(unfinishedID)

  # Subsetting all the datasets with only completed participants' data
  completedExplicit <- sortedPack$Explicit[sortedPack$Explicit$participant_id %in% completedID,]
  completedSessions <- sortedPack$Sessions[sortedPack$Sessions$participant_id %in% completedID,]
  completedTasks <- sortedPack$Tasks[sortedPack$Tasks$participant_id %in% completedID,]
  completedDemo <- sortedPack$Demo[sortedPack$Demo$participant_id %in% completedID,]
  completedIAT <- sortedPack$IAT[sortedPack$IAT$participant_id %in% completedID,]

 # Output-----------------------------------------------------------------------------------------

  # Prepare for output if duplication is high
  completedPack$Explicit <- completedExplicit
  completedPack$Sessions <- completedSessions
  completedPack$Tasks <- completedTasks
  completedPack$Demo <- completedDemo
  completedPack$IAT <- completedIAT

  # Added new reference variables for completed Objects
  completedPack$participatedID <- sortedPack$participatedID
  completedPack$participatedNum <- sortedPack$participatedNum
  completedPack$completedID <- completedID
  completedPack$completedNum <- completedNum
  completedPack$unfinishedID <- unfinishedID
  completedPack$unfinishedNum <- unfinishedNum
  if (exists('duplicatedID',where=sortedPack)) completedPack$duplicatedID <- sortedPack$duplicatedID
  if (exists('duplicatedNum',where=sortedPack)) completedPack$duplicatedNum <- sortedPack$duplicatedNum
  if (exists('unDuplicatedID',where=sortedPack)) completedPack$unDuplicatedID <- sortedPack$unDuplicatedID
  if (exists('unDuplicatedNum',where=sortedPack)) completedPack$unDuplicatedNum <- sortedPack$unDuplicatedNum
  completedPack$Type <- sortedPack$Type


  # Added new reference variables for non-cleaned Objects
  sortedPack$completedID <- completedID
  sortedPack$completedNum <- completedNum
  sortedPack$unfinishedID <- unfinishedID
  sortedPack$unfinishedNum <- unfinishedNum 

  unfinishedRatio <- unfinishedNum / sortedPack$participatedNum

  output <- function(unfinishedRatio,unfinishedNum,participatedNum){

    #Ask for user input
    info <- cat("The percentage of unfinished participants is: ", unfinishedRatio*100,"%, ", unfinishedNum," out of ",participatedNum," enrolled participants. Would you like to cleanout unfinished participants automatically?[Y/N]")
    x <- readline(prompt = info)
    while (!((x == "Y")|(x=="N"))) {x <- readline(prompt = "I don't get it. Would you like to cleanout duplication automatically?[Y/N]")}
    #Return
    return(x)
  }
  flag <- output(unfinishedRatio, unfinishedNum, participatedNum)
  if (flag == "Y") return(completedPack) else return (completedPack)
}
