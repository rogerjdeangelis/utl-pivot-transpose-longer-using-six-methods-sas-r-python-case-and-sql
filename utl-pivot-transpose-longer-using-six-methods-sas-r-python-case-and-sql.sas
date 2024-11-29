%let pgm=utl-pivot-transpose-longer-using-six-methods-sas-r-python-case-and-sql;

Pivot transpose longer using six methods sas r python case and sql


            SOLUTIONS

               1 sas proc transpose
               2 sas gather macro
               3 sas sql
               4 python sql (hardcoded, too difficulkt to insert generated code into python sql?)
               5 r sql
               6 related repos

github
https://tinyurl.com/57zckfpf
https://github.com/rogerjdeangelis/utl-pivot-transpose-longer-using-six-methods-sas-r-python-case-and-sql

stackoverflow r
https://stackoverflow.com/questions/79233447/alternatives-to-reshape2melt-for-matrices-with-named-rows-columns

related repo
https://github.com/rogerjdeangelis/utl-sas-proc-transpose-wide-to-long-in-sas-wps-r-python-native-and-sql

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                       |                                                      |                         */
/*                INPUT                  |   PROCESS                                            |  OUTPUT (SAS SQL)       */
/*                                       |                                                      |                         */
/*                                       |                                                      |                         */
/*    LTR    A     B     C     D     E   | SAS TRANSPOSE                                        |  ORDER NOT THE SAME     */
/*                                       | =============                                        |  IN ALL SOLUTIONS)      */
/*     F     1     6    11    16    21   |                                                      |                         */
/*     G     2     7    12    17    22   | proc transpose data=sd1.have out=havxpo;             |                         */
/*     H     3     8    13    18    23   | by ltr;                                              |  SAS SQL SOLUTION       */
/*     I     4     9    14    19    24   | run;quit;                                            |                         */
/*     J     5    10    15    20    25   |                                                      |                         */
/*                                       |                                                      |   LTR    VAR     VAL    */
/*                                       | SAS GATHER MACRO                                     |                         */
/* options validvarname=upcase;          | ================                                     |     F      A       1    */
/* libname sd1 "d:/sd1";                 |                                                      |     G      A       2    */
/* data sd1.have;                        | %utl_gather(sd1.have,var,val,ltr,havXpo);            |     H      A       3    */
/* input LTR$  a b c d e ;               |                                                      |     I      A       4    */
/* cards4;                               |                                                      |     J      A       5    */
/* F 01 06 11 16 21                      |                                                      |     F      B       6    */
/* G 02 07 12 17 22                      | SAS SQL                                              |     G      B       7    */
/* H 03 08 13 18 23                      | ======                                               |     H      B       8    */
/* I 04 09 14 19 24                      |                                                      |     I      B       9    */
/* J 05 10 15 20 25                      | %do_over(_var,phrase=%str                            |     J      B      10    */
/*    ;;;;                               |   (select                                            |     F      C      11    */
/* run;quit;                             |     "?" As Var                                       |     G      C      12    */
/*                                       |    ,?   As Val                                       |     H      C      13    */
/*                                       |   From                                               |     I      C      14    */
/*                                       |     sd1.have), between=union all                     |     J      C      15    */
/*                                       |   )                                                  |     F      D      16    */
/*                                       |                                                      |     G      D      17    */
/*                                       | PYTHON HARDCODED                                     |     H      D      18    */
/*                                       | ================                                     |     I      D      19    */
/*                                       |                                                      |     J      D      20    */
/*                                       | select 'A' as Var ,a as Val From have union all \    |     F      E      21    */
/*                                       | select 'B' as Var ,b as Val From have union all \    |     G      E      22    */
/*                                       | select 'C' as Var ,c as Val From have union all \    |     H      E      23    */
/*                                       | select 'D' as Var ,d as Val From have union all  \   |     I      E      24    */
/*                                       | select 'E' as Var ,e as Val From have \              |     J      E      25    */
/*                                       |                                                      |                         */
/*                                       |                                                      |                         */
/*                                       | R SQL                                                |                         */
/*                                       | =====                                                |                         */
/*                                       |                                                      |                         */
/*                                       | GENERATE SQL COD                                     |                         */
/*                                       |                                                      |                         */
/*                                       | %let code=%qsysfunc(compbl("                         |                         */
/*                                       |   %do_over(_var,phrase=%str                          |                         */
/*                                       |      (select                                         |                         */
/*                                       |        `?` As Var                                    |                         */
/*                                       |       ,?   As Val                                    |                         */
/*                                       |      From                                            |                         */
/*                                       |        have), between=union all                      |                         */
/*                                       |      )"));                                           |                         */
/*                                       |                                                      |                         */
/*                                       | %put &=code;                                         |                         */
/*                                       |                                                      |                         */
/*                                       |                                                      |                         */
/*                                       | c=&code;                                             |                         */
/*                                       | want=sqldf(c);                                       |                         */
/*                                       |                                                      |                         */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
input LTR$  a b c d e ;
cards4;
F 01 06 11 16 21
G 02 07 12 17 22
H 03 08 13 18 23
I 04 09 14 19 24
J 05 10 15 20 25
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  LTR    A     B     C     D     E                                                                                      */
/*                                                                                                                        */
/*   F     1     6    11    16    21                                                                                      */
/*   G     2     7    12    17    22                                                                                      */
/*   H     3     8    13    18    23                                                                                      */
/*   I     4     9    14    19    24                                                                                      */
/*   J     5    10    15    20    25                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                                         _
/ |  ___  __ _ ___   _ __  _ __ ___   ___ | |_ _ __ __ _ _ __  ___ _ __   ___  ___  ___
| | / __|/ _` / __| | `_ \| `__/ _ \ / __|| __| `__/ _` | `_ \/ __| `_ \ / _ \/ __|/ _ \
| | \__ \ (_| \__ \ | |_) | | | (_) | (__ | |_| | | (_| | | | \__ \ |_) | (_) \__ \  __/
|_| |___/\__,_|___/ | .__/|_|  \___/ \___| \__|_|  \__,_|_| |_|___/ .__/ \___/|___/\___|
                    |_|                                           |_|
*/

