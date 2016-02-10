#' Take Five Function
#'
#' \code{sum} Import the basic five dataset files generated from PI.
#'
#' This function is used to read the all five original dataset files from PI.
#' It is equal to the read function but name differently as a special function
#' only for PI dataset. An object will be returned with all the raw datasets.
#' @param explicit A string for the path of explicit.txt file or the equivalent.
#' @param iat A string for the path of iat.txt file or the equivalent.
#' @param sessions A string for the path of sessions.txt file or the equivalent.
#' @param tasks A string for the path of sessionTasks.txt file or the equivalent.
#' @param demo A string for the path of demographics.txt file or the equivalent.
#' @param type A variable indicating data collection procedure. Possible value: mTurk, PI, PIMH
#' @param strAsFtr Boolean value for stringAsFactors options in importing data. Default to be FALSE.
#' @keywords read import
#' @export
#' @examples
#'  \dontrun{
#'      takeFive('~/explicit.txt','~/iat.txt','~/sessions.txt','~/sessionTasks.txt','~/demographics.txt','mTurk')
#'    }
#' @seealso  \code{\link{~/Requirements}} For files naming consistency and dataset cleaning requirements.
#' @return If all five files are imported correctly, there will be five objects return as original dataset, and there are: explicit_origin, iat_origin, sessions_origin, tasks_origin, demo_origin.

takeFive <- function(explicit,iat,sessions,tasks,demo,type = "MTurk", strAsFtr = FALSE) {
	rawPack <- list() # Build an object for dataset
	class(rawPack) <- "PI"
	rawPack$Explicit <- read.delim(explicit, stringsAsFactors=strAsFtr)
  rawPack$IAT <- read.delim(iat, stringsAsFactors=strAsFtr)
	rawPack$Sessions <- read.delim(sessions, stringsAsFactors=strAsFtr)
	rawPack$Tasks <- read.delim(tasks, stringsAsFactors=strAsFtr)
	rawPack$Demo <- read.delim(demo, stringsAsFactors=strAsFtr)
	rawPack$Type <- type
	return(rawPack)
}
