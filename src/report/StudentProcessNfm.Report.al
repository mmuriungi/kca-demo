#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 78095 "Student Process Nfm"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(StudNo; Customer."No.")
            {
            }
            column(StudName; Customer.Name)
            {
            }
            column(campus; Customer."Global Dimension 1 Code")
            {
            }
            column(ProgName; Progs.Description)
            {
            }
            column(Progs; ACACourseRegistration.Programmes)
            {
            }
            column(Semesters; ACACourseRegistration.Semester)
            {
            }
            column(Stages; ACACourseRegistration.Stage)
            {
            }
            column(Settlement; ACACourseRegistration."Settlement Type")
            {
            }
            column(AcadYear; ACACourseRegistration."Academic Year")
            {
            }
            column(compName; CompanyInformation.Name)
            {
            }
            column(address; CompanyInformation.Address + ',' + CompanyInformation."Address 2")
            {
            }
            column(phones; CompanyInformation."Phone No." + '/' + CompanyInformation."Phone No. 2")
            {
            }
            column(pics; CompanyInformation.Picture)
            {
            }
            column(mails; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(Balance_NFMStatementEntry; Fbalance)
            {
            }
            dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Customer No.", "Posting Date") order(ascending) where("Entry Type" = filter("Initial Entry"));
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(pDate; CustLedgerEntry."Posting Date")
                {
                }
                column(DocNo; CustLedgerEntry."Document No.")
                {
                }
                column(Desc; CopyStr(CustLedgerEntry.Description, 1, 35) + CustLedgerEntry."External Document No.")
                {
                }
                column(Amount; TotalAmount)
                {
                }
                column(DebitAm; DebitAmount)
                {
                }
                column(CreditAm; CreditAmount)
                {
                }
                column(Semester; Semester)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Gl: Code[25];
                begin
                    //runningBal:=runningBal+"Detailed Cust. Ledg. Entry"."Debit Amount"-"Detailed Cust. Ledg. Entry"."Credit Amount";
                    ignore := FALSE;
                    Semester := '';
                    IF "Detailed Cust. Ledg. Entry".Amount <> 0 THEN BEGIN
                        GlEntry.RESET;
                        GlEntry.SETRANGE("Document No.", "Detailed Cust. Ledg. Entry"."Document No.");
                        GlEntry.SETFILTER("G/L Account No.", '%1|%2', '30008', '30004', '60086');
                        IF GlEntry.FINDFIRST THEN CurrReport.SKIP;
                    END;



                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETRANGE(CustLedgerEntry."Entry No.", "Detailed Cust. Ledg. Entry"."Cust. Ledger Entry No.");
                    IF CustLedgerEntry.FIND('-') THEN BEGIN
                        IF (CustLedgerEntry.Reversed OR CustLedgerEntry."Skip Nfm") THEN CurrReport.SKIP;
                    END;
                    Gl := '';
                    IF "Detailed Cust. Ledg. Entry"."Debit Amount" <> 0 THEN BEGIN
                        GlEntry.RESET;
                        GlEntry.SETRANGE("Document No.", "Detailed Cust. Ledg. Entry"."Document No.");
                        GlEntry.SETFILTER("G/L Account No.", '%1|%2|%3|%4|%5|%6|%7|%8', '60055', '60090', '60092', '60096', '60098', '60130', '60075', '60086');
                        IF GlEntry.FINDFIRST THEN BEGIN
                            ignore := TRUE;
                            Gl := GlEntry."G/L Account No.";
                        END;
                    END;
                    IF "Detailed Cust. Ledg. Entry"."Document No." IN ['KUCCPS', 'CUE', 'ID'] THEN BEGIN

                        ignore := TRUE;
                    END;
                    DebitAmount := 0;
                    CreditAmount := 0;
                    TotalAmount := 0;
                    HefProcessingFee := 0;
                    DebitAmount := "Detailed Cust. Ledg. Entry".Amount;
                    CreditAmount := "Detailed Cust. Ledg. Entry"."Credit Amount";
                    TotalAmount := "Detailed Cust. Ledg. Entry".Amount;
                    IF DebitAmount > 0 THEN BEGIN
                        AbsAmount := ABS("Detailed Cust. Ledg. Entry".Amount);
                        // MESSAGE('NO. %1 date %2 amt %3',"Detailed Cust. Ledg. Entry"."Customer No.","Detailed Cust. Ledg. Entry"."Posting Date",AbsAmount);

                        StdCharges.RESET;
                        StdCharges.SETRANGE("Student No.", "Detailed Cust. Ledg. Entry"."Customer No.");
                        //           StdCharges.SETRANGE(Date,"Detailed Cust. Ledg. Entry"."Posting Date");
                        StdCharges.SETRANGE("Transacton ID", "Detailed Cust. Ledg. Entry"."Document No.");
                        IF StdCharges.FINDFIRST THEN BEGIN
                            Bandentry.RESET;
                            Bandentry.SETRANGE("Student No.", Customer."No.");
                            Bandentry.SETRANGE(Semester, StdCharges.Semester);
                            Bandentry.SETRANGE(Archived, FALSE);
                            Bandentry.SETCURRENTKEY("Batch No.");
                            IF Bandentry.FIND('-') THEN BEGIN
                                HshldPerc := Bandentry."HouseHold Percentage";
                            END;
                            Semester := StdCharges.Semester;
                            Sems.RESET;
                            Sems.SETRANGE(Sems.Code, Semester);
                            IF Sems.FINDFIRST THEN BEGIN
                                HefProcessingFee := Sems."HEF Processing Fee";
                            END;
                        END ELSE BEGIN
                            IF "Detailed Cust. Ledg. Entry"."Document No." = 'TUITION' THEN BEGIN
                                Semester := 'SEM1 24/25';
                            END;
                        END;
                    END;
                    IF ("Detailed Cust. Ledg. Entry".Amount = (Bandentry."Programme Cost" / 2)) OR (NOT ignore) THEN BEGIN
                        Bandentry.RESET;
                        Bandentry.SETRANGE("Student No.", Customer."No.");
                        Bandentry.SETRANGE(Archived, FALSE);
                        Bandentry.SETRANGE(Semester, Semester);
                        Bandentry.SETCURRENTKEY("Batch No.");
                        IF Bandentry.FIND('-') THEN BEGIN
                            HshldPerc := Bandentry."HouseHold Percentage";
                        END;
                        //      IF HshldPerc=0 THEN BEGIN
                        //      bands.RESET;
                        //      bands.SETRANGE(bands."Band Code",Bandentry."Band Code");
                        //      bands.SETRANGE("Academic Year",Bandentry."Academic Year");
                        //      IF bands.FINDLAST THEN BEGIN
                        //        HshldPerc:=bands."Household Percentage";
                        //        END;
                        //      END;
                        IF (HshldPerc <> 0) THEN BEGIN
                            IF DebitAmount > 0 THEN BEGIN
                                DebitAmount := ((HshldPerc / 100) * DebitAmount);
                            END
                            ELSE
                                DebitAmount := 0;
                            TotalAmount := (HshldPerc / 100) * TotalAmount;
                        END;
                    END;

                    IF (DebitAmount > 0) OR ignore AND (Semester = '') THEN BEGIN
                        IF ("Detailed Cust. Ledg. Entry"."Document No." IN ['KUCCPS', 'CUE', 'ID']) OR ignore THEN BEGIN
                            CosReg.RESET;
                            CosReg.SETRANGE("Student No.", "Detailed Cust. Ledg. Entry"."Customer No.");
                            CosReg.SETCURRENTKEY(Semester);
                            IF CosReg.FINDFIRST THEN BEGIN
                                Semester := CosReg.Semester;
                            END;
                        END;
                    END;
                    //MESSAGE('added %1 fee %2',ProcessingfeeAdded,HefProcessingFee);
                    IF (Lastsemester <> Semester) AND (HefProcessingFee <> 0) AND (Semester <> '') AND (NOT ignore) THEN BEGIN
                        DebitAmount += HefProcessingFee;
                        TotalAmount += HefProcessingFee;
                        //          MESSAGE('procfee %1',HefProcessingFee);
                        ProcessingfeeAdded := TRUE;
                        Lastsemester := Semester;
                    END;

                    NfmEntry.INIT;
                    NfmEntry."Student No." := "Detailed Cust. Ledg. Entry"."Customer No.";
                    NfmEntry."Entry No" := 0;
                    NfmEntry."Credit amount" := CreditAmount;
                    IF DebitAmount > 0 THEN
                        NfmEntry."Debit amount" := DebitAmount;
                    IF DebitAmount > 0 THEN BEGIN
                        TotalAmount := DebitAmount;
                        NfmEntry.Description := 'Student Household Charges for Semester: ' + Semester;
                        NfmEntry.Type := NfmEntry.Type::Debit;
                        IF ignore THEN BEGIN
                            NfmEntry.Description := CustLedgerEntry.Description;
                            NfmEntry.Type := NfmEntry.Type::Credit;
                            //message('aye %1',CustLedgerEntry.Description);
                        END;
                    END
                    ELSE IF CreditAmount <> 0 THEN BEGIN
                        TotalAmount := (ABS(CreditAmount)) * -1;
                        NfmEntry.Description := COPYSTR(CustLedgerEntry.Description, 1, 50) + CustLedgerEntry."External Document No.";
                        NfmEntry.Type := NfmEntry.Type::Credit;
                    END;
                    //  IF Semester='' THEN BEGIN
                    //  NfmEntry.Description:="Detailed Cust. Ledg. Entry"."Document No."+' '+COPYSTR(CustLedgerEntry.Description,1,50)+CustLedgerEntry."External Document No.";
                    //  END;
                    NfmEntry.Semester := Semester;
                    NfmEntry.Amount := TotalAmount;
                    NfmEntry.Date := "Detailed Cust. Ledg. Entry"."Posting Date";
                    IF NfmEntry.Type = NfmEntry.Type::Debit THEN BEGIN
                        NfmEntryII.RESET;
                        NfmEntryII.SETRANGE(NfmEntryII."Student No.", "Detailed Cust. Ledg. Entry"."Customer No.");
                        NfmEntryII.SETRANGE(NfmEntryII.Semester, Semester);
                        NfmEntryII.SETRANGE(NfmEntryII.Type, NfmEntry.Type::Debit);
                        IF NfmEntryII.FINDFIRST THEN BEGIN
                            NfmEntryII.Amount += TotalAmount;
                            NfmEntryII."Credit amount" += CreditAmount;
                            NfmEntryII."Debit amount" += DebitAmount;
                            NfmEntryII.MODIFY();
                        END ELSE
                            NfmEntry.INSERT(TRUE);
                    END ELSE
                        NfmEntry.INSERT(TRUE);
                    COMMIT;
                end;
            }
            dataitem("Nfm Statement Entry"; "Nfm Statement Entry")
            {
                CalcFields = Balance;
                DataItemLink = "Student No." = field("No.");
                column(ReportForNavId_1000000025; 1000000025)
                {
                }
                column(EntryNo_NFMStatementEntrys; "NFM Statement Entry"."Entry No")
                {
                }
                column(StudentNo_NFMStatementEntry; "NFM Statement Entry"."Student No.")
                {
                }
                column(Description_NFMStatementEntry; "NFM Statement Entry".Description)
                {
                }
                column(Amount_NFMStatementEntry; "NFM Statement Entry".Amount)
                {
                }
                column(Semester_NFMStatementEntry; "NFM Statement Entry".Semester)
                {
                }
                column(Date_NFMStatementEntry; "NFM Statement Entry".Date)
                {
                }
                column(Debitamount_NFMStatementEntry; "NFM Statement Entry"."Debit amount")
                {
                }
                column(Creditamount_NFMStatementEntry; "NFM Statement Entry"."Credit amount")
                {
                }
                column(runningBal; runningBal)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalAmount := "NFM Statement Entry".Amount;
                    runningBal := runningBal + TotalAmount;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(runningBal);
                ACACourseRegistration.Reset;
                ACACourseRegistration.SetRange(ACACourseRegistration."Student No.", Customer."No.");
                ACACourseRegistration.SetFilter(ACACourseRegistration.Programmes, '<>%1', '');
                ACACourseRegistration.SetFilter(ACACourseRegistration.Reversed, '=%1', false);
                ACACourseRegistration.SetFilter(ACACourseRegistration.Transfered, '=%1', false);
                ACACourseRegistration.SetCurrentkey(Stage);
                if ACACourseRegistration.Find('+') then begin
                    Progs.Reset;
                    Progs.SetRange(Code, ACACourseRegistration.Programmes);
                    if Progs.Find('-') then begin
                    end;
                end;

                NfmEntry.Reset;
                NfmEntry.SetRange("Student No.", Customer."No.");
                NfmEntry.DeleteAll();
                ProcessingfeeAdded := true;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.Reset;
        if CompanyInformation.Find('-') then begin
            CompanyInformation.CalcFields(Picture);
        end;
    end;

    var
        runningBal: Decimal;
        ACACourseRegistration: Record "ACA-Course Registration";
        Progs: Record "ACA-Programme";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CompanyInformation: Record "Company Information";
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        bands: Record "Funding Band Categories";
        Bandentry: Record "Funding Band Entries";
        HshldPerc: Decimal;
        TotalAmount: Decimal;
        GlEntry: Record "G/L Entry";
        NfmEntry: Record "NFM Statement Entry";
        StdCharges: Record "ACA-Std Charges";
        ignore: Boolean;
        Semester: Code[25];
        AbsAmount: Decimal;
        NfmEntryII: Record "NFM Statement Entry";
        Balance: Decimal;
        CosReg: Record "ACA-Course Registration";
        Fbalance: Decimal;
        HefProcessingFee: Decimal;
        Sems: Record "ACA-Semesters";
        ProcessingfeeAdded: Boolean;
        Lastsemester: Code[25];
}

