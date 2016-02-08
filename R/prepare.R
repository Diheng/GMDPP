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


prepare <- function(rawPack,type) {
		sortedPack <- list()
		class(sortedPack) <- "PI"

		# Sort Sessions files and prepare to get the MTurk ID
		ID_Sessions <- rawPack$Sessions[order(rawPack$Sessions$session_id),]

		# Get participant's MTurk ID Table
		group <- strsplit(as.character(ID_Sessions$referrer), "!!!", fixed = T)
		maxLen <- max(sapply(group, length))
		group_try <- do.call('data.frame', lapply(group, function(x)c(x, rep(NA, maxLen-length(x)))))
		MTurk_ID <- t(group_try)[,3]
		ID <- cbind(ID_Sessions$session_id, MTurk_ID)
		colnames(ID) <- c("session_id","participant_id")

		# Add participant_id and Sort all the tables
		# Explicit: Get rid of "feedback" "text" "d"
		tempExplicit <- rawPack$Explicit[-which(rawPack$Explicit$question_name == "feedback" | rawPack$Explicit$question_name == "text" | rawPack$Explicit$question_name == "d"),]
		tempExplicit <- merge(tempExplicit,ID, by="session_id")
		sortedExplicit <- tempExplicit[order(tempExplicit$participant_id, tempExplicit$questionnaire_name, tempExplicit$question_number),]

		# Handle demographics files, omited here:
		sortedDemo <- rawPack$Demo

		# Sessions file:
		tempSessions <- merge(ID_Sessions, ID, by="session_id")
		sortedSessions <- tempSessions[order(tempSessions$participant_id),]

		# Sort sessionTasks files
		tempTasks <- rawPack$Tasks
		tempTasks <- merge(tempTasks, ID, by="session_id")
		sortedTasks <- tempTasks[order(tempTasks$participant_id, tempTasks$task_number),]

		# IAT: Get rid of "block_number","block_trial_count","study_name","task_number","trial_name","trial_response"
		dontNeeded <- names(rawPack$IAT) %in% c("block_number","block_trial_count","study_name","task_number","trial_name","trial_response")
		tempIAT <- rawPack$IAT[!dontNeeded]
		tempIAT <- merge(tempIAT, ID, by="session_id")
		sortedIAT <- tempIAT[order(tempIAT$participant_id,tempIAT$task_name,tempIAT$block_name,tempIAT$trial_number),]

		# Get a list of participatedID and the total number of unique participant

		participatedID <- unique(ID[,2])
		participatedNum <- length(participatedID)

		#Output: Create two more components: participatedID, participatedNum
		sortedPack$Explicit <- sortedExplicit
		sortedPack$Sessions <- sortedSessions
		sortedPack$Tasks <- sortedTasks
		sortedPack$Demo <- sortedDemo
		sortedPack$IAT <- sortedIAT
		sortedPack$participatedID <- participatedID
		sortedPack$participatedNum <- participatedNum
		return(sortedPack)
}
