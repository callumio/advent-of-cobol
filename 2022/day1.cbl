       IDENTIFICATION DIVISION.
       PROGRAM-ID. AOC-2022-1.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
              FILE-CONTROL.
              SELECT ELVES ASSIGN TO 'inputs/day1.txt'
              ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD ELVES.
           01 ELF-STRING PIC X(8).
       WORKING-STORAGE SECTION.
           01 STATE.
             05 FINISHED PIC X VALUE "n".
             05 INPUT-VALUE PIC 9(8).
             05 PTR PIC 9(8) VALUE 1.
             05 LIST-ELVES OCCURS 200 TIMES.
               10 ELF-CALORIES PIC 9(8).
             05 TOTAL-CALORIES PIC 9(8) VALUE 0.
       PROCEDURE DIVISION.
           MAIN.
               OPEN INPUT ELVES.
               PERFORM PROCESS-DATA UNTIL FINISHED = "Y".
               STOP RUN.
           PROCESS-DATA.
               READ ELVES AT END PERFORM FINISH.
               IF ELF-STRING = " " THEN
                   MOVE TOTAL-CALORIES TO ELF-CALORIES(PTR)
                   MOVE 0 TO TOTAL-CALORIES
                   ADD 1 TO PTR
               ELSE
                   MOVE FUNCTION NUMVAL(ELF-STRING) TO INPUT-VALUE
                   ADD INPUT-VALUE TO TOTAL-CALORIES
               END-IF.

           FINISH.
             MOVE 0 TO PTR.
             SORT LIST-ELVES DESCENDING ELF-CALORIES.
             DISPLAY "Task 1: " LIST-ELVES(1).
             MOVE FUNCTION SUM(LIST-ELVES(1) LIST-ELVES(2) LIST-ELVES(3)
             )TO TOTAL-CALORIES.
             DISPLAY "Task 2: " TOTAL-CALORIES.
             CLOSE ELVES.
             MOVE "Y" TO FINISHED.
            
