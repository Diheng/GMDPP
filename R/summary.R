#' Summary method Function
#'
#' \code{sum}
#'
#' This is the main function of GMDPP package. It will take the raw data object
#' you get from the takeFive, transform them into formats that required
#' by PI reseseach team(Insert link here). It will also return necessary variables
#' that include information that you will find handy in later data cleaning.
#' @param rawPack A PI object, included subfields like Explicit, Sessions, Tasks, IAT and Demo which representing the original five datasets(required to process) and further addon variables(optional).
#' @keywords Data pre-analysis
#' @export
#' @examples
#'  \dontrun{
#'			rawData <- takeFive('~/explicit.txt','~/iat.txt','~/sessions.txt','~/sessionTasks.txt','~/demographics.txt','mTurk')
#'      prepare(rawData)
#'    }
#' @seealso  \code{\link{~/Requirements}} For files naming consistency and dataset cleaning requirements.
#' @return To Be Specified.

summary.PI <- function(dataPack) {
  cat("---------------------\n")
  cat("The dataset is from",dataPack$Type,". Basic info see below:\n")
  if (exists('participatedNum',where=dataPack)) cat("---------------------\n\t",dataPack$participatedNum,"participants took the experiment.\n\n")
  if (exists('completedNum',where=dataPack)) {
    cat("\t",dataPack$completedNum,"participants finished the experiment.\n")
    cat("\t Completion Rate:", (dataPack$completedNum / dataPack$participatedNum)*100, "%.\n\n")
  }
  if (exists('duplicatedNum',where=dataPack)) {
    cat("\t",dataPack$duplicatedNum," cases have at least one duplicated data point.\n")
    cat("\t Duplication Rate (among completed subject data): ", (dataPack$duplicatedNum / dataPack$completedNum)*100, "%.\n\n")
  }
  if (exists('cleanedNum', where=dataPack)) {
    cat("\t",dataPack$cleanedNum, " cases are clean and ready to be used.\n\t It takes up",(dataPack$cleanedNum / dataPack$participatedNum)*100,"% of the whole dataset and ", (dataPack$cleanedNum / dataPack$completedNum)*100,"% of the completed subject pool.\n")
  }
  if (exists('participatedID',where=dataPack)) cat("---------------------\nParticipated subject ID is avaliable (Variable name:X$participatedID).\n")
  if (exists('completedID',where=dataPack)) cat("Completed subject ID is avaliable (Variable name:X$completedID).\n")
  if (exists('duplicatedID',where=dataPack)) cat("Subject ID for duplicated data is avaliable (Variable name:X$duplicatedID).\n")
  if (exists('cleanedID',where=dataPack)) cat("Subject ID for cleaned data is avaliable (Variable name:X$cleanedID).\n")
  cat("---------------------\n")
}
