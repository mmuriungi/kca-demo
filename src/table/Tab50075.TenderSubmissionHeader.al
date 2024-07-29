table 50075 "Tender Submission Header"
{
    Caption = 'Tender Submission Header';
    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
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
            trigger OnValidate()
            var
                theader: Record "Tender Header";
                tline: Record "Tender Lines";
                tsheader: Record "Tender Submission Header";
                tsline: Record "Tender Submission Lines";
                countedRec: Integer;
            begin
                Rec.TestField("Bidder No");
                theader.Reset();
                theader.SetRange("No.", rec."Tender No.");
                if theader.Find('-') then begin
                    Rec."Posting Description" := theader."Posting Description";
                    Rec."Expected Closing Date" := theader."Expected Closing Date";
                    Rec."Expected Opening Date" := theader."Expected Opening Date";
                    Rec."Location Code" := theader."Location Code";

                    tsline.Reset();
                    tsline.SetRange("No.", Rec."No.");
                    tsline.DeleteAll();

                    tline.Reset();
                    tline.SetRange("Document No.", Rec."Tender No.");
                    if tline.Find('-') then begin
                        repeat
                            countedRec := tsline.COUNT + 1;
                            //countedRec := 1;
                            tsline.Init();
                            tsline."Document Type" := tline."Document Type";
                            tsline."Document No." := Rec."No.";
                            tsline."Line No." := countedRec;
                            tsline.Type := tline.Type;
                            tsline."No." := tline."No.";
                            tsline.Validate("No.");
                            tsline."Location Code" := tline."Location Code";
                            tsline.Validate("Location Code");
                            tsline.Description := tline.Description;
                            tsline.Quantity := tline.Quantity;
                            tsline.Validate(Quantity);
                            tsline."Unit of Measure" := tline."Unit of Measure";
                            tsline."Tender No." := Rec."Tender No.";
                            tsline.Insert();
                        until tline.Next() = 0;
                    end;
                end;

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

        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = Location.Code WHERE("Use As In-Transit" = filter(false));
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(19; "Expected Opening Date"; DateTime)
        {
            Caption = 'Expected Opening Date';
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(21; "Expected Closing Date"; DateTime)
        {
            Caption = 'Expected Closing Date';
        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = filter(false));
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(31; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';

            trigger OnValidate()
            var
                PurchLine: Record "Purchase Line";
                Currency: Record "Currency";
                RecalculatePrice: Boolean;
            begin
            end;
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(43; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
            //ApprovalEntry: Record "454";
            begin
            end;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Purch. Comment Line" WHERE("Document Type" = FIELD("Document Type"),
                                                             "No." = FIELD("No."), "Document Line No." = CONST(0)));
            Caption = 'Comment';
            Editable = false;

        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(57; Receive; Boolean)
        {
            Caption = 'Receive';
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                            "Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"),
                                                                            "Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(64; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(95; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';

            trigger OnValidate()
            var
                PayToVend: Record Vendor;
            begin
            end;
        }
        field(97; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(109; "Receiving No. Series"; Code[10])
        {
            Caption = 'Receiving No. Series';
            TableRelation = "No. Series";
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(118; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempVendLedgEntry: Record 25;
            begin
            end;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                ChangeLogMgt: Codeunit "Change Log Management";
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
            end;
        }
        field(120; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Closed,Cancelled,Stopped;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';
        }
        field(124; "IC Status"; Option)
        {
            Caption = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(125; "Buy-from IC Partner Code"; Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126; "Pay-to IC Partner Code"; Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(127; "Technical Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Technical Reqs"."Maximum Score" where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
        }
        field(128; "Technical Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Technical Reqs".score where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
        }
        field(129; "Technical Percentage"; Decimal)
        {

        }
        field(130; "Demo Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Demo Reqs"."Maximum Score" where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
        }
        field(131; "Demo  Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Demo Reqs".Score where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
        }
        field(132; "Demo Percentage"; Decimal)
        {

        }
        field(133; "Financial Budgeted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Fin Reqs"."Budgeted Value" where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));
        }
        field(134; "Financial Quoted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Tender Bidder Fin Reqs"."Quoted Amount" where("Tender No." = field("Tender No."),
            "Bid No." = field("No."), "Bidder No." = field("Bidder No")));

        }
        field(135; "Financial Variation"; Decimal)
        {

        }

        field(136; "Technical Proposal Path"; Text[100])
        {

        }
        field(137; "Financial Proposal Path"; Text[100])
        {

        }
        field(138; "Financial Quoted Amount2"; Decimal)
        {

        }
        field(139; "Minimum Quoted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = min("Tender Bidder Fin Reqs"."Total Bid Amount" where("Tender No." = field("Tender No.")));

        }

        field(151; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }

        field(152; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }

        field(153; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }

        field(154; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }

        field(155; "Created By"; Code[20])
        {
        }
        field(156; "Request for Quote No."; code[20])
        {

        }
        field(157; "Procurement methods"; Enum "Proc-Procurement Methods")
        {

        }




    }

    keys
    {
        key(Key1; "No.", "Bidder No", "Tender No.")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Check if the number has been inserted by the user
        IF "No." = '' THEN BEGIN
            PurchSetup.RESET;
            PurchSetup.GET();
            PurchSetup.TESTFIELD(PurchSetup."Bid No.");
            NoSeriesMgt.InitSeries(PurchSetup."Bid No.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        IF xRec."No." <> "No." THEN BEGIN
            PurchSetup.GET();
            NoSeriesMgt.TestManual(PurchSetup."Bid No.");
        END;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}