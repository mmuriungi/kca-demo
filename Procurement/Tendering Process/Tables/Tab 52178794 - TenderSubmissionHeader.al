table 52178794 "Tender Submission Header"
{
    Caption = 'Tender Submission Header';
    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Procurement methods"; Enum "Proc-Procurement Methods")
        {

        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Bidder No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tender Applicants Registration"."No.";
        }
        field(5; "Tender No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tender Header"."No.";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                theader: Record "Tender Header";
                tline: Record "Tender Lines";
                tsheader: Record "Tender Submission Header";
                tsline: Record "Tender Submission Lines";
                countedRec: Integer;
            begin
                // Rec.TestField("Bidder No");
                // theader.Reset();
                // theader.SetRange("No.", rec."Tender No.");
                // if theader.Find('-') then begin
                //     Rec."Posting Description" := theader."Posting Description";
                //     Rec."Expected Closing Date" := theader."Expected Closing Date";
                //     Rec."Expected Opening Date" := theader."Expected Opening Date";
                //     Rec."Location Code" := theader."Location Code";

                //     tsline.Reset();
                //     tsline.SetRange("No.", Rec."No.");
                //     tsline.DeleteAll();

                //     tline.Reset();
                //     tline.SetRange("Document No.", Rec."Tender No.");
                //     if tline.Find('-') then begin
                //         repeat
                //             countedRec := tsline.COUNT + 1;
                //             //countedRec := 1;
                //             tsline.Init();
                //             tsline."Document Type" := tline."Document Type";
                //             tsline."Document No." := Rec."No.";
                //             tsline."Line No." := countedRec;
                //             tsline.Type := tline.Type;
                //             tsline."No." := tline."No.";
                //             tsline.Validate("No.");
                //             tsline."Location Code" := tline."Location Code";
                //             tsline.Validate("Location Code");
                //             tsline.Description := tline.Description;
                //             tsline.Quantity := tline.Quantity;
                //             tsline.Validate(Quantity);
                //             tsline."Unit of Measure" := tline."Unit of Measure";
                //             tsline."Tender No." := Rec."Tender No.";
                //             tsline.Insert();
                //         until tline.Next() = 0;
                //     end;
                // end;

            end;

        }

        field(6; "Preliminary Qualified"; Boolean)
        {

        }
        field(7; "Technical Qualified"; Boolean)
        {

        }
        field(8; "Demonstration Qualified"; Boolean)
        {

        }
        field(9; "Finance Qualified"; Boolean)
        {

        }
        field(10; "Bid Status"; Option)
        {
            OptionMembers = Pending,Submitted,"Prelim Qualif","Prelim Disqualif","Tech Qualf","Tech Disqualif","Demo Qualif","Demo Disqualif","Fin Qualif","Fin Disqualif","Recommeded Award";
        }
        field(11; "RFQ No."; Code[30])
        {

        }


        field(12; "Expected Opening Date"; DateTime)
        {
            Caption = 'Expected Opening Date';
        }
        field(13; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(14; "Expected Closing Date"; DateTime)
        {
            Caption = 'Expected Closing Date';
        }
        field(15; "Posting Description"; Text[500])
        {
            Caption = 'Posting Description';
        }


        field(16; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = filter(false));
        }
        field(17; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(19; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }

        field(20; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionMembers = Open,Released,"Pending Approval",Closed,Cancelled,Stopped;
        }

        field(21; "Technical Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Technical Reqs"."Maximum Score" where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
            Editable = false;
        }
        field(22; "Technical Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Technical Reqs".score where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
            Editable = false;
        }
        field(23; "Technical Percentage"; Decimal)
        {

        }
        field(24; "Demo Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Demo Reqs"."Maximum Score" where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
            Editable = false;
        }
        field(25; "Demo  Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Demo Reqs".Score where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
            Editable = false;
        }
        field(26; "Demo Percentage"; Decimal)
        {

        }
        field(27; "Financial Budgeted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Fin Reqs"."Budgeted Value" where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
            Editable = false;
        }
        field(28; "Financial Quoted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Fin Reqs"."Quoted Amount" where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
            Editable = false;
        }
        field(29; "Financial Variation"; Decimal)
        {

        }

        field(30; "Technical Proposal Path"; Text[100])
        {

        }
        field(31; "Financial Proposal Path"; Text[100])
        {

        }
        field(32; "Financial Quoted Amount2"; Decimal)
        {

        }
        field(33; "Minimum Quoted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = min("Tender Bidder Fin Reqs"."Total Bid Amount" where("Tender No." = field("Tender No.")));
            Editable = false;
        }

        field(34; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }
        field(35; "No. Series"; Code[30])
        {

        }

        field(36; "Created By"; Code[20])
        {
        }
        field(37; "Request for Quote No."; Code[30])
        {
            TableRelation = "PROC-Purchase Quote Header"."No.";
            trigger OnValidate()
            var
                RFQ: Record "PROC-Purchase Quote Line";
                RFQ_Line: Record "PROC-Purchase Quote Line";
                countedRec: Integer;
                sbline: Record "Tender Submission Lines";
            begin

                sbline.RESET;
                sbline.SETRANGE(sbline."Document No.", "No.");
                sbline.DELETEALL;

                RFQ_Line.RESET;
                RFQ_Line.SETRANGE(RFQ_Line."Document No.", "Request for Quote No.");
                IF RFQ_Line.FIND('-') THEN BEGIN
                    REPEAT
                        sbline.RESET;
                        sbline.SETRANGE("Document No.", "No.");
                        IF sbline.FIND('-') THEN BEGIN
                            countedRec := sbline.COUNT + 1;
                        END ELSE
                            countedRec := 1;
                        sbline.INIT;
                        sbline."Document Type" := sbline."Document Type"::Quote;
                        sbline."Document No." := "No.";
                        sbline."Line No." := countedRec;
                        sbline."Type" := RFQ_Line."Type";
                        sbline."No." := RFQ_Line."No.";
                        sbline."RFQ No." := RFQ_Line."Document No.";
                        sbline.VALIDATE("No.");
                        sbline."Location Code" := RFQ_Line."Location Code";
                        sbline.VALIDATE("Location Code");
                        sbline.Quantity := RFQ_Line.Quantity;
                        sbline."Description 2" := RFQ_Line."Description 2";
                        sbline.VALIDATE(Quantity);
                        sbline."Direct Unit Cost" := RFQ_Line."Direct Unit Cost";
                        sbline.VALIDATE("Direct Unit Cost");
                        sbline.Amount := RFQ_Line.Amount;
                        sbline.INSERT;
                    UNTIL RFQ_Line.NEXT = 0;
                END;


            end;


        }
    }

    keys
    {
        key(Key1; "No.", "Bidder No", "Tender No.", "Request for Quote No.")
        {
            Clustered = true;
        }


    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            purpay.Get();
            "No." := NoSeriesMgt.GetNextNo(purpay."Tender Submission", 0D, True);
        END;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        purpay: Record "Purchases & Payables Setup";
}