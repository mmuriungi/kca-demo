report 50352 "Clearance Form (Report)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Clearance Form (Report).rdl';
    Caption = 'Customer - Statement';
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem6836; 18)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", Status;
            column(sAdmissionDate; "Admission Date")
            {
            }
            column(sNo; "No.")
            {
            }
            column(SName; UPPERCASE(Name))
            {
            }
            column(intake; "Intake Code")
            {
            }
            column(ProgEnd; "Programme End Date")
            {
            }
            column(status; Status)
            {
            }
            column(RefundonPV_Customer; "Refund on PV")
            {
            }
            column(Bal; "Balance (LCY)" + "Refund on PV")
            {
            }
            column(currProg; "Current Programme")
            {
            }
            column(currDate; TODAY)
            {
            }
            column(compName; 'MASENO UNIVERSITY P.O. BOX 15653 - 00503 MASENO TEL: +254-020-2071391')
            {
            }
            column(progName; Prog.Description)
            {
            }
            column(deptName; DeptName)
            {
            }
            column(LastInDate; LastInDate)
            {
            }
            column(footer1; footer1)
            {
            }
            column(footer2; footer2)
            {
            }
            column(footer3; footer3)
            {
            }
            column(class; "Class Code")
            {
            }
            dataitem(DataItem17; "ACA-Units/Subjects")
            {
                DataItemLink = "Programme Code" = FIELD("current programme");
                column(UnitName; Code + ': ' + Desription)
                {
                }
                // column(sNo2;"No.")
                // {
                // }
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(LastInDate);
                courseReg.RESET;
                CLEAR(progName);
                courseReg.SETRANGE(courseReg."Student No.", "No.");
                courseReg.SETFILTER(courseReg.Programmes, '<>%1', '');
                IF courseReg.FIND('+') THEN BEGIN
                    IF courseReg."Registration Date" <> 0D THEN LastInDate := courseReg."Registration Date";
                    //Prog.RESET;
                    //Prog.SETRANGE(Prog.Code,courseReg.Programme);
                    //IF Prog.FIND('-') THEN BEGIN
                    //progName:=UPPERCASE(Prog.Description);
                    //END;
                END;
                IF LastInDate = 0D THEN BEGIN
                    custledg.RESET;
                    custledg.SETRANGE(custledg."Customer No.", "No.");
                    IF custledg.FIND('-') THEN BEGIN
                        LastInDate := custledg."Posting Date";
                    END;
                END;

                CLEAR(DeptName);
                //CALCFIELDS("Student Programme");
                Prog.RESET;
                Prog.SETRANGE(Prog.Code, "Current Programme");
                IF Prog.FIND('-') THEN BEGIN
                    progName := UPPERCASE(Prog.Description);
                    DimVal.RESET;
                    DimVal.SETRANGE(DimVal."Dimension Code", 'DEPARTMENT');
                    DimVal.SETRANGE(DimVal.Code, Prog."Department Code");
                    IF DimVal.FIND('-') THEN BEGIN
                        DeptName := UPPERCASE(DimVal.Name);
                    END;
                END;
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

    var
        Faculty: Text[100];
        Prog: Record "ACA-Programme";
        ProgStages: Record "ACA-Programme Stages";
        courseReg: Record "ACA-Course Registration";
        progName: Text[250];
        clearance_Levels: Record "ACA-Clearance Level Codes";
        DeptName: Code[100];
        LastInDate: Date;
        DimVal: Record "Dimension Value";
        footer1: Label 'All Students, upon completing a course, must ensure that they have been cleared from all sections above. It is the student''s';
        footer2: Label 'responsibility to obtain clearance from all subject tutors and relevant officers. This Form when completed MUST be returned to the ';
        footer3: Label 'Academic REGISTRAR''S Office.';
        custledg: Record "Cust. Ledger Entry";
}

