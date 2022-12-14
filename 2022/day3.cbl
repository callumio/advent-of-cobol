       IDENTIFICATION DIVISION.
       PROGRAM-ID. AOC-2022-3.
       AUTHOR. Callum Leslie.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
           FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO "inputs/day3.txt"
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
           FD INPUT-FILE.
           01 INPUT-STRING PIC X(64).
       WORKING-STORAGE SECTION.
       01 STATE.
         05 WS-FINISHED PIC A VALUE "N".
         05 WS-PRIORITY-CHAR PIC A.
         05 WS-PRIORITY-TOTAL PIC 9(7) OCCURS 2 INDEXED BY INX-B
           VALUE 0.
         05 WS-SPLIT PIC A(64) OCCURS 3.
       01 WS-GROUP OCCURS 2.
           05 WS-GROUP-SPLIT PIC A(64) OCCURS 3.
       01 TALLY.
         05 TALLY-LENGTH PIC 9(2) VALUE 0.
         05 TALLY-FOUND PIC 9(2) VALUE 0.
         05 TALLY-FOUND-C PIC 9(2) VALUE 0.
       77 INX-A VALUE 0 USAGE IS INDEX.
       77 INX-C VALUE 0 USAGE IS INDEX.
       77 INX-D VALUE 0 USAGE IS INDEX.
       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT INPUT-FILE.
           PERFORM UNTIL WS-FINISHED = "Y"
             PERFORM READ-DATA WITH TEST BEFORE VARYING INX-A FROM 1
             BY 1 UNTIL INX-A > 3 OR WS-FINISHED = "Y"
             IF WS-FINISHED = "N"
               SET INX-B TO 2
               PERFORM GET-PRIORITY-CHAR
               SET INX-B TO 1
             END-IF
           END-PERFORM.
              
           DISPLAY WS-PRIORITY-TOTAL(1).
           DISPLAY WS-PRIORITY-TOTAL(2).
           STOP RUN.
       READ-DATA.
           READ INPUT-FILE AT END PERFORM FINISH.
           IF WS-FINISHED = "N"           
             PERFORM PROCESS-DATA.

       PROCESS-DATA.
           MOVE INPUT-STRING TO WS-GROUP-SPLIT(2, INX-A).
           MOVE 0 TO TALLY-LENGTH.

           INSPECT INPUT-STRING TALLYING TALLY-LENGTH FOR TRAILING 
           SPACES.
           COMPUTE TALLY-LENGTH = ((LENGTH OF INPUT-STRING) -
           TALLY-LENGTH) / 2.

           MOVE INPUT-STRING(1 : TALLY-LENGTH) TO WS-GROUP-SPLIT(1,1).
           MOVE INPUT-STRING(TALLY-LENGTH + 1 : TALLY-LENGTH)
           TO WS-GROUP-SPLIT(1,2).
           MOVE WS-GROUP-SPLIT(1,2) TO WS-GROUP-SPLIT(1,3).

           SET INX-B TO 1.
           PERFORM GET-PRIORITY-CHAR.

       GET-PRIORITY-CHAR.
           MOVE 0 TO TALLY-LENGTH

           INSPECT WS-GROUP-SPLIT(INX-B,1) TALLYING TALLY-LENGTH
           FOR TRAILING SPACES.
           COMPUTE TALLY-LENGTH = LENGTH OF WS-GROUP-SPLIT(INX-B,1) -
           TALLY-LENGTH.

           PERFORM WITH TEST BEFORE VARYING INX-C FROM 1 BY 1 UNTIL
             INX-C > TALLY-LENGTH OR TALLY-FOUND = 2
               MOVE 0 TO TALLY-FOUND
               MOVE 0 TO TALLY-FOUND-C
               MOVE WS-GROUP-SPLIT(INX-B,1)(INX-C:1) TO WS-PRIORITY-CHAR
               IF WS-PRIORITY-CHAR IN WS-GROUP-SPLIT(INX-B,2)
                 AND WS-PRIORITY-CHAR IN WS-GROUP-SPLIT(INX-B,3)
                 TALLY-FOUND = 2
               LOCATE
           END-PERFORM.
           MOVE 0 TO TALLY-FOUND.

           COMPUTE WS-PRIORITY-TOTAL(INX-B) = FUNCTION MOD(FUNCTION
           ORD(WS-PRIORITY-CHAR) - 39, 58) + WS-PRIORITY-TOTAL(INX-B).

       FINISH.
           MOVE "Y" TO WS-FINISHED.
           CLOSE INPUT-FILE.
