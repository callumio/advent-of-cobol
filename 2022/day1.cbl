       IDENTIFICATION DIVISION.
       PROGRAM-ID. AOC-2022-1.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
              FILE-CONTROL.
              SELECT INPUT-FILE ASSIGN TO 'inputs/day1.txt'
              ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD INPUT-FILE.
             01 INPUT-STRING PIC X(8).
       WORKING-STORAGE SECTION.
           01 STATE.
             05 FINISHED PIC X VALUE "n".
             05 WS-CALORIES PIC 9(8) OCCURS 3 TIMES VALUE 0.
             05 WS-TOTAL-CALORIES PIC 9(8) VALUE 0.
       PROCEDURE DIVISION.
           MAIN.
               OPEN INPUT INPUT-FILE.
               PERFORM PROCESS-DATA UNTIL FINISHED = "Y".
               DISPLAY "Task 1: " WS-CALORIES(1).
               DISPLAY "Task 2: " FUNCTION SUM(WS-CALORIES(1)
               WS-CALORIES(2) WS-CALORIES(3)).
               STOP RUN.
           PROCESS-DATA.
               READ INPUT-FILE AT END PERFORM FINISH.
               IF INPUT-STRING = " " THEN
                   EVALUATE TRUE
                     WHEN WS-TOTAL-CALORIES IS GREATER THAN
                       WS-CALORIES(1)
                       MOVE WS-CALORIES(2) TO WS-CALORIES(3)
                       MOVE WS-CALORIES(1) TO WS-CALORIES(2)
                       MOVE WS-TOTAL-CALORIES TO WS-CALORIES(1)
                     WHEN WS-TOTAL-CALORIES IS GREATER THAN
                       WS-CALORIES(2) AND WS-TOTAL-CALORIES IS NOT EQUAL
                       TO WS-CALORIES(1)
                       MOVE WS-CALORIES(2) TO WS-CALORIES(3)
                       MOVE WS-TOTAL-CALORIES TO WS-CALORIES(2)
                     WHEN WS-TOTAL-CALORIES IS GREATER THAN
                       WS-CALORIES(3) AND WS-TOTAL-CALORIES IS NOT EQUAL
                       TO WS-CALORIES(2)
                       MOVE WS-TOTAL-CALORIES TO WS-CALORIES(3)
                   END-EVALUATE
                   MOVE 0 TO WS-TOTAL-CALORIES
               ELSE
                 ADD FUNCTION NUMVAL(INPUT-STRING) TO
                 WS-TOTAL-CALORIES
               END-IF.

           FINISH.
             MOVE "Y" TO FINISHED.
             CLOSE INPUT-FILE.
            
