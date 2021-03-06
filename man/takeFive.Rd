% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/takeFive.R
\name{takeFive}
\alias{takeFive}
\title{takeFive Function}
\usage{
takeFive(explicit, iat, sessions, tasks, demo, source = "MTurk",
  type = "raw_data", strAsFtr = FALSE)
}
\arguments{
\item{explicit}{A string for the path of explicit.txt file or the equivalent.}

\item{iat}{A string for the path of iat.txt file or the equivalent.}

\item{sessions}{A string for the path of sessions.txt file or the equivalent.}

\item{tasks}{A string for the path of sessionTasks.txt file or the equivalent.}

\item{demo}{A string for the path of demographics.txt file or the equivalent.}

\item{source}{A variable indicating data collection procedure. Possible value: mTurk, PI, PIMH}

\item{type}{A variable indicating the data stage}

\item{strAsFtr}{Boolean value for stringAsFactors options in importing data. Default to be FALSE.}
}
\value{
If all five files are imported correctly, there will be an objects return as original datasets, which contain elements: $Explicit, $IAT, $Sessions, $Tasks and $Demo.
}
\description{
Import the basic five dataset files generated from PI.
}
\details{
This function is used to read the all five original dataset files from PI.
It is equal to the read function but name differently as a special function
only for PI dataset. An object will be returned with all the raw datasets.
}
\examples{
 \dontrun{
     takeFive('~/explicit.txt','~/iat.txt','~/sessions.txt','~/sessionTasks.txt','~/demographics.txt','mTurk')
   }
}
\seealso{
\code{\link{~/Requirements}} For files naming consistency and dataset cleaning requirements.
}
\keyword{import}
\keyword{read}

