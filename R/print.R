#' print.PI Function
#'
#' Print method for PI objects.
#'
#' This is a small function to help print the PI object more effectively.
#' @param rawPack A PI object, included subfields like Explicit, Sessions, Tasks, IAT and Demo which representing the original five datasets(required to process) and further addon variables(optional).
#' @keywords print datasets
#' @export
#' @examples
#'  \dontrun{
#'			rawData <- takeFive('~/explicit.txt','~/iat.txt','~/sessions.txt','~/sessionTasks.txt','~/demographics.txt','mTurk')
#'      print(prepare(rawData))
#'    }
#' @seealso  \code{\link{~/Requirements}} For files naming consistency and dataset cleaning requirements.
#' @return To Be Specified.


print.PI <- function(dataPack) {
  nList <- names(dataPack)
  for (i in nList) {
    if (is.data.frame(dataPack[[i]])) View(dataPack[[i]])
  }
  cat("The dataset is from ",dataPack$Source,"\n")
  cat("Data Cleaning Stage: ", dataPack$Type, "\n")
  cat("Last editing time: ", as.character(as.POSIXlt(dataPack$Last_time)),"\n")
  output <- function(){
    #Ask for user input
    info <- cat("Do you want to print all the datasets?[Y/N]")
    x <- readline(prompt = info)
    while (!((x == "Y")|(x=="N"))) {x <- readline(prompt = "I don't get it. Do you want to print all the datasets?[Y/N]")}
    #Return
    return(x)
  }
  if (output() == "Y") {
    for (i in nList) {
      if (is.data.frame(dataPack[[i]])) {
        cat("x$",i,": ",i," measure dataset\n")
        print(dataPack[[i]])
      }
    }
  }
  if (exists('participatedNum',where=dataPack)) cat("x$participatedNum:\n\t",dataPack$participatedNum,"\n")
  if (exists('completedNum',where=dataPack)) cat("x$completedNum:\n\t",dataPack$completedNum,"\n")
  if (exists('duplicatedNum',where=dataPack)) cat("x$duplicatedNum:\n\t",dataPack$duplicatedNum,"\n")
  if (exists('participatedID',where=dataPack)) cat("Participated subject ID is avaliable (Variable name:X$participatedID).\n")
  if (exists('completedID',where=dataPack)) cat("Completed subject ID is avaliable (Variable name:X$completedID).\n")
  if (exists('duplicatedID',where=dataPack)) cat("Subject ID for duplicated data is avaliable (Variable name:X$duplicatedID).\n")
}
