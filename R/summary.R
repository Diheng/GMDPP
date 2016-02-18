#' summary Function
#'
#' Summary method for PI objects.
#'
#' This is a small function to summary main information out of a PI object.
#' @param rawPack A PI object, included subfields like Explicit, Sessions, Tasks, IAT and Demo which representing the original five datasets(required to process) and further addon variables(optional).
#' @keywords summary of datasets
#' @export
#' @examples
#'  \dontrun{
#'			rawData <- takeFive('~/explicit.txt','~/iat.txt','~/sessions.txt','~/sessionTasks.txt','~/demographics.txt','mTurk')
#'      sortedData <- prepare(rawData)
#'      summary(unFin(sortedData))
#'    }
#' @seealso  \code{\link{~/Requirements}} For files naming consistency and dataset cleaning requirements.
#' @return To Be Specified.

summary.PI <- function(dataPack) {
  cat("Mega Information:\n")
  cat("\tStudy Name: ",dataPack$Name, sep= "","\n")
  cat("\tData Source: ", dataPack$Source, sep="","\n")
  cat("\tData Cleaning Stage: ", dataPack$Type, sep="","\n")
  cat("\tData Colleted by: ", dataPack$Collected_date, sep="","\n")
  cat("\tLatest edited by: ", as.character(as.POSIXlt(dataPack$Last_time)), sep="","\n")
  cat("\tEdited by: ", dataPack$Handled_by, sep="","\n")
  cat("\nBasic Information:\n")
  if (exists('participatedNum',where=dataPack)) cat("\t",dataPack$participatedNum," participants took the experiment.\n", sep="")
  if (exists('completedNum',where=dataPack)) {
    cat("\t",dataPack$completedNum," participants finished the experiment.\n", sep="")
    cat("\tCompletion Rate: ", (dataPack$completedNum / dataPack$participatedNum)*100, "%.\n", sep="")
  }
  if (exists('duplicatedNum',where=dataPack)) {
    cat("\t",dataPack$duplicatedNum," cases have at least one duplicated data point.\n",sep="")
    cat("\tDuplication Rate (among completed subject data): ", (dataPack$duplicatedNum / dataPack$completedNum)*100, "%.\n",sep="")
  }
  if (exists('participatedID',where=dataPack)) cat("\nParticipated subject ID is avaliable (Variable name:X$participatedID).\n")
  if (exists('completedID',where=dataPack)) cat("Completed subject ID is avaliable (Variable name:X$completedID).\n")
  if (exists('duplicatedID',where=dataPack)) cat("Subject ID for duplicated data is avaliable (Variable name:X$duplicatedID).\n")
  cat("\n")
}
