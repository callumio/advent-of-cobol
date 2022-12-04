       IDENTIFICATION DIVISION.
       PROGRAM-ID. AOC-2022-4.
       AUTHOR. CALLUM LESLIE.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
           FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO "inputs/day4.txt"
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
           FD INPUT-FILE.
           01 INPUT-STRING PIC X(11).
       WORKING-STORAGE SECTION.
       01 STATE.
         05 WS-FINISHED PIC X VALUE "N".
         05 WS-GROUP OCCURS 2.
           10 WS-GROUP-VALUE PIC 9(2) OCCURS 2 VALUE 0.
         05 WS-TOTAL PIC 9(3) OCCURS 2 VALUE 0.
       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT INPUT-FILE.
           PERFORM GET-DATA UNTIL WS-FINISHED = "Y".
           DISPLAY "Task 1 " WS-TOTAL(1).
           DISPLAY "Task 2 " WS-TOTAL(2).
           STOP RUN.

       GET-DATA.
           READ INPUT-FILE AT END PERFORM FINISH.
           IF WS-FINISHED = "N" THEN
            UNSTRING INPUT-STRING DELIMITED BY "-" OR ","
            INTO WS-GROUP-VALUE(1,1) WS-GROUP-VALUE(1,2)
            WS-GROUP-VALUE(2,1) WS-GROUP-VALUE(2,2)
            END-UNSTRING
            PERFORM PROCESS-DATA
           END-IF.

       PROCESS-DATA.
           IF (WS-GROUP-VALUE(1,1) <= WS-GROUP-VALUE(2,1) AND
             WS-GROUP-VALUE(1,2) >= WS-GROUP-VALUE(2,2)) OR
             (WS-GROUP-VALUE(1,2) <= WS-GROUP-VALUE(2,2) AND
             WS-GROUP-VALUE(1,1) >= WS-GROUP-VALUE(2,1)) THEN
             ADD 1 TO WS-TOTAL(1)
           END-IF.

           IF WS-GROUP-VALUE(1,1) <= WS-GROUP-VALUE(2,2) AND
             WS-GROUP-VALUE(1,2) >= WS-GROUP-VALUE(2,1) THEN
             ADD 1 TO WS-TOTAL(2)
           END-IF.

       FINISH.
           MOVE "Y" TO WS-FINISHED.
           CLOSE INPUT-FILE.
