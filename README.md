# GMDPP

General MTurk Dataset Preparation for PACT Lab (GMDPP)

All data preparation procedure could be found in ~/Requirements.

What has done here:

1\ Read in all the files necessary for data analysis

2\ Prepare the data

3\ unFin and unDu - now the cleansing procedure is separated and designed to be paralled.

4\ Print methods

5\ Summary methods

6\ Entail information like: name of study, dataset collected date, dataset handled date, analysisBy, datatype

7\ Readme and Export - When you export a PI Object, it will automatically write a readme.txt with meta information and a template for README files.


Toolbox kits:

1\ Say Hello - nothing but for fun

2\ takeFive - read in all the data files in correct form for data cleansing.

3\ prepare - read in data object, get rid of unnecessary variables, merge with
  previous sessions, add two components to dataset: participatedID, participatedNum

4\ unFin - check and clean(judgement needed to be made) unfinished cases. The criteria for unfinished cases is not getting to the task immediately precessed "debriefing".

5\ unDu - check and clean(judgement needed to be made) duplicated cases. The criteria for duplicated cases is having more than one entry for the same task_number.

HEAD UP: unFin and unDu are parallel, means that datasets after unDu may contain unfinished cases and vice versa.

5\ print.PI - print out datasets key information and View all the dataset entailed.

6\ summary.PI - print out dataset meta information.

7\ export - export an PI Object will create a folder with name that includes study and time information. All datasets will be written into csv, a README files with meta information will be created.

Reserved elements in a PI Object:

Basic datasets:
$Explicit explicit data files
$IAT iat data files
$Demo demographics data files
$Tasks sessionTasks data files
$Sessions sessions data files

Meta information:
$Name study Name
$Handled_by person who cleaned the data and should turned to for question
$Last_time latest edited time
$Collected_date dataset collected date
$Source mTurk, PI or PIMH
$Type raw_data/sorted_data/working_data/master_data

Index and statistic for data cleaning:
$participatedID who participated in study
$participatedNum how many people participated
$duplicatedID ID for cases that have at least one duplicated data point
$duplicatedNum number of cases that have at least one duplicated data point
$completedID IDs for cases that finished all the tasks in the study
$completedNum number of cases that finished all the tasks in the study
$unfinishedID self-explained
$unfinishedNum self-explained
$unDuplicatedID self-explained
$unDuplicatedNum self-explained

Elements could be added anytime, and all elements that is a data.frame will be printed and exported when the corresponding method is called. Not all the elements will be in used by functions in the package.

Recommended procedure:

1\ Read all datasets with takeFive(), it will includes all the information that is needed(if not, the program will ask you for it).

2\ Use prepare(dataSet) before doing any analysis. You will lose some variables in this process but all cases will be kept.

3\ Use unFin or unDu according to what you want to do. To minimize error, always use unFin or unDu on a dataset that has been prepared by prepare().

4\ Do whatever you want to do after this 1-2-3. At any given time, you can export a PI object.


What need to be added soon:

6A\ transform - may not do it because it is not really necessary

6B\ merge - may not do it because it is not really necessary

7\ autoPilot - not ready

8\ Plot methods

11\ code that handle demo dataset

12\ code that handle different types of datasets (MTurk, finished; PI, unfinished; PIMH, unfinished)
