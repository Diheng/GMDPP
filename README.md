# GMDPP

General MTurk Dataset Preparation for PACT Lab (GMDPP)


All data preparation procedure could be found in ~/Requirements.

What has done here:

1\ Read in all the files necessary for data analysis

2\ Prepare the data

3\ cleansing the data

4\ Print methods

5\ Summary methods



What need to be added soon:

4\ name of study, dataset collected date, dataset handled date, analysisBy, datatype

5\ Documentation

6A\ transform

6B\ merge

7\ autoPilot

8\ Plot methods

9A\ Readme - create readme documentation automatically

9B\ duplicate and unfinish -- separate this two functions

10\ Export - export completed datasets

11\ code that handle demo dataset

12\ code that handle different types of datasets (MTurk, finished; PI, unfinished; PIMH, unfinished)


Toolbox kits:

1\ Say Hello - nothing but for fun

2\ takeFive - read in all the data files in correct form for data cleansing.

3\ prepare - read in data object, get rid of unnecessary variables, merge with
  previous sessions, add two components to dataset: participatedID, participatedNum

4\ cleanse - read in data object, clean up unfinished data, pick up duplicated data,
  add more components to data object: completedID, completedNum, duplicatedID,
  duplicatedNum

5\ print.PI -

6\ summary.PI -
