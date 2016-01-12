#' prepare Function
#' 
#' \code{sum}
#'
#' This is the main function of GMDPP package. It will take all the standard files you will get from PI or MTurk, transform them into formats that required by PI reseseach team(Insert link here). I t will also return necessary variables that include information that you will find handy in later data analysis. 
#' @param type A variable indicating data collection procedure. Possible value: mTurk, PI, PIMH
#' @param explicit A string for the path of explicit.txt file or the equivalent.
#' @param iat A string for the path of iat.txt file or the equivalent.
#' @param sessions A string for the path of sessions.txt file or the equivalent.
#' @param tasks A string for the path of sessionTasks.txt file or the equivalent.
#' @param demo A string for the path of demographics.txt file or the equivalent.
#' @keywords Data pre-analysis
#' @export
#' @examples
#'  \dontrun{
#'      prepare('~/explicit.txt','~/iat.txt','~/sessions.txt','~/sessionTasks.txt','~/demographics.txt', 'mTurk')
#'    }
#' @seealso  \code{\link{~/Requirements}} For files naming consistency and dataset cleaning requirements.
#' @return To Be Specified.


prepare <- function(explicit,iat,sessions,tasks,demo,type) {
	takeFive(explicit,iat,sessions,tasks,demo)
}



