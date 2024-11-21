tableextension 50010 "Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(56601; Copied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56602; "Debit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56603; "Procurement Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56604; "Invoice Amount"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Sum("Purchase Line"."Line Amount"
            WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));


        }
        field(56605; "Request No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56606; Commited; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56607; Department; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = Filter('Department'));
        }
        field(56608; "Delivery No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(56609; "Ledger Card No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(56610; "PRN No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(56611; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Purchasing,Finance,Admin,Completed';
            OptionMembers = New,Purchasing,Finance,Admin,Completed;
        }
        field(56612; "PO Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(56613; "Finance Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(56614; "Admin Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(56615; "P.O Name"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(56616; "P.O Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56617; "Finance Approved By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(56618; "Finance Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56619; "Admin Approved By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(56620; "Admin Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56621; "Contract No."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(56622; "Quotation No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(56623; "Request for Quote No."; Code[15])
        {
            //DataClassification = ToBeClassified;
            TableRelation = "PROC-Purchase Quote Header"."No."; //WHERE(Status = CONST(Released));
            trigger OnValidate()
            var
                RFQ: Record "PROC-Purchase Quote Header";
                RFQ_Line: Record "PROC-Purchase Quote Line";
                countedRec: Integer;
                PurchLine: Record "Purchase Line";
            begin
                //CHECK WHETHER HAS LINES AND DELETE
                IF NOT CONFIRM('If you change the Request for Quote No. the current lines will be deleted. Do you want to continue?', FALSE)
                THEN
                    ERROR('You have selected to abort the process');

                PurchLine.RESET;
                PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                PurchLine.DELETEALL;

                RFQ_Line.RESET;
                RFQ_Line.SETRANGE(RFQ_Line."Document No.", "Request for Quote No.");
                IF RFQ_Line.FIND('-') THEN BEGIN
                    REPEAT
                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document No.", "No.");
                        IF PurchLine.FIND('-') THEN BEGIN
                            countedRec := PurchLine.COUNT + 1;
                        END ELSE
                            countedRec := 1;
                        PurchLine.INIT;
                        PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                        PurchLine."Document No." := "No.";
                        PurchLine."Line No." := countedRec;
                        PurchLine.Type := RFQ_Line.Type;
                        //  PurchLine."Document Type 2":="Document Type 2";
                        PurchLine."No." := RFQ_Line."No.";
                        PurchLine.VALIDATE("No.");
                        PurchLine."Location Code" := RFQ_Line."Location Code";
                        PurchLine.VALIDATE("Location Code");
                        PurchLine.Quantity := RFQ_Line.Quantity;
                        PurchLine."Description 2" := RFQ_Line."Description 2";
                        PurchLine.VALIDATE(Quantity);
                        PurchLine."Direct Unit Cost" := RFQ_Line."Direct Unit Cost";
                        PurchLine.VALIDATE("Direct Unit Cost");
                        PurchLine.Amount := RFQ_Line.Amount;
                        PurchLine.INSERT;
                    UNTIL RFQ_Line.NEXT = 0;
                END;


            end;

        }
        field(56624; "Document Type 2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Requisition,Quote,"Order";
        }
        field(56625; "Tendor Number"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(56626; Allocation; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56627; Expenditure; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56628; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Departmental,Global';
            OptionMembers = " ",Departmental,Global;
        }
        field(56629; "Budgeted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56630; "Actual Expenditure"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56631; "Committed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56632; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56633; "Reference No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56634; "Refrence Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Employee,Student,Recruitment,Job';
            OptionMembers = Employee,Student,Recruitment,Job;
        }
        field(56635; "Quote Comments"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Store Comments of Purchase Quote in the DB (Added)';
        }
        field(56636; "Responsibility Center Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores Responsibilty Center Name in the database (Added)';
        }
        field(56637; "Donor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores Donor Name in the database (Added)';
        }
        field(56638; "Pillar Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores Pillar Name in the database (Added)';
        }
        field(56639; "Quote Comments 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56640; "Quote Comments 3"; Text[30])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(56641; "Recommendation 1"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56642; "Recommendation 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56643; "Project Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56644; "Archive Unused Doc"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56645; "VAT Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Expensed,Recovered';
            OptionMembers = Expensed,Recovered;
        }
        field(56646; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56647; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56648; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56649; DocApprovalType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Requisition,Quote,Capex;
        }
        field(56650; "Procurement Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56651; "Invoice Basis"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "PO Based","Direct Invoice";
        }
        field(56652; "RFQ No."; Code[20])
        {
            //DataClassification = ToBeClassified;
            TableRelation = "PROC-Purchase Quote Header";
            trigger OnValidate()
            var
                ProcProcess: Codeunit "Procurement Process";
            begin

            end;
        }
        field(56653; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56654; "Special Remark"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56655; "Responsible Officer"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56656; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,LPO,LSO';
            OptionMembers = " ",LPO,LSO;
        }
        field(56657; "Imprest Purchase Doc No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56658; "Manual LPO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56659; "Requisition No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Line".lost WHERE("Document No." = FIELD("No.")));

        }
        field(56660; "LPO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56661; Contract; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*  CALCFIELDS("Invoice Amount");
                  IF "Invoice Amount"<1000000 THEN ERROR('Please note that contract LPO is only applicable for LPOs with a value of 1million and above');
                  Status:=Status::Released;*/

            end;
        }
        field(56662; "Cum. Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56663; "Is Milk"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56664; Lost; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56665; "Recruitment Plan Code"; Code[100])
        {

        }
        field(5666006; "Quote Status"; Option)
        {

            OptionMembers = " ",Pending,"Fin Qualif","Recommended Award","Prelim qualif","Tech Qualf","Demo Qualif","Prelim Disqualif","Tech Disqualif","Demo Disqualif","Fin Disqualif",Submitted;
        }
        field(5666007; Archived; Boolean)
        {

        }
        field(5666008; "User Id"; code[20])
        {

        }
        field(5666009; "Bidder No."; code[20])
        {

        }
        field(5666010; "Expected Opening Date"; DateTime)
        {

        }
        field(5666011; "Expected Closing Date"; DateTime)
        {

        }
        field(5666012; "Memo No"; code[20])
        {

        }
        field(5666013; "Memo Description"; text[250])
        {

        }
        field(5666014; "Assigned Staff"; code[30])
        {

        }
        field(5666015; "Demo Evaluation"; Decimal)
        {

        }
        field(5666016; "Financial Score"; Decimal)
        {

        }
        field(5666017; "Technical Evaluation"; Decimal)
        {

        }
        field(5666018; "Assigned User ID 2"; code[30])
        {

        }
        field(5666019; "Winning Bid"; code[30])
        {

        }
        field(5666020; "Procurement method"; Enum "Proc-Procurement Methods")
        {

        }
        field(5666021; "PO Type"; Option)
        {
            OptionMembers = LPO,LSO;

        }
        field(5666022; "Procurement Plan No."; code[20])
        {
            TableRelation = "PROC-Procurement Plan Header"."Budget Name" where("Department Code" = field("Shortcut Dimension 2 Code"));
        }
        modify("Responsibility Center")
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnAfterValidate()
            begin
                if xRec."Responsibility Center" <> "Responsibility Center" then begin
                    RecreatePurchLines(FieldCaption("Responsibility Center"));
                    "Assigned User ID" := UserId;
                end;
            end;
        }
    }

    trigger OnInsert()
    var

    begin
        InitInsert2;

    end;

    trigger OnModify()
    var

    begin
        Rec.Reset();
        IF (DocApprovalType = DocApprovalType::Requisition) and ("No." = '') and ("Document Type 2" = "Document Type 2"::Requisition)
        And ("Document Type" = "Document Type"::Quote) THEN BEGIN
            PurchSetup.GET;
            PurchSetup.TESTFIELD(PurchSetup."Internal Requisition No.");
            NoSeriesMgt.InitSeries(PurchSetup."Internal Requisition No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;


    end;


    var
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SelectNoSeriesAllowed: Boolean;
        Vend: Record Vendor;




    procedure InitInsert2()
    var
        Noz: Code[20];

    begin
        IF "No." = '' THEN BEGIN
            CLEAR(Noz);
            TestNoSeries;
            // NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
            Noz := NoSeriesMgt.GetNextNo(GetNoSeriesCode, "Posting Date", TRUE);
            IF (Rec."Document Type" = Rec."Document Type"::Quote) and (Rec.DocApprovalType = Rec.DocApprovalType::Requisition) THEN BEGIN
                IF PurchSetup.GET THEN BEGIN
                    PurchSetup.TESTFIELD("Procurement Year Code");
                    Noz := Noz + '/' + PurchSetup."Procurement Year Code";

                END;
            END;
            "No." := Noz;
        END;

        InitRecord;
    end;



}

