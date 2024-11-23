table 50048 "PROC-Purchase Quote Header"
{
    Caption = 'PROC-Purchase Quote Header';
    LookupPageId = "PROC-Purchase Quote List";

    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = False;
        }
        field(3; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(4; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = Location.Code WHERE("Use As In-Transit" = filter(false));
        }
        field(5; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(6; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(7; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(8; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(9; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
        }
        field(10; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(11; "Expected Opening Date"; DateTime)
        {
            Caption = 'Expected Opening Date';
        }
        field(12; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(13; "Expected Closing Date"; DateTime)
        {
            Caption = 'Expected Closing Date';
        }
        field(14; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
        }
        field(15; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(16; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(17; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(19; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(20; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = filter(false));
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(23; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(24; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(25; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(26; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
        }
        field(27; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
        }
        field(28; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(29; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(30; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(31; Comment; Boolean)
        {
            Caption = 'Comment';
            FieldClass = FlowField;
            CalcFormula = Exist("Purch. Comment Line" WHERE("Document Type" = FIELD("Document Type"),
                                                             "No." = FIELD("No."),
                                                             "Document Line No." = CONST(0)));
            Editable = false;
        }
        field(32; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(33; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(34; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(35; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(36; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(37; Receive; Boolean)
        {
            Caption = 'Receive';
        }
        field(38; Invoice; Boolean)
        {
            Caption = 'Invoice';
        }
        field(39; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                            "Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"),
                                                                            "Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
        }
        field(42; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(43; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(44; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(45; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(46; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(47; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(48; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(49; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(51; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(52; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(53; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(54; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
        }
        field(55; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";
        }
        field(56; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(57; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(58; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(59; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(60; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(61; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(62; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(63; "Receiving No. Series"; Code[10])
        {
            Caption = 'Receiving No. Series';
            TableRelation = "No. Series";
        }
        field(64; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(65; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(66; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(67; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
        }
        field(68; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(69; Status; Option)
        {
            Caption = 'Status';
            //Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Closed,Cancelled,Stopped';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Closed,Cancelled,Stopped;
        }
        field(70; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(71; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(72; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';
        }
        field(73; "IC Status"; Option)
        {
            Caption = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(74; "Buy-from IC Partner Code"; Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(75; "Pay-to IC Partner Code"; Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(76; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(77; "Prepayment No."; Code[20])
        {
            Caption = 'Prepayment No.';
        }
        field(78; "Last Prepayment No."; Code[20])
        {
            Caption = 'Last Prepayment No.';
            TableRelation = "Purch. Inv. Header";
        }
        field(79; "Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No.';
        }
        field(80; "Last Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Last Prepmt. Cr. Memo No.';
            TableRelation = "Purch. Cr. Memo Hdr.";
        }
        field(81; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0:5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(82; "Prepayment No. Series"; Code[20])
        {
            Caption = 'Prepayment No. Series';
            TableRelation = "No. Series";
        }
        field(83; "Compress Prepayment"; Boolean)
        {
            Caption = 'Compress Prepayment';
            InitValue = true;
        }
        field(84; "Prepayment Due Date"; Date)
        {
            Caption = 'Prepayment Due Date';
        }
        field(85; "Prepmt. Cr. Memo No. Series"; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No. Series';
            TableRelation = "No. Series";
        }
        field(86; "Prepmt. Posting Description"; Text[100])
        {
            Caption = 'Prepmt. Posting Description';
        }
        field(87; "Prepmt. Pmt. Discount Date"; Date)
        {
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        field(88; "Prepmt. Payment Terms Code"; Code[10])
        {
            Caption = 'Prepmt. Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(89; "Prepmt. Payment Discount %"; Decimal)
        {
            Caption = 'Prepmt. Payment Discount %';
            DecimalPlaces = 0:5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(90; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }
        field(91; "Job Queue Status"; Option)
        {
            Caption = 'Job Queue Status';
            OptionCaption = ' ,Scheduled for Posting,Error,Posting';
            OptionMembers = " ","Scheduled for Posting",Error,Posting;
        }
        field(92; "Job Queue Entry ID"; Guid)
        {
            Caption = 'Job Queue Entry ID';
            Editable = false;
        }
        field(93; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            TableRelation = "Incoming Document";
        }
        field(94; "Creditor No."; Code[20])
        {
            Caption = 'Creditor No.';
        }
        field(95; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference';
        }
        field(96; "Payment Method Id"; Code[20])
        {
            Caption = 'Payment Method Id';
            TableRelation = "Payment Method";
        }
        field(97; "Procurement methods"; Enum "Proc-Procurement Methods")
        {
        }
        field(98; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(99; "Expected Opening Date II"; DateTime)
        {
        }
        field(100; "Expected Closing Date II"; DateTime)
        {
        }
        field(101; "Initiate Tier Two"; Boolean)
        {
        }
        field(102; "Professional Opinion"; Text[2000])
        {
        }
        field(103; "Awarded BId"; Code[10])
        {
            TableRelation = "Tender Submission Header"."No." where("Request for Quote No." = field("No."), "Bid Status" = filter("Fin Qualif"));
        }
        field(104; "Awarded Quote"; Code[10])
        {
            TableRelation = "Purchase Header"."No." where("Request for Quote No." = field("No."), "Quote Status" = filter("Fin Qualif"));
        }
        field(105; "Issue Order"; Boolean)
        {
        }
        field(106; "Bidder/Supplier"; Code[30])
        {
        }
        field(107; "captured by"; Code[30])
        {
        }
        field(108; "Order No."; Code[30])
        {
        }
        field(109; "Technical Evaluation"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(110; "Technical Passmark Score"; Decimal)
        {
            Editable = false;
            BlankZero = false;
            DecimalPlaces = 1;
            FieldClass = FlowField;
            CalcFormula = sum("Proc-Technical Qualif"."Maximum Score" where("No." = field("No.")));
        }
        field(111; "Demonistration Evaluation"; Option)
        {
            Caption = 'Demonstration Evaluation';
            OptionMembers = No,Yes;
        }
        field(112; "Demo Passmark Score"; Decimal)
        {
            BlankZero = false;
            DecimalPlaces = 1;
            FieldClass = FlowField;
            CalcFormula = sum("Proc-Demo Qualif"."Maximum Score" where("No." = field("No.")));
        }
        field(113; "Financial Evaluation Score"; Decimal)
        {
            Caption = 'Financial Evaluation Amount';
            FieldClass = FlowField;
            CalcFormula = sum("PROC-Purchase Quote Line"."Line Amount" where("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Editable = false;
        }
        field(114; "Post-Qualification"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(115; "Has Evaluation"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(116; "Preliminary Evaluation"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(117; "Financial Evaluation"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(118; "Evaluation Started"; Boolean)
        {
        }
        field(119; "Suppliers Category"; code[50])
        {
            TableRelation = "Preq Categories/Years"."Preq Category" where("Preq Year" = field("Prequalification Period"));
        }
        field(120; "Prequalification Period"; Code[30])
        {
            TableRelation = "Prequalification Years"."Preq Years";
        }
        field(121; "Category Description"; Text[2048])
        {
        }
        field(122; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code where(grouping = filter('P-QUOTE'));
        }
        field(123; "UserName"; Code[20])
        {
            Caption = 'Assigned User ID';
            TableRelation = "User Setup";
        }
        field(124; DocApprovalType; Option)
        {
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(125; "Created By"; Code[20])
        {
        }
        field(126; "Vendor Quote No."; Code[20])
        {
        }
        field(127; "Requisition No."; code[30])
        {
            TableRelation = "Purchase Header"."No." where("Document Type" = filter(Quote), DocApprovalType = filter(Requisition), Status = filter(Released), Archived = filter(false));
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Document Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            PurchSetup.GET();
            if Rec."Procurement methods" = Rec."Procurement methods"::"Direct Procurement" then
                "No." := NoSeriesMgt.GetNextNo(PurchSetup."Direct Procurement", 0D, True)
            else if Rec."Procurement methods" = Rec."Procurement methods"::"Restricted Tendering" then
                "No." := NoSeriesMgt.GetNextNo(PurchSetup."Restricted tendering", 0D, True)
            else if Rec."Procurement methods" = Rec."Procurement methods"::"Two Stage Tender" then
                "No." := NoSeriesMgt.GetNextNo(PurchSetup."Two stage Tender", 0D, True)
            else
                "No." := NoSeriesMgt.GetNextNo(PurchSetup."Quotation Request No", 0D, True);
        END;
    end;

    trigger OnModify()
    begin
        IF xRec."No." <> "No." THEN BEGIN
            PurchSetup.GET();
            if Rec."Procurement methods" = Rec."Procurement methods"::"Request for Quotation" then
                "No." := NoSeriesMgt.GetNextNo(PurchSetup."Quotation Request No", 0D, True)
            else if Rec."Procurement methods" = Rec."Procurement methods"::"Direct Procurement" then
                "No." := NoSeriesMgt.GetNextNo(PurchSetup."Direct Procurement", 0D, True)
            else if Rec."Procurement methods" = Rec."Procurement methods"::"Restricted Tendering" then
                "No." := NoSeriesMgt.GetNextNo(PurchSetup."Restricted tendering", 0D, True)
            else if Rec."Procurement methods" = Rec."Procurement methods"::"Two Stage Tender" then
                "No." := NoSeriesMgt.GetNextNo(PurchSetup."Two stage Tender", 0D, True)
            else if Rec."Procurement methods" = Rec."Procurement methods"::"Open Tendering" then
                "No." := NoSeriesMgt.GetNextNo(PurchSetup.Tender, 0D, True)
        END;
    end;

    procedure fetchVendors()
    var
        ven: Record "Preq Suppliers/Category";
        vengry: Record "Preq Suppliers/Category";
        RFQ: Record "PROC-Purchase Quote Header";
    begin
        RFQ.Reset();
        RFQ.SetRange("No.", Rec."No.");
        RFQ.SetRange("Suppliers Category", Rec."Suppliers Category");
        if RFQ.Find('-') then begin
            vengry.Reset();
            vengry.SetRange("Document No.", RFQ."No.");
            vengry.DeleteAll();

            ven.Reset();
            ven.SetRange("Preq Category", RFQ."Suppliers Category");
            if ven.Find('-') then begin
                repeat
                    ven.CalcFields("Supplier Name", Phone, Email);
                    vengry.Init();
                    vengry."Document No." := RFQ."No.";
                    vengry.Supplier_Code := ven.Supplier_Code;
                    vengry."Supplier Name" := ven."Supplier Name";
                    vengry.Email := ven.Email;
                    vengry.Phone := ven.Phone;
                    vengry."Preq Year" := ven."Preq Year";
                    vengry.Insert();
                until ven.Next() = 0;
            end;
        end;
    end;

    procedure PreliminaryChecks()
    var
        techQual: Record "Proc-Technical Qualif";
    begin
        if Rec."Technical Evaluation" = Rec."Technical Evaluation"::Yes then begin
            if "Technical Passmark Score" <= 0 then Error('Technical Passmark has to be above zero');
            if "Technical Passmark Score" > 100 then Error('Technical Passmark has to be 100 and below');
        end;
        if Rec."Demonistration Evaluation" = Rec."Demonistration Evaluation"::Yes then begin
            if "Demo Passmark Score" <= 0 then Error('Demo Passmark has to be above zero');
            if "Demo Passmark Score" > 100 then Error('Technical Passmark has to be 100 and below');
        end;
        techQual.Reset();
        techQual.SetRange("No.", Rec."No.");
        if techQual.Find('-') then begin
            repeat
                if techQual."Maximum Score" <= 0 then
                    Error('%1%2%3%4%5', 'Technical Requirement ', techQual.Description, ' has to have a maximum score ');
            until techQual.Next() = 0;
        end;
    end;

    var
        eval: Record "Proc Evaluation Report";
        confrm: Record "Proc-Confirm Recommended";
        committe: Record "Proc-Committee Membership";
        Pheader: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ClassReq: Record "Proc Classification Requiremnt";
        PreliQual: Record "Proc-Preliminary Qualif";
}