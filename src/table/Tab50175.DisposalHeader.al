table 50175 "Disposal Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                /*
               //TEST IF MANUAL NOs ARE ALLOWED
               IF "No."<> xRec."No." THEN BEGIN
               PurchSetup.GET;
               NoSeriesMgt.TestManual(PurchSetup."Disposal Nos.");
               "No series" := '';
               END;   */

            end;
        }
        field(2; Desciption; Text[100])
        {
        }
        field(3; "Disposal Method"; Option)
        {
            OptionCaption = ' ,Open Tender,Public Auction,Trade-in,Transfer,Dumping';
            OptionMembers = " ","Open Tender","Public Auction","Trade-in",Transfer,Dumping;
        }
        field(4; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(5; "Disposal Status"; Option)
        {
            OptionMembers = " ",CEO,"Disposal Committee","Disposal implementation","Tender Committee",Disposed;
        }
        field(6; Date; Date)
        {
        }
        field(7; "No series"; Code[20])
        {
        }
        field(8; "Ref No"; Code[30])
        {
        }
        field(9; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(50000; Disposed; Boolean)
        {

            trigger OnValidate()
            begin
                /*Line.RESET;
                Line.SETRANGE(Line."No.","No.");
                //Line.SETRANGE(Line.Disposed,FALSE);
                IF Line.FIND('-')THEN BEGIN
                REPEAT
                Line.Disposed:=TRUE;
                  UNTIL Line.NEXT=0;
                  MODIFY;
                END;    */

                IF Disposed = TRUE THEN BEGIN
                    Line.RESET;
                    Line.SETRANGE(Line.No, "No.");
                    IF Line.FIND('-') THEN BEGIN
                        REPEAT
                            Line.Disposed := TRUE;
                            Line.MODIFY;
                        UNTIL Line.NEXT = 0;
                    END;
                END;

            end;
        }
        field(50001; "Shortcut dimension 2 code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50002; "Shortcut dimension 1 code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50003; "Disposal Period"; Code[20])
        {
            TableRelation = "Disposal Period".Code;

            trigger OnValidate()
            begin

                CLEAR(lastno);
                /*
               Line.RESET;
               Line.SETRANGE(Line."No.","No.");
               IF Line.FIND('-') THEN
               Line.DELETEALL;
               Line.RESET;
               //Line.SETCURRENTKEY(Line."Disposal Year");
               IF Line.FIND('+') THEN
               lastno:=Line."Line No.";
               IF lastno<>0 THEN lastno:=lastno+100 ELSE lastno:=100;
                 */

                DisposalPlanL.RESET;
                DisposalPlanL.SETRANGE(DisposalPlanL."Disposal Period", "Disposal Period");
                IF DisposalPlanL.FIND('-') THEN BEGIN
                    REPEAT

                        Line.INIT;
                        Line."Line No." := lastno;
                        Line."Disposal Plan No." := DisposalPlanL."Ref. No.";
                        Line.Description := DisposalPlanL."Item description";
                        Line."Unit of Measure" := DisposalPlanL."Unit of Issue";
                        Line."Serial No" := DisposalPlanL."Serial No";
                        //Line.VALIDATE("Unit of Measure");
                        Line."Planned Quantity" := DisposalPlanL.Quantity;
                        //Line."Shortcut dimension 1 code":=DisposalPlanL."Shortcut dimension 1 code";
                        //Line."Shortcut dimension 2 code":=DisposalPlanL."Shortcut dimension 2 code";
                        Line."Item/Tag No" := DisposalPlanL."Item/Tag No";
                        Header.Desciption := DisposalPlan.Description;
                        Header.Date := DisposalPlan.Date;
                        Line."No." := "No.";
                        Line."Disposal Period" := "Disposal Period";
                        Line.INSERT();
                    //lastno:=lastno+100;
                    //MESSAGE(FORMAT(lastno)+', '+FORMAT(DisposalPlanL."Ref. No.")+', '+DisposalPlanL."Item description");
                    UNTIL DisposalPlanL.NEXT = 0;



                END;

            end;
        }
        field(50004; "Disposal Plan No."; Code[20])
        {
            TableRelation = "Disposal Plan Table Header" WHERE(Status = FILTER(Approved));

            trigger OnValidate()
            begin
                DisposalPlanL.RESET;
                DisposalPlanL.SETRANGE(DisposalPlanL."Ref. No.", "Disposal Plan No.");
                IF DisposalPlanL.FIND('-') THEN BEGIN
                    //Delete Existing Lines
                    Line.RESET;
                    Line.SETRANGE(Line."No.", "No.");
                    IF Line.FIND('-') THEN Line.DELETEALL;

                    //Populate lines
                    LineNo := 0;
                    REPEAT
                        LineNo += 1;
                        Line."Line No." := LineNo;
                        Line.No := DisposalPlanL."No.";
                        Line.Description := DisposalPlanL."Item description";
                        Line.VALIDATE(Line."No.", "No.");
                        Line."Disposal Plan No." := "Disposal Plan No.";
                        Line."Planned Quantity" := DisposalPlanL.Quantity;
                        Line."Item/Tag No" := DisposalPlanL."Item/Tag No";

                        Line.INSERT;
                    UNTIL DisposalPlanL.NEXT = 0;
                END;
                //delete if this is blank
                IF "Disposal Plan No." = '' THEN BEGIN
                    Line.RESET;
                    Line.SETRANGE(Line."No.", "No.");
                    IF Line.FIND('-') THEN Line.DELETEALL;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Disposal Period", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        //GENERATE NEW NUMBER FOR THE DOCUMENT
        IF "No." = '' THEN BEGIN
            PurchSetup.GET;
            //PurchSetup.TESTFIELD(PurchSetup."Disposal Plan Nos.");
            //NoSeriesMgt.InitSeries(PurchSetup."Disposal Plan Nos.",xRec."No series",0D, "No.","No series");
        END;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        DisposalPlan: Record "Disposal Plan Table Header";
        DisposalPlanL: Record "Disposal plan table lines";
        Header: Record "Disposal Header";
        Line: Record "Disposal Line";
        lastno: Integer;
        LineNo: Integer;
}

