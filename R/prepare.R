#' prepare Function
#'
#' Basic handling for PI raw datasets.
#'
#' This is one of the main function of GMDPP package. It will take the raw data object
#' you get from the takeFive, transform them into formats that required
#' by PI reseseach team(Insert link here). It will also return necessary variables
#' that include information that you will find handy in later data cleaning.
#' @param rawPack A PI object, included elements like Explicit, Sessions, Tasks, IAT and Demo which representing the original five datasets(required to process) and further addon variables(optional).
#' @keywords Data pre-analysis
#' @export
#' @examples
#'  \dontrun{
#'			rawData <- takeFive('~/explicit.txt','~/iat.txt','~/sessions.txt','~/sessionTasks.txt','~/demographics.txt','mTurk')
#'      prepare(rawData)
#'    }
#' @seealso  \code{\link{~/Requirements}} For files naming consistency and dataset cleaning requirements.
#' @return If it works correctly, there will be an objects return as original datasets and extra elements for reference. They are: $Explicit, $IAT, $Sessions, $Tasks and $Demo for actual datasets, and $participant_id $participatedNum $completedID $completedNum etc.



prepare <- function(rawPack) {
		sortedPack <- list()
		class(sortedPack) <- "PI"

		# Sort Sessions files and prepare to get the MTurk ID
		ID_Sessions <- rawPack$Sessions[order(rawPack$Sessions$session_id),]

		# Get participant's MTurk ID Table
		id <- strsplit(as.character(ID_Sessions$referrer), "!!!", fixed = T)
		maxLen <- max(sapply(id, length))
		id_try <- do.call('data.frame', lapply(id, function(x)c(x, rep(NA, maxLen-length(x)))))
		MTurk_ID <- t(id_try)[,3]
		HIT_ID <- t(id_try)[,2]
		ID <- cbind(ID_Sessions$session_id, MTurk_ID, HIT_ID)
		colnames(ID) <- c("session_id","participant_id", "HIT_id")

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
		sortedPack$Source <- rawPack$Source
		sortedPack$Type <- "sorted_data"
		sortedPack$Last_time <- Sys.time()
		return(sortedPack)
}