proc transpose data=sd1.have out=havxpo;
by ltr;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* LTR    _NAME_    COL1                                                                                                  */
/*                                                                                                                        */
/*  F       A         1                                                                                                   */
/*  F       B         6                                                                                                   */
/*  F       C        11                                                                                                   */
/*  F       D        16                                                                                                   */
/*  F       E        21                                                                                                   */
/*  G       A         2                                                                                                   */
/*  G       B         7                                                                                                   */
/*  G       C        12                                                                                                   */
/*  G       D        17                                                                                                   */
/*  G       E        22                                                                                                   */
/*  H       A         3                                                                                                   */
/*  H       B         8                                                                                                   */
/*  H       C        13                                                                                                   */
/*  H       D        18                                                                                                   */
/*  H       E        23                                                                                                   */
/*  I       A         4                                                                                                   */
/*  I       B         9                                                                                                   */
/*  I       C        14                                                                                                   */
/*  I       D        19                                                                                                   */
/*  I       E        24                                                                                                   */
/*  J       A         5                                                                                                   */
/*  J       B        10                                                                                                   */
/*  J       C        15                                                                                                   */
/*  J       D        20                                                                                                   */
/*  J       E        25                                                                                                   */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                                _   _
|___ \   ___  __ _ ___    __ _  __ _| |_| |__   ___ _ __
  __) | / __|/ _` / __|  / _` |/ _` | __| `_ \ / _ \ `__|
 / __/  \__ \ (_| \__ \ | (_| | (_| | |_| | | |  __/ |
|_____| |___/\__,_|___/  \__, |\__,_|\__|_| |_|\___|_|
                         |___/
*/

%utl_gather(sd1.have,var,val,ltr,havXpo,valformat=2.);

 /**************************************************************************************************************************/
 /*                                                                                                                        */
 /* LTR    VAR    VAL                                                                                                      */
 /*                                                                                                                        */
 /*  F      A       1                                                                                                      */
 /*  F      B       6                                                                                                      */
 /*  F      C      11                                                                                                      */
 /*  F      D      16                                                                                                      */
 /*  F      E      21                                                                                                      */
 /*  G      A       2                                                                                                      */
 /*  G      B       7                                                                                                      */
 /*  G      C      12                                                                                                      */
 /*  G      D      17                                                                                                      */
 /*  G      E      22                                                                                                      */
 /*  H      A       3                                                                                                      */
 /*  H      B       8                                                                                                      */
 /*  H      C      13                                                                                                      */
 /*  H      D      18                                                                                                      */
 /*  H      E      23                                                                                                      */
 /*  I      A       4                                                                                                      */
 /*  I      B       9                                                                                                      */
 /*  I      C      14                                                                                                      */
 /*  I      D      19                                                                                                      */
 /*  I      E      24                                                                                                      */
 /*  J      A       5                                                                                                      */
 /*  J      B      10                                                                                                      */
 /*  J      C      15                                                                                                      */
 /*  J      D      20                                                                                                      */
 /*  J      E      25                                                                                                      */
 /*                                                                                                                        */
 /**************************************************************************************************************************/

/*____                             _
|___ /   ___  __ _ ___   ___  __ _| |
  |_ \  / __|/ _` / __| / __|/ _` | |
 ___) | \__ \ (_| \__ \ \__ \ (_| | |
|____/  |___/\__,_|___/ |___/\__, |_|
                                |_|
*/

%array(_var,values=a b c d e);

proc sql;
  create
     table want as
  %do_over(_var,phrase=%str
     (select
       ltr
      ,"?" As Var
      ,?   As Val
     From
       sd1.have)
     , between=union all
     )
  order
     by var, ltr
;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  LTR    VAR    VAL                                                                                                     */
/*                                                                                                                        */
/*   F      a       1                                                                                                     */
/*   G      a       2                                                                                                     */
/*   H      a       3                                                                                                     */
/*   I      a       4                                                                                                     */
/*   J      a       5                                                                                                     */
/*   F      b       6                                                                                                     */
/*   G      b       7                                                                                                     */
/*   H      b       8                                                                                                     */
/*   I      b       9                                                                                                     */
/*   J      b      10                                                                                                     */
/*   F      c      11                                                                                                     */
/*   G      c      12                                                                                                     */
/*   H      c      13                                                                                                     */
/*   I      c      14                                                                                                     */
/*   J      c      15                                                                                                     */
/*   F      d      16                                                                                                     */
/*   G      d      17                                                                                                     */
/*   H      d      18                                                                                                     */
/*   I      d      19                                                                                                     */
/*   J      d      20                                                                                                     */
/*   F      e      21                                                                                                     */
/*   G      e      22                                                                                                     */
/*   H      e      23                                                                                                     */
/*   I      e      24                                                                                                     */
/*   J      e      25                                                                                                     */
/**************************************************************************************************************************/

/*  _                 _   _                             _
| || |    _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
| || |_  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
|__   _| | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
   |_|   | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
         |_|    |___/                                |_|
*/


proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read());
have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');
want=pdsql(''' \
     select ltr ,'A' as Var ,a as Val From have union all \
     select ltr ,'B' as Var ,b as Val From have union all \
     select ltr ,'C' as Var ,c as Val From have union all \
     select ltr ,'D' as Var ,d as Val From have union all  \
     select ltr ,'E' as Var ,e as Val From have \
     order by var, ltr \
   ''');
print(want);
fn_tosas9x(want,outlib='d:/sd1/',outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*                     |                                                                                                  */
/* PYTHON              |   SAS                                                                                            */
/*                     |                                                                                                  */
/*     LTR Var   Val   |   LTR    VAR    VAL                                                                              */
/*                     |                                                                                                  */
/*  0    F   A   1.0   |    F      A       1                                                                              */
/*  1    G   A   2.0   |    G      A       2                                                                              */
/*  2    H   A   3.0   |    H      A       3                                                                              */
/*  3    I   A   4.0   |    I      A       4                                                                              */
/*  4    J   A   5.0   |    J      A       5                                                                              */
/*  5    F   B   6.0   |    F      B       6                                                                              */
/*  6    G   B   7.0   |    G      B       7                                                                              */
/*  7    H   B   8.0   |    H      B       8                                                                              */
/*  8    I   B   9.0   |    I      B       9                                                                              */
/*  9    J   B  10.0   |    J      B      10                                                                              */
/*  10   F   C  11.0   |    F      C      11                                                                              */
/*  11   G   C  12.0   |    G      C      12                                                                              */
/*  12   H   C  13.0   |    H      C      13                                                                              */
/*  13   I   C  14.0   |    I      C      14                                                                              */
/*  14   J   C  15.0   |    J      C      15                                                                              */
/*  15   F   D  16.0   |    F      D      16                                                                              */
/*  16   G   D  17.0   |    G      D      17                                                                              */
/*  17   H   D  18.0   |    H      D      18                                                                              */
/*  18   I   D  19.0   |    I      D      19                                                                              */
/*  19   J   D  20.0   |    J      D      20                                                                              */
/*  20   F   E  21.0   |    F      E      21                                                                              */
/*  21   G   E  22.0   |    G      E      22                                                                              */
/*  22   H   E  23.0   |    H      E      23                                                                              */
/*  23   I   E  24.0   |    I      E      24                                                                              */
/*  24   J   E  25.0   |    J      E      25                                                                              */
/*                     |                                                                                                  */
/**************************************************************************************************************************/

/*___                     _
| ___|   _ __   ___  __ _| |
|___ \  | `__| / __|/ _` | |
 ___) | | |    \__ \ (_| | |
|____/  |_|    |___/\__, |_|
                       |_|
*/

%let code=%qsysfunc(compbl("
  %do_over(_var,phrase=%str
     (select
       ltr
      ,`?` As Var
      ,?   As Val
     From
       have), between=union all
     )
  order
     by  var, ltr
     "));

%put &=code;

/*---
CODE=" select ltr ,`a` As Var ,a As Val From have union all
       select ltr ,`b` As Var ,b As Val From have union all
       select ltr ,`c` As Var ,c As Val From have union all
       select ltr ,`d` As Var ,d As Val From have union all
       select ltr ,`e` As Var ,e As Val From have
       order by var, ltr "
---*/

proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_submit_r64x('
library(haven);
library(sqldf);
source("c:/oto/fn_tosas9x.R");
options(width = 255);
have<-read_sas("d:/sd1/have.sas7bdat");
have;
c=&code;
want=sqldf(c);
want;
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
',resolve=Y);


proc print data=sd1.rwant;
run;quit;

/**************************************************************************************************************************/
/*                                                           |                                                            */
/*  OUTPUT (GENERATED CODE)                                  |                                                            */
/*                                                           |                                                            */
/*  CODE=                                                    |                                                            */
/*  "select ltr ,`a` As Var ,a As Val From have union all    |                                                            */
/*   select ltr ,`b` As Var ,b As Val From have union all    |                                                            */
/*   select ltr ,`c` As Var ,c As Val From have union all    |                                                            */
/*   select ltr ,`d` As Var ,d As Val From have union all    |                                                            */
/*   select ltr ,`e` As Var ,e As Val From have              |                                                            */
/*   order by var, ltr "                                     |                                                            */
/*                                                           |                                                            */
/* R                                                         |     SAS                                                    */
/*                                                           |                                                            */
/*     LTR Var Val                                           |     ROWNAMES    LTR    VAR    VAL                          */
/*                                                           |                                                            */
/*  1    F   a   1                                           |         1        F      a       1                          */
/*  2    G   a   2                                           |         2        G      a       2                          */
/*  3    H   a   3                                           |         3        H      a       3                          */
/*  4    I   a   4                                           |         4        I      a       4                          */
/*  5    J   a   5                                           |         5        J      a       5                          */
/*  6    F   b   6                                           |         6        F      b       6                          */
/*  7    G   b   7                                           |         7        G      b       7                          */
/*  8    H   b   8                                           |         8        H      b       8                          */
/*  9    I   b   9                                           |         9        I      b       9                          */
/*  10   J   b  10                                           |        10        J      b      10                          */
/*  11   F   c  11                                           |        11        F      c      11                          */
/*  12   G   c  12                                           |        12        G      c      12                          */
/*  13   H   c  13                                           |        13        H      c      13                          */
/*  14   I   c  14                                           |        14        I      c      14                          */
/*  15   J   c  15                                           |        15        J      c      15                          */
/*  16   F   d  16                                           |        16        F      d      16                          */
/*  17   G   d  17                                           |        17        G      d      17                          */
/*  18   H   d  18                                           |        18        H      d      18                          */
/*  19   I   d  19                                           |        19        I      d      19                          */
/*  20   J   d  20                                           |        20        J      d      20                          */
/*  21   F   e  21                                           |        21        F      e      21                          */
/*  22   G   e  22                                           |        22        G      e      22                          */
/*  23   H   e  23                                           |        23        H      e      23                          */
/*  24   I   e  24                                           |        24        I      e      24                          */
/*  25   J   e  25                                           |        25        J      e      25                          */
/*                                                           |                                                            */
/**************************************************************************************************************************/

/*__
 / /_     ___ _ __   ___  ___
| `_ \   / _ \ `_ \ / _ \/ __|
| (_) | |  __/ |_) | (_) \__ \
 \___/   \___| .__/ \___/|___/
             |_|
*/

https://github.com/rogerjdeangelis/utl-transposing-rows-to-columns-using-proc-sql-partitioning

https://github.com/rogerjdeangelis/utl-sas-proc-transpose-in-sas-r-wps-python-native-and-sql-code
https://github.com/rogerjdeangelis/utl-sas-proc-transpose-wide-to-long-in-sas-wps-r-python-native-and-sql

https://github.com/rogerjdeangelis/utl-classic-problem-with-proc-transpose-and-mutiple-variables-seven-solutions
https://github.com/rogerjdeangelis/utl-pivot-multiple-columns-to-long-format-untranspose
https://github.com/rogerjdeangelis/wps-pivot-longer-transpose--using-r-and-wps-loops
https://github.com/rogerjdeangelis/utl-normalizing-multiple-horizontal-arrays-of-variables-using-macro-untranspose
https://github.com/rogerjdeangelis/utl-untransposing-several-variables-into-name-value-pairs
https://github.com/rogerjdeangelis/utl-Untransposing-wide-to-log-with-1-line-of-code
https://github.com/rogerjdeangelis/utl-using-sas-gather-macro-to-untranspose-a-fat-dataset-into-one-obsevation
https://github.com/rogerjdeangelis/utl-untranspose-mutiple-arrays-fat-to-skinny-or-normalize
https://github.com/rogerjdeangelis/utl-transposing-normalizing-a-table-using-four-techniques-arrays-untranspose-transpose-and-gather
https://github.com/rogerjdeangelis/utl-classic-untranspose-problem-posted-in-stackoverflow-r
https://github.com/rogerjdeangelis/utl-normalize-a-table-with-many-columns-flexible-transpose
https://github.com/rogerjdeangelis/utl-pivot-multiple-columns-to-long-format-untranspose
https://github.com/rogerjdeangelis/utl-the-all-powerfull-proc-report-to-create-transposed-sorted-and-summarized-output-datasets
https://github.com/rogerjdeangelis/utl-three-algorithms-to-transpose-sets-of-variables
https://github.com/rogerjdeangelis/utl-transpose-mutiple-sets-of-variable-fast-macro-transpose
https://github.com/rogerjdeangelis/utl-using-sas-gather-macro-to-untranspose-a-fat-dataset-into-one-obsevation
https://github.com/rogerjdeangelis/utl_flexible_complex_multi-dimensional_transpose_using_one_proc_report
https://github.com/rogerjdeangelis/utl_techniques_to_transpose_and_stack_multiple_variables
https://github.com/rogerjdeangelis/utl_transposing_multiple_variables_with_different_ids_a_single_transpose_cannot_do_this
https://github.com/rogerjdeangelis/utl-fast-normalization-and-join-using-vvaluex-arrays-sql-hash-untranspose-macro
https://github.com/rogerjdeangelis/utl-simple-transpose-of-two-variables-using-normalization-gather-and-untranspose


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
