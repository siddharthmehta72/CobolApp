       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTMERGE.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT  FILEPAY
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT  FILEPAY1
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT  FILEMPAY
               ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  FILEPAY
           VALUE OF FILE-ID IS UW01FILE1-NAME
           LABEL RECORDS ARE STANDARD.
       01  FILEHREC.
           03  FILEHRECTYP             PIC XXX.
           03  FILEHFILEID             PIC XXX.
           03  FILEHFILEDT             PIC 9(8).
           03  FILLER                  PIC X(58).
       01  FILEDREC.
           03  FILEDRECTYP             PIC XXX.
           03  FILEDUFBAID             PIC X(5).
           03  FILEDUFSTXN             PIC 9(4).
           03  FILEDPYMTH              PIC X(3).
           03  FILEDCRDBIN             PIC X.
           03  FILEDTXNTYP             PIC XX.
           03  FILEDEFDTE              PIC 9(8).
           03  FILEDTEXT               PIC X(10).
           03  FILEDMICRNO             PIC 9(6).
           03  FILEDPAYAMT             PIC 9(11).
           03  FILEDUFNMIND            PIC X.
           03  FILEDUFACNO             PIC X(14).
           03  FILEDSUBACC             PIC XX.
           03  FILEDUFRDTP             PIC X.
           03  FILEDUFBRAC             PIC 9(6).
           03  FILLER                  PIC X(3).
       01  FILETREC.
           03  FILETRECTP             PIC XXX.
           03  FILETNOREC             PIC 9(8).
           03  FILETSIGN              PIC X.
           03  FILETTOTAMT            PIC 9(14).
           03  FILLER                 PIC X(54).
       FD  FILEPAY1
           VALUE OF FILE-ID IS UW01FILE2-NAME
           LABEL RECORDS ARE STANDARD.
       01  FILE1HREC.
           03  FILE1HRECTYP             PIC XXX.
           03  FILE1HFILE1ID             PIC XXX.
           03  FILE1HFILE1DT             PIC 9(8).
           03  FILLER                  PIC X(58).
       01  FILE1DREC.
           03  FILE1DRECTYP             PIC XXX.
          03  FILE1DUFBAID             PIC X(5).
           03  FILE1DUFSTXN             PIC 9(4).
           03  FILE1DPYMTH              PIC X(3).
           03  FILE1DCRDBIN             PIC X.
           03  FILE1DTXNTYP             PIC XX.
           03  FILE1DEFDTE              PIC 9(8).
           03  FILE1DTEXT               PIC X(10).
           03  FILE1DMICRNO             PIC 9(6).
           03  FILE1DPAYAMT             PIC 9(11).
           03  FILE1DUFNMIND            PIC X.
           03  FILE1DUFACNO             PIC X(14).
           03  FILE1DSUBACC             PIC XX.
           03  FILE1DUFRDTP             PIC X.
           03  FILE1DUFBRAC             PIC 9(6).
           03  FILLER                  PIC X(3).
       01  FILE1TREC.
           03  FILE1TRECTP             PIC XXX.
           03  FILE1TNOREC             PIC 9(8).
           03  FILE1TSIGN              PIC X.
           03  FILE1TTOTAMT            PIC 9(14).
           03  FILLER                 PIC X(54).
       FD  FILEMPAY
           VALUE OF FILE-ID IS UW01FILE3-NAME
           LABEL RECORDS ARE STANDARD.
       01  FILEMHREC.
           03  FILEMHRECTYP             PIC XXX.
           03  FILEMHFILEMID             PIC XXX.
           03  FILEMHFILEMDT             PIC 9(8).
           03  FILLER                  PIC X(58).
       01  FILEMDREC.
           03  FILEMDRECTYP             PIC XXX.
           03  FILEMDUFBAID             PIC X(5).
           03  FILEMDUFSTXN             PIC 9(4).
           03  FILEMDPYMTH              PIC X(3).
           03  FILEMDCRDBIN             PIC X.
           03  FILEMDTXNTYP             PIC XX.
           03  FILEMDEFDTE              PIC 9(8).
           03  FILEMDTEXT               PIC X(10).
           03  FILEMDMICRNO             PIC 9(6).
           03  FILEMDPAYAMT             PIC 9(11).
           03  FILEMDUFNMIND            PIC X.
           03  FILEMDUFACNO             PIC X(14).
           03  FILEMDSUBACC             PIC XX.
           03  FILEMDUFRDTP             PIC X.
           03  FILEMDUFBRAC             PIC 9(6).
           03  FILLER                  PIC X(3).
       01  FILEMTREC.
           03  FILEMTRECTP             PIC XXX.
           03  FILEMTNOREC             PIC 9(8).
           03  FILEMTSIGN              PIC X.
           03  FILEMTTOTAMT            PIC 9(14).
           03  FILLER                 PIC X(54).
       WORKING-STORAGE SECTION.
       01  UW01APRWDAY             PIC 9(8).
       01  UW01APRWDAYR REDEFINES UW01APRWDAY.
             03 UW01APRWCCYY          PIC 9(4).
             03 UW01APRWMM            PIC 99.
             03 UW01APRWDD            PIC 99.
       01  UW01CNTDR                   PIC 9(8).
       01  UW01CNTTR                   PIC 9(8).
       01  UW01TOTAMT                  PIC 9(14).
       01  UW01TPYAMT                  PIC 9(14).
       01  UW01FILE1-NAME              PIC X(22).
       01  UW01FILE2-NAME              PIC X(22).
       01  UW01FILE3-NAME              PIC X(22).

       PROCEDURE DIVISION.
       LA-CONTROL SECTION.
       LA-10.
           DISPLAY 1 UPON ARGUMENT-NUMBER.
           ACCEPT UW01FILE1-NAME FROM ARGUMENT-VALUE.
           DISPLAY 2 UPON ARGUMENT-NUMBER.
           ACCEPT UW01FILE2-NAME FROM ARGUMENT-VALUE.
           DISPLAY 3 UPON ARGUMENT-NUMBER.
           ACCEPT UW01FILE3-NAME FROM ARGUMENT-VALUE.

           DISPLAY 'FILE1:' UW01FILE1-NAME  UPON PRINTER.
           DISPLAY 'FILE2:' UW01FILE2-NAME  UPON PRINTER.
           DISPLAY 'FILE3:' UW01FILE3-NAME  UPON PRINTER.

           PERFORM LB-MERGE.
       LA-EXIT.
           STOP RUN.
       LB-MERGE SECTION.
       LB-10.
           OPEN OUTPUT FILEMPAY.
           MOVE SPACES TO FILEMHREC.
           MOVE 'HDM'     TO FILEMHRECTYP.
           MOVE 'MRG'     TO FILEMHFILEMID.
           ACCEPT UW01APRWDAYR FROM DATE YYYYMMDD.
           MOVE UW01APRWDAYR TO FILEMHFILEMDT.
           WRITE FILEMHREC.
       LB-20.
           OPEN INPUT FILEPAY.
           MOVE 0 TO UW01CNTDR UW01TPYAMT.
           READ FILEPAY AT END
              DISPLAY 'FILE1 EMPTY ' UPON PRINTER
              GO TO LB-50.
           IF FILEHRECTYP NOT EQUAL TO 'HD1'
               DISPLAY 'HEADER RECORD MISSING FOR FILE1' UPON PRINTER
               GO TO LB-EXIT.
           IF FILEHFILEID NOT EQUAL TO 'FL1'
               DISPLAY 'INVALID FILE ID FOR FILE1' UPON PRINTER
               GO TO LB-EXIT.
       LB-30.
           MOVE SPACES TO FILEDREC.
           READ FILEPAY AT END
               DISPLAY 'TRAILER RECORD MISSING FILE1'UPON PRINTER
               GO TO LB-EXIT.
           IF  FILETRECTP = 'FT1'
               GO TO LB-40.
           IF  FILEDRECTYP NOT EQUAL TO 'DT1'
               DISPLAY 'INVALID RECORD TYPE FILE1'UPON PRINTER
               GO TO LB-EXIT.
           MOVE FILEDREC TO FILEMDREC.
           WRITE FILEMDREC.
           ADD 1 TO UW01CNTDR.
           ADD FILEDPAYAMT TO UW01TPYAMT.
           GO TO LB-30.
       LB-40.
           IF UW01CNTDR NOT EQUAL TO FILETNOREC
              DISPLAY 'RECORDS COUNT FAILURE FOR FILE1' UPON PRINTER
              GO TO LB-EXIT.
           IF UW01TPYAMT NOT EQUAL TO FILETTOTAMT
              DISPLAY 'PAYMENT AMOUNT FAILURE FOR FILE1' UPON PRINTER
              GO TO LB-EXIT.
           ADD FILETTOTAMT TO UW01TOTAMT.
           ADD FILETNOREC TO UW01CNTTR.
           CLOSE FILEPAY.
       LB-50.
           OPEN INPUT FILEPAY1.
           MOVE 0 TO UW01CNTDR UW01TPYAMT.
           READ FILEPAY1 AT END
              DISPLAY 'FILE2 EMPTY ' UPON PRINTER
              GO TO LB-80.
           IF FILE1HRECTYP NOT EQUAL TO 'HD2'
               DISPLAY 'HEADER RECORD MISSING FOR FILE2' UPON PRINTER
               GO TO LB-EXIT.
           IF FILE1HFILE1ID NOT EQUAL TO 'FL2'
               DISPLAY 'INVALID FILE ID FOR FILE2' UPON PRINTER
               GO TO LB-EXIT.
       LB-60.
           MOVE SPACES TO FILE1DREC.
           READ FILEPAY1 AT END
               DISPLAY 'TRAILER RECORD MISSING FILE2' UPON PRINTER
               GO TO LB-EXIT.
           IF  FILE1TRECTP = 'FT2'
                 GO TO LB-70.
           IF  FILE1DRECTYP NOT EQUAL TO 'DT2'
               DISPLAY 'INVALID RECORD TYPE FILE2' UPON PRINTER
               GO TO LB-EXIT.
           MOVE FILE1DREC TO FILEMDREC.
           WRITE FILEMDREC.
           ADD 1 TO UW01CNTDR.
           ADD FILE1DPAYAMT TO UW01TPYAMT.
           GO TO LB-60.
       LB-70.
           IF UW01CNTDR NOT EQUAL TO FILE1TNOREC
              DISPLAY 'RECORDS COUNT FAILURE FOR FILE2' UPON PRINTER
              GO TO LB-EXIT.
           IF UW01TPYAMT NOT EQUAL TO FILE1TTOTAMT
              DISPLAY 'PAYMENT AMOUNT FAILURE FOR FILE2' UPON PRINTER
              GO TO LB-EXIT.
           ADD FILE1TTOTAMT TO UW01TOTAMT.
           ADD FILE1TNOREC TO UW01CNTTR.
           CLOSE FILEPAY1.
       LB-80.
           MOVE 'FTM' TO FILEMTRECTP.
           MOVE UW01CNTTR TO FILEMTNOREC.
           MOVE '+' TO FILEMTSIGN.
           MOVE UW01TOTAMT TO FILEMTTOTAMT.
           WRITE FILEMTREC.
           CLOSE FILEMPAY.
           DISPLAY 'MERGE COMPLETED' UPON PRINTER.
       LB-EXIT.
           EXIT.
